import 'dart:convert';
import 'package:http/http.dart' as http;

class FootballApiService {
  static Future<List<dynamic>> getLive() async {
    try {
      final r = await http.get(Uri.parse('https://api.football-data.org/v4/matches'));
      if(r.statusCode==200) return jsonDecode(r.body)['matches'] ?? [];
    } catch(e) {}
    return [];
  }
}
