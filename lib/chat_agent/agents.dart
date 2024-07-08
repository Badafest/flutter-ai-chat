import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:myapp/chat_agent/chat_agent.dart';

import 'package:myapp/chat_agent/api/chat_agent.dart';
import 'package:myapp/chat_agent/api/chat_options.dart';
import 'package:myapp/chat_agent/api/model_options.dart';

import 'package:myapp/chat_agent/basic/chat_agent.dart';
import 'package:myapp/chat_agent/basic/chat_options.dart';

import 'package:myapp/chat_agent/gemini/chat_agent.dart';
import 'package:myapp/chat_agent/gemini/chat_options.dart';
import 'package:myapp/chat_agent/gemini/model_options.dart';

final availableAgents = <String, ChatAgent>{
  'api': ApiChatAgent(ApiModelOptions(
    apiKey: dotenv.env['OTHER_API_KEY'] ?? '',
    apiUrl: dotenv.env['OTHER_API_URL'] ?? '',
  )),
  'basic': BasicChatAgent(),
  'gemini': GeminiChatAgent(GeminiModelOptions(
    apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
  )),
};

final modelOptions = <String, ChatOptions>{
  'api': ApiChatOptions(),
  'basic': BasicChatOptions(),
  'gemini': GeminiChatOptions(),
};
