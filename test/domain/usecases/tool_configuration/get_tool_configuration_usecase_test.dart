import 'package:flutter_test/flutter_test.dart';
import 'package:leblebi/src/domain/entities/tool_configuration/tool_configuration.dart';
import 'package:leblebi/src/domain/repositories/tool_configuration_repository.dart';
import 'package:leblebi/src/domain/usecases/tool_configuration/get_tool_configuration_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zuraffa/zuraffa.dart';

class MockToolConfigurationRepository extends Mock
    implements ToolConfigurationRepository {}

class MockToolConfiguration extends Mock implements ToolConfiguration {}

void main() {
  late GetToolConfigurationUseCase useCase;
  late MockToolConfigurationRepository mockRepository;
  setUp(() {
    registerFallbackValue(const QueryParams<ToolConfiguration>());
    mockRepository = MockToolConfigurationRepository();
    useCase = GetToolConfigurationUseCase(mockRepository);
  });
  group('GetToolConfigurationUseCase', () {
    final tToolConfiguration = MockToolConfiguration();
    test('should call repository.get and return result', () async {
      when(
        () => mockRepository.get(any()),
      ).thenAnswer((_) async => tToolConfiguration);
      final result = await useCase(
        QueryParams<ToolConfiguration>(params: ({'id': '1'})),
      );
      verify(() => mockRepository.get(any())).called(1);
      expect(result.isSuccess, true);
      expect(
        result.getOrElse(() => throw (Exception())),
        equals(tToolConfiguration),
      );
    });
    test('should return Failure when repository throws', () async {
      final exception = Exception('Error');
      when(() => mockRepository.get(any())).thenThrow(exception);
      final result = await useCase(
        QueryParams<ToolConfiguration>(params: ({'id': '1'})),
      );
      verify(() => mockRepository.get(any())).called(1);
      expect(result.isFailure, true);
    });
  });
}
