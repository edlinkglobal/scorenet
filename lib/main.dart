import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/time_greeting_service.dart';
import 'services/paystack_service.dart';
import 'services/football_api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const ScoreNetApp());
}

class ScoreNetApp extends StatelessWidget {
  const ScoreNetApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ScoreNet',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> matches = [];
  bool loading = true;
  @override
  void initState() { super.initState(); loadScores(); }
  Future<void> loadScores() async {
    final data = await FootballApiService.getLive();
    setState(() { matches = data; loading = false; });
  }
  @override
  Widget build(BuildContext context) {
    final greeting = TimeGreetingService.getGreeting();
    final isLive = PaystackService.publicKey.startsWith('pk_live_');
    return Scaffold(
      appBar: AppBar(title: Text('$greeting - ScoreNet'), backgroundColor: isLive? Colors.green : Colors.orange),
      body: loading? const Center(child: CircularProgressIndicator())
        : Center(child: Text('$greeting! ScoreNet Live\nPaystack: ${isLive? "LIVE" : "TEST"}', textAlign: TextAlign.center)),
    );
  }
}
