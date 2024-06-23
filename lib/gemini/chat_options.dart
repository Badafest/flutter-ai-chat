import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:myapp/chat_agent/chat_agent.dart';
import 'package:myapp/chat_agent/message.dart';

class GeminiChatOptions implements ChatOptions {
  @override
  List<Message> history;
  List<SafetySetting>? safetySettings;
  GenerationConfig? generationConfig;

  GeminiChatOptions({
    this.history = const [],
    this.safetySettings,
    this.generationConfig,
  });
}
