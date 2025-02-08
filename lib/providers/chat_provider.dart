import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isSentByMe;
  ChatMessage({required this.text, required this.isSentByMe});
}

class ChatProvider with ChangeNotifier {
  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages.reversed.toList();

  void sendMessage(String text) {
    _messages.add(ChatMessage(text: text, isSentByMe: true));
    notifyListeners();
    // Simulation d'une réponse automatique après 1 seconde
    Future.delayed(const Duration(seconds: 1), () {
      _messages.add(
          ChatMessage(text: "Réponse automatique à: $text", isSentByMe: false));
      notifyListeners();
    });
  }
}
