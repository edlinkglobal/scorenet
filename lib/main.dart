import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const ScoreNetApp());
}

class ScoreNetApp extends StatelessWidget {
  const ScoreNetApp({super.key});
  @override Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScoreNet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: Colors.white, colorSchemeSeed: const Color(0xFF0A1931)),
      home: const MainTabs(),
    );
  }
}

class MainTabs extends StatefulWidget {
  const MainTabs({super.key});
  @override State<MainTabs> createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
  int idx = 0;
  final pages = const [
    Center(child: Text("Matches")),
    Center(child: Text("Live")),
    Center(child: Text("Favorite")),
    Center(child: Text("Insights")),
    Center(child: Text("Leagues")),
    Center(child: Text("News")),
    Center(child: Text("Me")),
  ];
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ScoreNet", style: TextStyle(fontWeight: FontWeight.w900)), backgroundColor: Colors.white),
      body: pages[idx],
      bottomNavigationBar: NavigationBar(
        selectedIndex: idx,
        onDestinationSelected: (i) => setState(() => idx = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.sports_soccer), label: "Matches"),
          NavigationDestination(icon: Icon(Icons.live_tv), label: "Live"),
          NavigationDestination(icon: Icon(Icons.star), label: "Favorite"),
          NavigationDestination(icon: Icon(Icons.insights), label: "Insights"),
          NavigationDestination(icon: Icon(Icons.emoji_events), label: "Leagues"),
          NavigationDestination(icon: Icon(Icons.newspaper), label: "News"),
          NavigationDestination(icon: Icon(Icons.person), label: "Me"),
        ],
      ),
    );
  }
}
