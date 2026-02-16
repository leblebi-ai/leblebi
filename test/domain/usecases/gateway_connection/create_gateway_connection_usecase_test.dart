import 'package:flutter_test/flutter_test.dart';
import 'package:leblebi/src/domain/entities/gateway_connection/gateway_connection.dart';
import 'package:leblebi/src/domain/repositories/gateway_connection_repository.dart';
import 'package:leblebi/src/domain/usecases/gateway_connection/create_gateway_connection_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockGatewayConnectionRepository extends Mock
    implements GatewayConnectionRepository {}

class MockGatewayConnection extends Mock implements GatewayConnection {}

void main() {
  late CreateGatewayConnectionUseCase useCase;
  late MockGatewayConnectionRepository mockRepository;
  setUp(() {
    registerFallbackValue(MockGatewayConnection());
    mockRepository = MockGatewayConnectionRepository();
    useCase = CreateGatewayConnectionUseCase(mockRepository);
  });
  group('CreateGatewayConnectionUseCase', () {
    final tGatewayConnection = MockGatewayConnection();
    test('should call repository.create and return result', () async {
      when(
        () => mockRepository.create(any()),
      ).thenAnswer((_) async => tGatewayConnection);
      final result = await useCase(tGatewayConnection);
      verify(() => mockRepository.create(any())).called(1);
      expect(result.isSuccess, true);
      expect(
        result.getOrElse(() => throw (Exception())),
        equals(tGatewayConnection),
      );
    });
    test('should return Failure when repository throws', () async {
      final exception = Exception('Error');
      when(() => mockRepository.create(any())).thenThrow(exception);
      final result = await useCase(tGatewayConnection);
      verify(() => mockRepository.create(any())).called(1);
      expect(result.isFailure, true);
    });
  });
}
