import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiModelOptions {
  String apiKey = '';
  String model = 'gemini-1.5-flash';
  GenerationConfig? generationConfig = GenerationConfig(
    temperature: 1,
    topP: 0.95,
    topK: 64,
    maxOutputTokens: 8192,
    responseMimeType: "text/plain",
  );
  List<SafetySetting>? safetySettings = [
    SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.low),
    SafetySetting(HarmCategory.harassment, HarmBlockThreshold.low),
    SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.low),
    SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.low),
  ];
  List<Tool>? tools;
  RequestOptions? requestOptions;
  Content? systemInstruction;
  ToolConfig? toolConfig;

  GeminiModelOptions({
    required this.apiKey,
    this.model = 'gemini-1.5-flash',
    this.generationConfig,
    this.safetySettings,
    this.tools,
    this.requestOptions,
    this.systemInstruction,
    this.toolConfig,  
  });
}