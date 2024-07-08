import 'package:flutter/material.dart';
import 'package:myapp/chat_agent/message.dart';

class AppState extends ChangeNotifier {
  String chatType = 'gemini';
  final List<Message> messages = [];

  void changeChatType(String newChatType) {
    chatType = newChatType;
    clearMessages();
    notifyListeners();
  }

  void clearMessages() {
    messages.removeRange(0, messages.length);
  }
}
