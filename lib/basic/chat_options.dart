import 'package:myapp/chat_agent/chat_agent.dart';
import 'package:myapp/chat_agent/message.dart';

class BasicChatOptions implements ChatOptions {
  @override
  List<Message> history;

  BasicChatOptions({this.history = const []});
}
