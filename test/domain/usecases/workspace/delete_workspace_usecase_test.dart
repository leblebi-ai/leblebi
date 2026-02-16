import 'package:flutter_test/flutter_test.dart';
import 'package:leblebi/src/domain/entities/workspace/workspace.dart';
import 'package:leblebi/src/domain/repositories/workspace_repository.dart';
import 'package:leblebi/src/domain/usecases/workspace/delete_workspace_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zuraffa/zuraffa.dart';

class MockWorkspaceRepository extends Mock implements WorkspaceRepository {}

class MockWorkspace extends Mock implements Workspace {}

void main() {
  late DeleteWorkspaceUseCase useCase;
  late MockWorkspaceRepository mockRepository;
  setUp(() {
    registerFallbackValue(const DeleteParams<String>(id: '1'));
    mockRepository = MockWorkspaceRepository();
    useCase = DeleteWorkspaceUseCase(mockRepository);
  });
  group('DeleteWorkspaceUseCase', () {
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
