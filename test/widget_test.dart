import 'package:flutter_test/flutter_test.dart';
import 'package:khmt2411018_ngothicamnhu1/main.dart';

void main() {
  testWidgets('Expense Manager app test', (WidgetTester tester) async {
    await tester.pumpWidget(const ExpenseManagerApp());

    expect(find.text('Quản lý thu chi'), findsOneWidget);
  });
}