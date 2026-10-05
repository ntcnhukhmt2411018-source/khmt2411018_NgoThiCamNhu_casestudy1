import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/transaction.dart' as transaction_model;

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('expense_manager.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        category TEXT NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        note TEXT
      )
    ''');
  }

  // Thêm giao dịch
  Future<int> insertTransaction(
      transaction_model.Transaction transaction,
      ) async {
    final db = await instance.database;

    return await db.insert(
      'transactions',
      transaction.toMap(),
    );
  }

  // Lấy danh sách giao dịch
  Future<List<transaction_model.Transaction>> getTransactions() async {
    final db = await instance.database;

    final result = await db.query(
      'transactions',
      orderBy: 'date DESC',
    );

    return result.map((map) {
      return transaction_model.Transaction.fromMap(map);
    }).toList();
  }

  // Sửa giao dịch
  Future<int> updateTransaction(
      transaction_model.Transaction transaction,
      ) async {
    final db = await instance.database;

    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  // Xóa giao dịch
  Future<int> deleteTransaction(int id) async {
    final db = await instance.database;

    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Đóng database
  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}