import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:my_sales/database/model/model.dart';

class AccountsDatabase {
  static final AccountsDatabase instance = AccountsDatabase._init();
  static const _dbName = 'account';
  AccountsDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('accounts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: ((db, version) {
        const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
        const realType = "REAL NOT NULL";
        const textType = "TEXT NOT NULL";
        const intType = "INTEGER NOT NULL";

        const createSQL = '''CREATE TABLE $_dbName(
          id $idType,
          dateTime $textType,
          amount $realType,
          isPurchase $intType,
          description $textType
        )''';
        db.execute(createSQL);
      }),
    );
  }

  Future<void> insertAccount(Account account) async {
    final db = await instance.database;
    await db.insert(
      _dbName,
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteAccount(Account account) async {
    final db = await instance.database;
    await db.delete(
      _dbName,
      where: 'id = ? and amount = ?',
      whereArgs: [account.id, account.amount]
    );
  }

  Future<List<Account>> getAllAccounts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('account');
    return Account.toAccount(maps);
  }

  Future getYearAccounts(int year) async {
    final db = await instance.database;
    final String from = DateTime(year).toIso8601String();
    final String to = DateTime(year + 1).toIso8601String();

    final List<Map<String, dynamic>> maps = await db.query(
      'account',
      where: "dateTime >= ? and dateTime < ?",
      whereArgs: [from, to],
    );
    return Account.toAccount(maps);
  }
}
