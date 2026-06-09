import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/app_const.dart';

class DatabaseService{
  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();
  final String dbName = "expnese_note.db";
  final int dbVersion = 2;

  Database? _db;

  Future<Database> get database async{
        if(_db != null && _db!.isOpen)return _db!;
        _db = await _initDb();
        return _db!;
    }
    Future<Database> _initDb() async{
        String dbPath = await getDatabasesPath();
        String path = join(dbPath, dbName);
        return await openDatabase(
            path,
            version: dbVersion,
            onCreate: _dbCreate,
            onUpgrade:_dbUpgrade,
            onOpen: (db) async {
              await db.execute('PRAGMA foreign_keys = ON');
              await _createTables(db);
            },
        );
    }

    Future<void> close(Database db) async{
      if(_db != null && _db!.isOpen){
          await _db!.close();
          _db = null;
      }
    }

    Future<void> _dbUpgrade(Database db, int oldVersion, int newVersion) async{
        await _createTables(db);
    }

    Future<void> _dbCreate(Database db, int version) async{
      await db.transaction(
        (txn) async{
          await _createTables(txn);
        }
      );
    }

    Future<void> _createTables(DatabaseExecutor db) async{
      await db.execute("""
            CREATE TABLE IF NOT EXISTS ${AppConst.expenseTable} (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT NOT NULL DEFAULT "",
              subtitle TEXT NOT NULL DEFAULT "",
              amount REAL NOT NULL DEFAULT 0.0,
              date TEXT NOT NULL DEFAULT ""
            )
          """);
      await db.execute("""
            CREATE TABLE IF NOT EXISTS ${AppConst.expenseTypeTable} (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              icon INTEGER NOT NULL DEFAULT 0,
              name TEXT NOT NULL DEFAULT "",
              color INTEGER NOT NULL DEFAULT 0
            )
          """);
    }
  
}
