import 'package:flutter_test/flutter_test.dart';
import 'package:zaden/main.dart';

void main() {
  testWidgets('ZADEN MVP opens with four main sections', (tester) async {
    await tester.pumpWidget(const ZadenApp());
    await tester.pumpAndSettle();

    expect(find.text('زَادَن'), findsOneWidget);
    expect(find.text('الرئيسية'), findsOneWidget);
    expect(find.text('اكتشف'), findsOneWidget);
    expect(find.text('السلة'), findsOneWidget);
    expect(find.text('طلباتي'), findsOneWidget);
  });
}
