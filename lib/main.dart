import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/app_state.dart';
import 'package:myapp/screens.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(ChangeNotifierProvider(
    create: (context) => AppState(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  String screenName = screens.keys.elementAt(0);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
          body: SafeArea(
            child: screens[screenName]!.screen,
          )),
    );
  }
}
