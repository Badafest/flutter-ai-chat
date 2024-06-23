import 'dart:typed_data';

abstract class Message {
  Role sender = Role.user;
  MimeType mimeType = MimeType.text;
  String? text;
  Uint8List? bytes;
}

enum Role { user, model }

enum MimeType {
  text('text/plain'),
  png('image/png'),
  jpeg('image/jpeg'),
  webp('image/webp'),
  svg('image/svg+xml'),
  gif('image/gif');

  final String value;

  const MimeType(this.value);
}

class RequestMessage extends Message {
  RequestMessage({required MimeType mimeType, String? text, Uint8List? bytes}) {
    sender = Role.user;
    this.text = text;
    this.bytes = bytes;
  }
}

class ResponseMessage extends Message {
  String? error;
  UsageData? usage;

  ResponseMessage({this.error, this.usage, String? text}) {
    this.text = text;
    sender = Role.model;
  }
}

class UsageData {
  int inputTokens;
  int outputTokens;
  int totalTokens;

  UsageData(
      {this.inputTokens = 0, this.outputTokens = 0, this.totalTokens = 0});
}
