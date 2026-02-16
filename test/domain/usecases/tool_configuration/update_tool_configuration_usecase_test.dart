import 'package:flutter_test/flutter_test.dart';
import 'package:leblebi/src/domain/entities/tool_configuration/tool_configuration.dart';
import 'package:leblebi/src/domain/repositories/tool_configuration_repository.dart';
import 'package:leblebi/src/domain/usecases/tool_configuration/update_tool_configuration_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zuraffa/zuraffa.dart';

class MockToolConfigurationRepository extends Mock
    implements ToolConfigurationRepository {}

class MockToolConfiguration extends Mock implements ToolConfiguration {}

void main() {
  late UpdateToolConfigurationUseCase useCase;
  late MockToolConfigurationRepository mockRepository;
  setUp(() {
    registerFallbackValue(
      UpdateParams<String, Partial<ToolConfiguration>>(
        id: '1',
        data: Partial<ToolConfiguration>(),
      ),
    );
    mockRepository = MockToolConfigurationRepository();
    useCase = UpdateToolConfigurationUseCase(mockRepository);
  });
  group('UpdateToolConfigurationUseCase', () {
    final tToolConfiguration = MockToolConfiguration();
    test('should call repository.update and return result', () async {
      when(
        () => mockRepository.update(any()),
      ).thenAnswer((_) async => tToolConfiguration);
      final result = await useCase(
        UpdateParams<String, Partial<ToolConfiguration>>(
          id: '1',
          data: Partial<ToolConfiguration>(),
        ),
      );
      verify(() => mockRepository.update(any())).called(1);
      expect(result.isSuccess, true);
      expect(
        result.getOrElse(() => throw (Exception())),
        equals(tToolConfiguration),
      );
    });
    test('should return Failure when repository throws', () async {
      final exception = Exception('Error');
      when(() => mockRepository.update(any())).thenThrow(exception);
      final result = await useCase(
        UpdateParams<String, Partial<ToolConfiguration>>(
          id: '1',
          data: Partial<ToolConfiguration>(),
        ),
      );
      verify(() => mockRepository.update(any())).called(1);
      expect(result.isFailure, true);
    });
  });
}
