import 'package:flutter_dotenv/flutter_dotenv.dart';
class PaystackService {
  static String get publicKey => dotenv.env['PAYSTACK_PUBLIC_KEY'] ?? '';
}
