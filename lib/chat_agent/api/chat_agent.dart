import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:myapp/chat_agent/api/chat_options.dart';
import 'package:myapp/chat_agent/api/model_options.dart';
import 'package:myapp/chat_agent/chat_agent.dart';
import 'package:myapp/chat_agent/message.dart';

class ApiChatAgent implements ChatAgent<ApiChatOptions> {
  final ApiModelOptions _apiOptions;

  ApiChatAgent(this._apiOptions);

  @override
  Future<ResponseMessage> respond(
      RequestMessage requestMessage, ApiChatOptions chatOptions) async {
    final response = await http.post(
      Uri.parse(_apiOptions.apiUrl),
      headers: _apiOptions.headers,
      body: jsonEncode(requestMessage),
    );
    if (response.statusCode == 200) {
      return ResponseMessage.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    }
    throw Exception("API responded with status code ${response.statusCode}");
  }
}
