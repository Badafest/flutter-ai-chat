import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:myapp/chat_agent/chat_agent.dart';
import 'package:myapp/chat_agent/message.dart';

import 'package:myapp/chat_agent/gemini/model_options.dart';
import 'package:myapp/chat_agent/gemini/chat_options.dart';

class GeminiChatAgent implements ChatAgent<GeminiChatOptions> {
  late GenerativeModel _model;

  GeminiChatAgent._internal(GenerativeModel model) {
    _model = model;
  }

  factory GeminiChatAgent(GeminiModelOptions modelOptions) {
    final model = GenerativeModel(
        apiKey: modelOptions.apiKey,
        model: modelOptions.model,
        generationConfig: modelOptions.generationConfig,
        tools: modelOptions.tools,
        requestOptions: modelOptions.requestOptions,
        systemInstruction: modelOptions.systemInstruction,
        toolConfig: modelOptions.toolConfig);

    return GeminiChatAgent._internal(model);
  }

  @override
  Future<ResponseMessage> respond(
      RequestMessage requestMessage, GeminiChatOptions chatOptions) async {
    var prompt =
        [...chatOptions.history, requestMessage].map(_contentFromMessage);

    var generatedContent = await _model.generateContent(prompt,
        safetySettings: chatOptions.safetySettings,
        generationConfig: chatOptions.generationConfig);

    var usageMetadata = generatedContent.usageMetadata;

    var usageData = UsageData(
        inputTokens: usageMetadata?.promptTokenCount ?? 0,
        outputTokens: usageMetadata?.candidatesTokenCount ?? 0,
        totalTokens: usageMetadata?.totalTokenCount ?? 0);

    var response = ResponseMessage(usage: usageData);

    var [firstCandidate] = generatedContent.candidates;
    switch (firstCandidate.finishReason) {
      case FinishReason.recitation || FinishReason.safety:
        response.error = firstCandidate.finishMessage!;
        break;
      default:
        response.text = firstCandidate.text!;
        break;
    }
    return response;
  }

  Content _contentFromMessage(Message message) {
    if (message.sender == Role.model) {
      return Content.model(
          [TextPart(ArgumentError.checkNotNull(message.text, "Text"))]);
    }
    switch (message.mimeType) {
      case MimeType.text:
        return Content.text(ArgumentError.checkNotNull(message.text, "Text"));
      default:
        return Content.data(message.mimeType.value,
            ArgumentError.checkNotNull(message.bytes, "Bytes"));
    }
  }
}
