import 'package:flutter_test/flutter_test.dart';
import 'package:leblebi/src/domain/entities/conversation/conversation.dart';
import 'package:leblebi/src/domain/repositories/conversation_repository.dart';
import 'package:leblebi/src/domain/usecases/conversation/get_conversation_list_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zuraffa/zuraffa.dart';

class MockConversationRepository extends Mock
    implements ConversationRepository {}

class MockConversation extends Mock implements Conversation {}

void main() {
  late GetConversationListUseCase useCase;
  late MockConversationRepository mockRepository;
  setUp(() {
    registerFallbackValue(const ListQueryParams<Conversation>());
    mockRepository = MockConversationRepository();
    useCase = GetConversationListUseCase(mockRepository);
  });
  group('GetConversationListUseCase', () {
    final tConversation = MockConversation();
    final tConversationList = [tConversation];
    test('should call repository.getList and return result', () async {
      when(
        () => mockRepository.getList(any()),
      ).thenAnswer((_) async => tConversationList);
      final result = await useCase(ListQueryParams<Conversation>());
      verify(() => mockRepository.getList(any())).called(1);
      expect(result.isSuccess, true);
      expect(
        result.getOrElse(() => throw (Exception())),
        equals(tConversationList),
      );
    });
    test('should return Failure when repository throws', () async {
      final exception = Exception('Error');
      when(() => mockRepository.getList(any())).thenThrow(exception);
      final result = await useCase(ListQueryParams<Conversation>());
      verify(() => mockRepository.getList(any())).called(1);
      expect(result.isFailure, true);
    });
  });
}
