import 'package:flutter_test/flutter_test.dart';
import 'package:sigap/main.dart';

void main() {
  testWidgets('SigapApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SigapApp());

    // Verify that the app widget builds and is present
    expect(find.byType(SigapApp), findsOneWidget);
  });
}
