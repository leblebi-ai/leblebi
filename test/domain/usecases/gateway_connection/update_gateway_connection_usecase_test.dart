import 'package:flutter_test/flutter_test.dart';
import 'package:leblebi/src/domain/entities/gateway_connection/gateway_connection.dart';
import 'package:leblebi/src/domain/repositories/gateway_connection_repository.dart';
import 'package:leblebi/src/domain/usecases/gateway_connection/update_gateway_connection_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zuraffa/zuraffa.dart';

class MockGatewayConnectionRepository extends Mock
    implements GatewayConnectionRepository {}

class MockGatewayConnection extends Mock implements GatewayConnection {}

void main() {
  late UpdateGatewayConnectionUseCase useCase;
  late MockGatewayConnectionRepository mockRepository;
  setUp(() {
    registerFallbackValue(
      UpdateParams<String, Partial<GatewayConnection>>(
        id: '1',
        data: Partial<GatewayConnection>(),
      ),
    );
    mockRepository = MockGatewayConnectionRepository();
    useCase = UpdateGatewayConnectionUseCase(mockRepository);
  });
  group('UpdateGatewayConnectionUseCase', () {
    final tGatewayConnection = MockGatewayConnection();
    test('should call repository.update and return result', () async {
      when(
        () => mockRepository.update(any()),
      ).thenAnswer((_) async => tGatewayConnection);
      final result = await useCase(
        UpdateParams<String, Partial<GatewayConnection>>(
          id: '1',
          data: Partial<GatewayConnection>(),
        ),
      );
      verify(() => mockRepository.update(any())).called(1);
      expect(result.isSuccess, true);
      expect(
        result.getOrElse(() => throw (Exception())),
        equals(tGatewayConnection),
      );
    });
    test('should return Failure when repository throws', () async {
      final exception = Exception('Error');
      when(() => mockRepository.update(any())).thenThrow(exception);
      final result = await useCase(
        UpdateParams<String, Partial<GatewayConnection>>(
          id: '1',
          data: Partial<GatewayConnection>(),
        ),
      );
      verify(() => mockRepository.update(any())).called(1);
      expect(result.isFailure, true);
    });
  });
}
