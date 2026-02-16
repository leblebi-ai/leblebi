import 'package:flutter_test/flutter_test.dart';
import 'package:leblebi/src/domain/entities/tool_configuration/tool_configuration.dart';
import 'package:leblebi/src/domain/repositories/tool_configuration_repository.dart';
import 'package:leblebi/src/domain/usecases/tool_configuration/get_tool_configuration_list_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zuraffa/zuraffa.dart';

class MockToolConfigurationRepository extends Mock
    implements ToolConfigurationRepository {}

class MockToolConfiguration extends Mock implements ToolConfiguration {}

void main() {
  late GetToolConfigurationListUseCase useCase;
  late MockToolConfigurationRepository mockRepository;
  setUp(() {
    registerFallbackValue(const ListQueryParams<ToolConfiguration>());
    mockRepository = MockToolConfigurationRepository();
    useCase = GetToolConfigurationListUseCase(mockRepository);
  });
  group('GetToolConfigurationListUseCase', () {
    final tToolConfiguration = MockToolConfiguration();
    final tToolConfigurationList = [tToolConfiguration];
    test('should call repository.getList and return result', () async {
      when(
        () => mockRepository.getList(any()),
      ).thenAnswer((_) async => tToolConfigurationList);
      final result = await useCase(ListQueryParams<ToolConfiguration>());
      verify(() => mockRepository.getList(any())).called(1);
      expect(result.isSuccess, true);
      expect(
        result.getOrElse(() => throw (Exception())),
        equals(tToolConfigurationList),
      );
    });
    test('should return Failure when repository throws', () async {
      final exception = Exception('Error');
      when(() => mockRepository.getList(any())).thenThrow(exception);
      final result = await useCase(ListQueryParams<ToolConfiguration>());
      verify(() => mockRepository.getList(any())).called(1);
      expect(result.isFailure, true);
    });
  });
}
