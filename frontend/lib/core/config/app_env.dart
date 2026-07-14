import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  const AppEnv._();

  static String get supabaseUrl => _read('SUPABASE_URL');
  static String get supabaseAnonKey => _read('SUPABASE_ANON_KEY');

  static String _read(String key) {
    final value = dotenv.env[key]?.trim();
    if (value == null || value.isEmpty) {
      throw StateError('Missing required environment variable: $key');
    }
    return value;
  }
}
