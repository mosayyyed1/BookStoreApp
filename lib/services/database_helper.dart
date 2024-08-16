import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/book_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    String path = join(await getDatabasesPath(), 'book_data.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return _db!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE books (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bookName TEXT NOT NULL,
        authorName TEXT NOT NULL,
        imageUrl TEXT NOT NULL
      )
    ''');
  }

  Future<bool> insertBook(Book book) async {
    Database db = await database;
    await db.insert('books', book.toMap());
    return true;
  }

  Future<List<Book>> getBooks() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('books');
    return maps.map((map) => Book.fromMap(map)).toList();
  }

  Future<int> deleteBook(int id) async {
    Database db = await database;
    return await db.delete('books', where: 'id = ?', whereArgs: [id]);
  }
}
