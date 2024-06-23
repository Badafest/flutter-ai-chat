import 'package:myapp/basic/chat_options.dart';
import 'package:myapp/chat_agent/chat_agent.dart';
import 'package:myapp/chat_agent/message.dart';

class BasicChatAgent implements ChatAgent<BasicChatOptions>{
  @override
  Future<ResponseMessage> respond(RequestMessage requestMessage, BasicChatOptions chatOptions) async {
    return ResponseMessage(
      usage: UsageData(
        inputTokens: 134,
        outputTokens: 267,
        totalTokens: 401,
      ),
      text: "Hello from Basic Chat Agent 🙂🙂🙂"
    );
  }
}