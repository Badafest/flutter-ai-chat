import 'package:myapp/chat_agent/message.dart';

abstract class ChatAgent<ChatOptionsType extends ChatOptions> {
  Future<ResponseMessage> respond(
      RequestMessage requestMessage, ChatOptionsType chatOptions);
}

abstract class ChatOptions{
  List<Message> history = [];
}