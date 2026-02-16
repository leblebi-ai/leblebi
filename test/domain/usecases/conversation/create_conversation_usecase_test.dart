import 'package:flutter_test/flutter_test.dart';
import 'package:leblebi/src/domain/entities/conversation/conversation.dart';
import 'package:leblebi/src/domain/repositories/conversation_repository.dart';
import 'package:leblebi/src/domain/usecases/conversation/create_conversation_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockConversationRepository extends Mock
    implements ConversationRepository {}

class MockConversation extends Mock implements Conversation {}

void main() {
  late CreateConversationUseCase useCase;
  late MockConversationRepository mockRepository;
  setUp(() {
    registerFallbackValue(MockConversation());
    mockRepository = MockConversationRepository();
    useCase = CreateConversationUseCase(mockRepository);
  });
  group('CreateConversationUseCase', () {
    final tConversation = MockConversation();
    test('should call repository.create and return result', () async {
      when(
        () => mockRepository.create(any()),
      ).thenAnswer((_) async => tConversation);
      final result = await useCase(tConversation);
      verify(() => mockRepository.create(any())).called(1);
      expect(result.isSuccess, true);
      expect(
        result.getOrElse(() => throw (Exception())),
        equals(tConversation),
      );
    });
    test('should return Failure when repository throws', () async {
      final exception = Exception('Error');
      when(() => mockRepository.create(any())).thenThrow(exception);
      final result = await useCase(tConversation);
      verify(() => mockRepository.create(any())).called(1);
      expect(result.isFailure, true);
    });
  });
}
