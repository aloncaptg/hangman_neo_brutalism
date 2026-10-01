import 'package:flutter_test/flutter_test.dart';
import 'package:hangman_neo_brutalism/main.dart';

void main() {
  testWidgets('Hangman Neo-Brutalism smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const HangmanNeoBrutalismApp());

    // Verify header exists
    expect(find.text('HANGMAN GAME #3'), findsOneWidget);
    expect(find.text('👤 Attaridho Ananda Susilo'), findsOneWidget);
    expect(find.text('NEO-BRUTALISM'), findsOneWidget);

    // Verify virtual keyboard rendered
    expect(find.text('A'), findsOneWidget);
    expect(find.text('Z'), findsOneWidget);

    // Verify controls
    expect(find.text('🔄 RESET / NEW GAME'), findsOneWidget);
  });
}
