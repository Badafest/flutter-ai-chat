import 'package:flutter/material.dart';

import 'Screens/home_screen.dart';
import 'Screens/notifications_screen.dart';

class Screen {
  final NavigationDestination destination;
  final Widget screen;
  const Screen({
    required this.destination,
    required this.screen,
  });
}

const screens = <String, Screen>{
  'home': Screen(
    destination: NavigationDestination(
      selectedIcon: Icon(Icons.home),
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    screen: HomeScreen(),
  ),
  'notifications': Screen(
    destination: NavigationDestination(
      selectedIcon: Icon(Icons.home),
      icon: Icon(Icons.home_outlined),
      label: 'Notifications',
    ),
    screen: NotificationsScreen(),
  ),
  'messages': Screen(
    destination: NavigationDestination(
      selectedIcon: Icon(Icons.home),
      icon: Icon(Icons.home_outlined),
      label: 'Messages',
    ),
    screen: MessagesScreen(),
  )
};

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
      shadowColor: Colors.transparent,
      margin: EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Center(
          child: Text(
            'Messages',
          ),
        ),
      ),
    );
  }
}
