import 'package:flutter_test/flutter_test.dart';
import 'package:leblebi/src/domain/entities/gateway_connection/gateway_connection.dart';
import 'package:leblebi/src/domain/repositories/gateway_connection_repository.dart';
import 'package:leblebi/src/domain/usecases/gateway_connection/get_gateway_connection_list_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zuraffa/zuraffa.dart';

class MockGatewayConnectionRepository extends Mock
    implements GatewayConnectionRepository {}

class MockGatewayConnection extends Mock implements GatewayConnection {}

void main() {
  late GetGatewayConnectionListUseCase useCase;
  late MockGatewayConnectionRepository mockRepository;
  setUp(() {
    registerFallbackValue(const ListQueryParams<GatewayConnection>());
    mockRepository = MockGatewayConnectionRepository();
    useCase = GetGatewayConnectionListUseCase(mockRepository);
  });
  group('GetGatewayConnectionListUseCase', () {
    final tGatewayConnection = MockGatewayConnection();
    final tGatewayConnectionList = [tGatewayConnection];
    test('should call repository.getList and return result', () async {
      when(
        () => mockRepository.getList(any()),
      ).thenAnswer((_) async => tGatewayConnectionList);
      final result = await useCase(ListQueryParams<GatewayConnection>());
      verify(() => mockRepository.getList(any())).called(1);
      expect(result.isSuccess, true);
      expect(
        result.getOrElse(() => throw (Exception())),
        equals(tGatewayConnectionList),
      );
    });
    test('should return Failure when repository throws', () async {
      final exception = Exception('Error');
      when(() => mockRepository.getList(any())).thenThrow(exception);
      final result = await useCase(ListQueryParams<GatewayConnection>());
      verify(() => mockRepository.getList(any())).called(1);
      expect(result.isFailure, true);
    });
  });
}
