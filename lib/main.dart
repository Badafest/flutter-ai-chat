import 'package:flutter/material.dart';
import 'package:myapp/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white70)),
        home: const HomeComponent());
  }
}

class HomeComponent extends StatefulWidget {
  const HomeComponent({
    super.key,
  });

  @override
  State<HomeComponent> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  String screenName = "home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: screens.keys.toList().indexOf(screenName),
        onDestinationSelected: (index) {
          setState(() {
            screenName = screens.keys.elementAt(index);
          });
        },
        destinations:
            screens.values.map((screen) => screen.destination).toList(),
      ),
      body: screens[screenName]?.screen,
    );
  }
}
