import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghostos/app/ghostos_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Hive.initFlutter();

  runApp(
    const ProviderScope(
      child: GhostOsApp(),
    ),
  );
}
