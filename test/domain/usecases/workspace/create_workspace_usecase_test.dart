import 'package:flutter_test/flutter_test.dart';
import 'package:leblebi/src/domain/entities/workspace/workspace.dart';
import 'package:leblebi/src/domain/repositories/workspace_repository.dart';
import 'package:leblebi/src/domain/usecases/workspace/create_workspace_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockWorkspaceRepository extends Mock implements WorkspaceRepository {}

class MockWorkspace extends Mock implements Workspace {}

void main() {
  late CreateWorkspaceUseCase useCase;
  late MockWorkspaceRepository mockRepository;
  setUp(() {
    registerFallbackValue(MockWorkspace());
    mockRepository = MockWorkspaceRepository();
    useCase = CreateWorkspaceUseCase(mockRepository);
  });
  group('CreateWorkspaceUseCase', () {
    final tWorkspace = MockWorkspace();
    test('should call repository.create and return result', () async {
      when(
        () => mockRepository.create(any()),
      ).thenAnswer((_) async => tWorkspace);
      final result = await useCase(tWorkspace);
      verify(() => mockRepository.create(any())).called(1);
      expect(result.isSuccess, true);
      expect(result.getOrElse(() => throw (Exception())), equals(tWorkspace));
    });
    test('should return Failure when repository throws', () async {
      final exception = Exception('Error');
      when(() => mockRepository.create(any())).thenThrow(exception);
      final result = await useCase(tWorkspace);
      verify(() => mockRepository.create(any())).called(1);
      expect(result.isFailure, true);
    });
  });
}
