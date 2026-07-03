import 'package:flutter_test/flutter_test.dart';

import 'package:shaperush_mobile/main.dart';

void main() {
  testWidgets('smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ShapeRushApp());
    await tester.pumpAndSettle();

    expect(find.text('Hello, Christopher'), findsOneWidget);
    expect(find.text('Your daily progress'), findsOneWidget);
  });
}
