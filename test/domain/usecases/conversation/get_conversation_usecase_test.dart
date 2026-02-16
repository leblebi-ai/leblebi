import 'package:flutter_test/flutter_test.dart';
import 'package:leblebi/src/domain/entities/conversation/conversation.dart';
import 'package:leblebi/src/domain/repositories/conversation_repository.dart';
import 'package:leblebi/src/domain/usecases/conversation/get_conversation_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zuraffa/zuraffa.dart';

class MockConversationRepository extends Mock
    implements ConversationRepository {}

class MockConversation extends Mock implements Conversation {}

void main() {
  late GetConversationUseCase useCase;
  late MockConversationRepository mockRepository;
  setUp(() {
    registerFallbackValue(const QueryParams<Conversation>());
    mockRepository = MockConversationRepository();
    useCase = GetConversationUseCase(mockRepository);
  });
  group('GetConversationUseCase', () {
    final tConversation = MockConversation();
    test('should call repository.get and return result', () async {
      when(
        () => mockRepository.get(any()),
      ).thenAnswer((_) async => tConversation);
      final result = await useCase(
        QueryParams<Conversation>(params: ({'id': '1'})),
      );
      verify(() => mockRepository.get(any())).called(1);
      expect(result.isSuccess, true);
      expect(
        result.getOrElse(() => throw (Exception())),
        equals(tConversation),
      );
    });
    test('should return Failure when repository throws', () async {
      final exception = Exception('Error');
      when(() => mockRepository.get(any())).thenThrow(exception);
      final result = await useCase(
        QueryParams<Conversation>(params: ({'id': '1'})),
      );
      verify(() => mockRepository.get(any())).called(1);
      expect(result.isFailure, true);
    });
  });
}
