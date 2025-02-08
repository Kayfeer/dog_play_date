import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import 'settings_drawer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'chatHero',
      child: Scaffold(
        drawer: const SettingsDrawer(),
        appBar: AppBar(
          title: const Text("Chat"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, chatProvider, child) {
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: chatProvider.messages.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.messages[index];
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(12),
                        alignment: message.isSentByMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: message.isSentByMe
                              ? Colors.deepOrange.shade300
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          message.text,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const Divider(height: 1),
            _buildInputArea(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration.collapsed(
                  hintText: "Envoyer un message..."),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send,
                color: Color.fromARGB(255, 114, 77, 136)),
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                Provider.of<ChatProvider>(context, listen: false)
                    .sendMessage(controller.text.trim());
                controller.clear();
              }
            },
          )
        ],
      ),
    );
  }
}
