import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer' as developer;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'themes.db');
    developer.log('Database path: $path'); // Debugging line

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE themes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usr_id INTEGER NOT NULL,
        theme_name TEXT NOT NULL,
        app_bar_color TEXT NOT NULL,
        bottom_nav_bar_color TEXT NOT NULL,
        drawer_color TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
    await db.execute('''
    CREATE TABLE location(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      usr_id INTEGER NOT NULL,
      tile_path TEXT NOT NULL,
      latitude TEXT NOT NULL,
      longitude TEXT NOT NULL,
      created_at TEXT NOT NULL,
      updated_at TEXT NOT NULL
    )
  ''');
  }

  Future<int> createTheme(
      int usrID,
      String themeName,
      String appBarColor,
      String bottomNavColor,
      String drawerColor,
      String createdAt,
      String updatedAt) async {
    final db = await database;
    return await db.insert(
      'themes',
      {
        'usr_id': usrID,
        'theme_name': themeName,
        'app_bar_color': appBarColor,
        'bottom_nav_bar_color': bottomNavColor,
        'drawer_color': drawerColor,
        'created_at': createdAt,
        'updated_at': updatedAt,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> saveLocation(
    int usrID,
    String tilePath,
    String latitude,
    int longitude,
    String createdAt,
    String updatedAt,
  ) async {
    final db = await database;
    return await db.insert(
      'location',
      {
        'usr_id': usrID,
        'tile_path': tilePath,
        'latitude': latitude,
        'longitude': longitude,
        'created_at': createdAt,
        'updated_at': updatedAt,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getThemes(int userID) async {
    final db = await database;
    return await db.query(
      'themes',
      where: 'usr_id = ?',
      whereArgs: [userID],
    );
  }

  Future<List<Map<String, dynamic>>> getLocation(int userID) async {
    final db = await database;
    return await db.query(
      'location',
      where: 'usr_id = ?',
      whereArgs: [userID],
    );
  }

  Future<int> deleteTheme(int id) async {
    final db = await database;
    // Check if the database is writable
    var isOpen = db.isOpen;
    print('Database is open: $isOpen'); // Debugging line
    return await db.delete('themes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteDraftSurveyAnswer(int id) async {
    final db = await database;
    // Check if the database is writable
    var isOpen = db.isOpen;
    print('Database is open: $isOpen'); // Debugging line
    return await db.delete('answer_history', where: 'id = ?', whereArgs: [id]);
  }
}