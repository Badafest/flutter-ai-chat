import 'package:flutter/material.dart';
import 'package:myapp/app_state.dart';
import 'package:myapp/chat_agent/agents.dart';
import 'package:myapp/chat_agent/message.dart';

import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  bool isWaitingForResponse = false;

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 150),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> _sendMessage(
      String chatType, String text, List<Message> messages) async {
    if (text.isEmpty || isWaitingForResponse) {
      return;
    }

    _textController.clear();

    var requestMessage = RequestMessage(mimeType: MimeType.text, text: text);

    setState(() {
      messages.add(requestMessage);
      isWaitingForResponse = true;
      _scrollToBottom();
    });

    var chatOptions = modelOptions[chatType]!;
    chatOptions.history = messages;

    var responseMessage =
        await availableAgents[chatType]!.respond(requestMessage, chatOptions);

    setState(() {
      messages.add(responseMessage);
      isWaitingForResponse = false;
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var messages = appState.messages;
    var theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                ),
                child: Text(
                  {
                    'basic': 'Basic Chat Agent',
                    'api': 'API Chat Agent',
                    'gemini': 'Gemini Chat Agent'
                  }[appState.chatType]!,
                  style: TextStyle(
                    fontSize: theme.textTheme.labelLarge!.fontSize,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return MessageBubble(
                  message: messages[index].text!,
                  isCurrentUser: messages[index].sender == Role.user,
                );
              },
            ),
          ),
          isWaitingForResponse
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MessageBubble(
                      message: "💭 Thinking...",
                      isCurrentUser: false,
                    ),
                  ],
                )
              : const SizedBox(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.multiline,
                    maxLines: 18,
                    minLines: 1,
                    decoration: const InputDecoration(
                      hintText: "Ask me anything...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: isWaitingForResponse
                      ? null
                      : () => print("Image Upload clicked"),
                  disabledColor: Colors.grey,
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: isWaitingForResponse
                      ? null
                      : () => _sendMessage(
                            appState.chatType,
                            _textController.text.trim(),
                            messages,
                          ),
                  disabledColor: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: isCurrentUser ? 64.0 : 16.0,
        right: isCurrentUser ? 16.0 : 64.0,
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? theme.primaryColorLight
            : theme.secondaryHeaderColor,
        borderRadius: BorderRadius.only(
          topRight: const Radius.circular(16.0),
          topLeft: Radius.circular(isCurrentUser ? 16.0 : 0.0),
          bottomLeft: const Radius.circular(16.0),
          bottomRight: Radius.circular(isCurrentUser ? 0.0 : 16.0),
        ),
      ),
      child: Text(message, style: const TextStyle(color: Colors.black)),
    );
  }
}
