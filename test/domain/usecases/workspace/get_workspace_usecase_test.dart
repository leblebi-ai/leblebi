import 'package:flutter_test/flutter_test.dart';
import 'package:leblebi/src/domain/entities/workspace/workspace.dart';
import 'package:leblebi/src/domain/repositories/workspace_repository.dart';
import 'package:leblebi/src/domain/usecases/workspace/get_workspace_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zuraffa/zuraffa.dart';

class MockWorkspaceRepository extends Mock implements WorkspaceRepository {}

class MockWorkspace extends Mock implements Workspace {}

void main() {
  late GetWorkspaceUseCase useCase;
  late MockWorkspaceRepository mockRepository;
  setUp(() {
    registerFallbackValue(const QueryParams<Workspace>());
    mockRepository = MockWorkspaceRepository();
    useCase = GetWorkspaceUseCase(mockRepository);
  });
  group('GetWorkspaceUseCase', () {
    final tWorkspace = MockWorkspace();
    test('should call repository.get and return result', () async {
      when(() => mockRepository.get(any())).thenAnswer((_) async => tWorkspace);
      final result = await useCase(QueryParams<Workspace>(params: {'id': '1'}));
      verify(() => mockRepository.get(any())).called(1);
      expect(result.isSuccess, true);
      expect(result.getOrElse(() => throw (Exception())), equals(tWorkspace));
    });
    test('should return Failure when repository throws', () async {
      final exception = Exception('Error');
      when(() => mockRepository.get(any())).thenThrow(exception);
      final result = await useCase(QueryParams<Workspace>(params: {'id': '1'}));
      verify(() => mockRepository.get(any())).called(1);
      expect(result.isFailure, true);
    });
  });
}
