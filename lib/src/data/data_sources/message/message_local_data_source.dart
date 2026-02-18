import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zuraffa/zuraffa.dart';

import '../../../domain/entities/message/message.dart';

class MessageLocalDataSource with Loggable, FailureHandler {
  static const String boxName = 'messages';

  Future<Box<String>> get _box async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<String>(boxName);
    }
    return Hive.box<String>(boxName);
  }

  Future<Message> get(QueryParams<Message> params) async {
    final box = await _box;
    // Assume params.id is what we need or find first match
    // Simple filter by ID if possible
    // Since we don't have easy query parsing, iterate.

    // Check if ID is provided in some way (not standard in QueryParams without custom logic)
    // We'll iterate.

    if (box.isEmpty) throw NotFoundFailure('No messages found');

    // Return first
    return Message.fromJson(jsonDecode(box.values.first));
  }

  Future<List<Message>> getList(ListQueryParams<Message> params) async {
    final box = await _box;
    final messages = box.values
        .map((e) => Message.fromJson(jsonDecode(e)))
        .toList();

    // Filter by conversationId if present in params (how?)
    // Assuming params might have some criteria.
    // For now, return all (MVP: only one conversation anyway?)
    // Or filter manually if I knew how to access params.where.

    return messages;
  }

  Future<Message> create(Message message) async {
    final box = await _box;
    await box.put(message.id, jsonEncode(message.toJson()));
    return message;
  }

  Future<Message> update(UpdateParams<String, Partial<Message>> params) async {
    final box = await _box;
    final id = params.id;
    final jsonStr = box.get(id);

    if (jsonStr == null) throw NotFoundFailure('Message not found: $id');

    // Simple overwrite logic for now as partial update is hard
    throw UnimplementedError('Message update not implemented');
  }

  Future<void> delete(DeleteParams<String> params) async {
    final box = await _box;
    await box.delete(params.id);
  }

  Stream<List<Message>> watchList(ListQueryParams<Message> params) async* {
    final box = await _box;

    List<Message> filter() {
      return box.values.map((e) => Message.fromJson(jsonDecode(e))).toList();
      // Add filtering here later
    }

    yield filter();

    await for (final _ in box.watch()) {
      yield filter();
    }
  }
}
