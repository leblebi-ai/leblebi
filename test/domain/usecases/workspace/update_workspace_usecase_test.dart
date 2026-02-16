import 'package:flutter_test/flutter_test.dart';
import 'package:leblebi/src/domain/entities/workspace/workspace.dart';
import 'package:leblebi/src/domain/repositories/workspace_repository.dart';
import 'package:leblebi/src/domain/usecases/workspace/update_workspace_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zuraffa/zuraffa.dart';

class MockWorkspaceRepository extends Mock implements WorkspaceRepository {}

class MockWorkspace extends Mock implements Workspace {}

void main() {
  late UpdateWorkspaceUseCase useCase;
  late MockWorkspaceRepository mockRepository;
  setUp(() {
    registerFallbackValue(
      UpdateParams<String, Partial<Workspace>>(
        id: '1',
        data: Partial<Workspace>(),
      ),
    );
    mockRepository = MockWorkspaceRepository();
    useCase = UpdateWorkspaceUseCase(mockRepository);
  });
  group('UpdateWorkspaceUseCase', () {
    final tWorkspace = MockWorkspace();
    test('should call repository.update and return result', () async {
      when(
        () => mockRepository.update(any()),
      ).thenAnswer((_) async => tWorkspace);
      final result = await useCase(
        UpdateParams<String, Partial<Workspace>>(
          id: '1',
          data: Partial<Workspace>(),
        ),
      );
      verify(() => mockRepository.update(any())).called(1);
      expect(result.isSuccess, true);
      expect(result.getOrElse(() => throw (Exception())), equals(tWorkspace));
    });
    test('should return Failure when repository throws', () async {
      final exception = Exception('Error');
      when(() => mockRepository.update(any())).thenThrow(exception);
      final result = await useCase(
        UpdateParams<String, Partial<Workspace>>(
          id: '1',
          data: Partial<Workspace>(),
        ),
      );
      verify(() => mockRepository.update(any())).called(1);
      expect(result.isFailure, true);
    });
  });
}
