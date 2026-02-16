import 'package:flutter_test/flutter_test.dart';
import 'package:leblebi/src/domain/entities/conversation/conversation.dart';
import 'package:leblebi/src/domain/repositories/conversation_repository.dart';
import 'package:leblebi/src/domain/usecases/conversation/delete_conversation_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zuraffa/zuraffa.dart';

class MockConversationRepository extends Mock
    implements ConversationRepository {}

class MockConversation extends Mock implements Conversation {}

void main() {
  late DeleteConversationUseCase useCase;
  late MockConversationRepository mockRepository;
  setUp(() {
    registerFallbackValue(const DeleteParams<String>(id: '1'));
    mockRepository = MockConversationRepository();
    useCase = DeleteConversationUseCase(mockRepository);
  });
  group('DeleteConversationUseCase', () {
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
