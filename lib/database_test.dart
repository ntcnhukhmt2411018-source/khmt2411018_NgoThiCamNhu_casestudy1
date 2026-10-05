import 'database/database_helper.dart';
import 'models/transaction.dart';

Future<void> testDatabase() async {
  final transaction = Transaction(
    type: 'expense',
    category: 'Ăn uống',
    amount: 50000,
    date: '2025-04-12',
    note: 'Ăn trưa',
  );

  final id = await DatabaseHelper.instance.insertTransaction(transaction);

  print('Đã thêm giao dịch với ID: $id');

  final transactions =
  await DatabaseHelper.instance.getTransactions();

  for (final item in transactions) {
    print(
      'ID: ${item.id} | '
          'Loại: ${item.type} | '
          'Danh mục: ${item.category} | '
          'Số tiền: ${item.amount} | '
          'Ngày: ${item.date} | '
          'Ghi chú: ${item.note}',
    );
  }
}