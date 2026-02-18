import 'package:zuraffa/zuraffa.dart';

import '../../domain/entities/message/message.dart';
import '../../domain/entities/gateway_connection/gateway_connection.dart';
import '../../domain/repositories/message_repository.dart';
import '../data_sources/message/message_local_data_source.dart';
import '../data_sources/message/message_remote_data_source.dart';

class DataMessageRepository
    with Loggable, FailureHandler
    implements MessageRepository {
  DataMessageRepository(this._localDataSource, this._remoteDataSource);

  final MessageLocalDataSource _localDataSource;
  final MessageRemoteDataSource _remoteDataSource;

  @override
  Future<Message> get(QueryParams<Message> params) {
    return _localDataSource.get(params);
  }

  @override
  Future<List<Message>> getList(ListQueryParams<Message> params) {
    return _localDataSource.getList(params);
  }

  @override
  Future<Message> create(Message message) {
    return _localDataSource.create(message);
  }

  @override
  Future<Message> update(UpdateParams<String, Partial<Message>> params) {
    return _localDataSource.update(params);
  }

  @override
  Future<void> delete(DeleteParams<String> params) {
    return _localDataSource.delete(params);
  }

  @override
  Stream<Message> watch(QueryParams<Message> params) {
    // For now, watch is not fully implemented for single item
    // Or we could implement it if Hive supports it.
    // Hive supports watch on box or key.
    throw UnimplementedError('watch not implemented');
  }

  @override
  Stream<List<Message>> watchList(ListQueryParams<Message> params) {
    return _localDataSource.watchList(params);
  }

  @override
  Future<Message> sendToAI(
    Message message,
    GatewayConnection connection,
  ) async {
    // 1. Save user message locally
    final userMsg = await _localDataSource.create(message);

    try {
      // 2. Send to AI
      final aiMsg = await _remoteDataSource.sendToAI(userMsg, connection);

      // 3. Save AI response locally
      return await _localDataSource.create(aiMsg);
    } catch (e) {
      // Handle error, maybe update message status to failed
      // For MVP just rethrow
      rethrow;
    }
  }
}
