import 'package:flutter_test/flutter_test.dart';
import 'package:leblebi/src/domain/entities/workspace/workspace.dart';
import 'package:leblebi/src/domain/repositories/workspace_repository.dart';
import 'package:leblebi/src/domain/usecases/workspace/get_workspace_list_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zuraffa/zuraffa.dart';

class MockWorkspaceRepository extends Mock implements WorkspaceRepository {}

class MockWorkspace extends Mock implements Workspace {}

void main() {
  late GetWorkspaceListUseCase useCase;
  late MockWorkspaceRepository mockRepository;
  setUp(() {
    registerFallbackValue(const ListQueryParams<Workspace>());
    mockRepository = MockWorkspaceRepository();
    useCase = GetWorkspaceListUseCase(mockRepository);
  });
  group('GetWorkspaceListUseCase', () {
    final tWorkspace = MockWorkspace();
    final tWorkspaceList = [tWorkspace];
    test('should call repository.getList and return result', () async {
      when(
        () => mockRepository.getList(any()),
      ).thenAnswer((_) async => tWorkspaceList);
      final result = await useCase(ListQueryParams<Workspace>());
      verify(() => mockRepository.getList(any())).called(1);
      expect(result.isSuccess, true);
      expect(
        result.getOrElse(() => throw (Exception())),
        equals(tWorkspaceList),
      );
    });
    test('should return Failure when repository throws', () async {
      final exception = Exception('Error');
      when(() => mockRepository.getList(any())).thenThrow(exception);
      final result = await useCase(ListQueryParams<Workspace>());
      verify(() => mockRepository.getList(any())).called(1);
      expect(result.isFailure, true);
    });
  });
}
