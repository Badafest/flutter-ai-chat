class ApiModelOptions {
  String apiKey = '';
  String apiUrl = '';
  Map<String, String> headers = {};

  ApiModelOptions({
    required this.apiKey,
    required this.apiUrl,
  }) {
    headers['Authorization'] = apiKey;
  }
}
