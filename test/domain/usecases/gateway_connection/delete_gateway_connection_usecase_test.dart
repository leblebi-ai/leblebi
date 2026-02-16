import 'package:flutter_test/flutter_test.dart';
import 'package:leblebi/src/domain/entities/gateway_connection/gateway_connection.dart';
import 'package:leblebi/src/domain/repositories/gateway_connection_repository.dart';
import 'package:leblebi/src/domain/usecases/gateway_connection/delete_gateway_connection_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zuraffa/zuraffa.dart';

class MockGatewayConnectionRepository extends Mock
    implements GatewayConnectionRepository {}

class MockGatewayConnection extends Mock implements GatewayConnection {}

void main() {
  late DeleteGatewayConnectionUseCase useCase;
  late MockGatewayConnectionRepository mockRepository;
  setUp(() {
    registerFallbackValue(const DeleteParams<String>(id: '1'));
    mockRepository = MockGatewayConnectionRepository();
    useCase = DeleteGatewayConnectionUseCase(mockRepository);
  });
  group('DeleteGatewayConnectionUseCase', () {
    test('should call repository.delete and return result', () async {
      when(() => mockRepository.delete(any())).thenAnswer((_) async => {});
      final result = await useCase(DeleteParams<String>(id: '1'));
      verify(() => mockRepository.delete(any())).called(1);
      expect(result.isSuccess, true);
    });
    test('should return Failure when repository throws', () async {
      final exception = Exception('Error');
      when(() => mockRepository.delete(any())).thenThrow(exception);
      final result = await useCase(DeleteParams<String>(id: '1'));
      verify(() => mockRepository.delete(any())).called(1);
      expect(result.isFailure, true);
    });
  });
}
