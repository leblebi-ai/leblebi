import 'package:flutter_test/flutter_test.dart';
import 'package:leblebi/src/domain/entities/gateway_connection/gateway_connection.dart';
import 'package:leblebi/src/domain/repositories/gateway_connection_repository.dart';
import 'package:leblebi/src/domain/usecases/gateway_connection/get_gateway_connection_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zuraffa/zuraffa.dart';

class MockGatewayConnectionRepository extends Mock
    implements GatewayConnectionRepository {}

class MockGatewayConnection extends Mock implements GatewayConnection {}

void main() {
  late GetGatewayConnectionUseCase useCase;
  late MockGatewayConnectionRepository mockRepository;
  setUp(() {
    registerFallbackValue(const QueryParams<GatewayConnection>());
    mockRepository = MockGatewayConnectionRepository();
    useCase = GetGatewayConnectionUseCase(mockRepository);
  });
  group('GetGatewayConnectionUseCase', () {
    final tGatewayConnection = MockGatewayConnection();
    test('should call repository.get and return result', () async {
      when(
        () => mockRepository.get(any()),
      ).thenAnswer((_) async => tGatewayConnection);
      final result = await useCase(
        QueryParams<GatewayConnection>(params: ({'id': '1'})),
      );
      verify(() => mockRepository.get(any())).called(1);
      expect(result.isSuccess, true);
      expect(
        result.getOrElse(() => throw (Exception())),
        equals(tGatewayConnection),
      );
    });
    test('should return Failure when repository throws', () async {
      final exception = Exception('Error');
      when(() => mockRepository.get(any())).thenThrow(exception);
      final result = await useCase(
        QueryParams<GatewayConnection>(params: ({'id': '1'})),
      );
      verify(() => mockRepository.get(any())).called(1);
      expect(result.isFailure, true);
    });
  });
}
