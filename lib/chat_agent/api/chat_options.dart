import 'package:myapp/chat_agent/chat_agent.dart';
import 'package:myapp/chat_agent/message.dart';

class ApiChatOptions implements ChatOptions {
  @override
  List<Message> history;

  ApiChatOptions({this.history = const []});
}
