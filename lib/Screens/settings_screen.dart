import 'package:flutter/material.dart';
import 'package:myapp/app_state.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chat Agent',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: appState.chatType,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
            items: const [
              DropdownMenuItem(
                value: 'basic',
                child: Text('Basic Agent'),
              ),
              DropdownMenuItem(
                value: 'gemini',
                child: Text('Gemini Agent'),
              ),
              DropdownMenuItem(
                value: 'api',
                child: Text('Other API Agent'),
              ),
            ],
            onChanged: (value) {
              appState.changeChatType(value!);
            },
          ),
        ],
      ),
    );
  }
}
