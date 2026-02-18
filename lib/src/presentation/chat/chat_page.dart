import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../di/service_locator.dart';
import '../../domain/usecases/message/get_message_list_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../../domain/usecases/gateway_connection/get_gateway_connection_list_usecase.dart';
import '../../domain/usecases/gateway_connection/delete_gateway_connection_usecase.dart';
import '../setup/setup_page.dart';
import 'chat_view_model.dart';
import 'widgets/chat_input.dart';
import 'widgets/message_bubble.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    // For MVP, assume conversationId is fixed or passed.
    // Let's create a default one or fetch it.
    // But ChatViewModel needs to be initialized.
    
    return ChangeNotifierProvider(
      create: (_) => ChatViewModel(
        getIt<GetMessageListUseCase>(),
        getIt<SendMessageUseCase>(),
        getIt<GetGatewayConnectionListUseCase>(),
        getIt<DeleteGatewayConnectionUseCase>(),
      )..loadMessages('default_conversation'),
      child: const _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ChatViewModel>();
    final messages = viewModel.messages;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ZeroClaw Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => viewModel.loadMessages('default_conversation'),
          ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'logout') {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Disconnect'),
                    content: const Text('Are you sure you want to disconnect from this gateway?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Disconnect', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
                
                if (confirm == true && context.mounted) {
                  await viewModel.disconnect();
                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const SetupPage()),
                    );
                  }
                }
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Disconnect', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: viewModel.isLoading && messages.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : messages.isEmpty
                    ? const Center(child: Text('No messages yet'))
                    : ListView.builder(
                        reverse: true, // Show latest at bottom? No, usually reverse: true means bottom up.
                        // But messages are sorted by timestamp asc.
                        // If reverse: true, index 0 is at bottom.
                        // So index 0 should be latest message.
                        // Our sort is asc (oldest first).
                        // So last element is latest.
                        // So index 0 of ListView (bottom) should be last element of list.
                        // So we should reverse the list or access it reversed.
                        // Or just use reverse: false and scroll to bottom.
                        // reverse: true is better for chat.
                        // So we need to reverse the list for display.
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[messages.length - 1 - index];
                          return MessageBubble(message: message);
                        },
                      ),
          ),
          if (viewModel.error != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                viewModel.error!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          const ChatInput(),
        ],
      ),
    );
  }
}
