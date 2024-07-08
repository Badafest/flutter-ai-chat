import 'package:flutter/material.dart';
import 'package:myapp/Screens/settings_screen.dart';

import 'Screens/chat_screen.dart';

class Screen {
  final NavigationDestination destination;
  final Widget screen;
  const Screen({
    required this.destination,
    required this.screen,
  });
}

const screens = <String, Screen>{
  'chat': Screen(
    destination: NavigationDestination(
      selectedIcon: Icon(Icons.message),
      icon: Icon(Icons.message_outlined),
      label: 'Chat',
    ),
    screen: ChatScreen(),
  ),
  'settings': Screen(
    destination: NavigationDestination(
      selectedIcon: Icon(Icons.settings),
      icon: Icon(Icons.settings_outlined),
      label: 'Settings',
    ),
    screen: SettingsScreen(),
  ),
};
