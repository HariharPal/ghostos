import 'package:flutter_test/flutter_test.dart';
import 'package:ghostos/features/splash/presentation/screens/splash_screen.dart';

void main() {
  testWidgets('splash screen shows GhostOS branding', (tester) async {
    await tester.pumpWidget(const SplashScreen());

    expect(find.text('GhostOS'), findsOneWidget);
    expect(find.text('Your Habits Build Your World'), findsOneWidget);
  });
}
