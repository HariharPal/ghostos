import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghostos/core/config/app_env.dart';
import 'package:supabase/supabase.dart';

final supabaseClientProvider = Provider<SupabaseClient>(
  (ref) => SupabaseClient(
    AppEnv.supabaseUrl,
    AppEnv.supabaseAnonKey,
    authOptions: const AuthClientOptions(
      authFlowType: AuthFlowType.implicit,
    ),
  ),
);
