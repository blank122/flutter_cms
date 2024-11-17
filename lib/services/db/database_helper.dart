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
      version: 2,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Add the new column if the database is being upgraded to version 2
          await db.execute('''
          ALTER TABLE system_theme ADD COLUMN status INT NOT NULL
        ''');
        }
      },
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
        status INTEGER NOT NULL,
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
    await db.execute('''
    CREATE TABLE system_theme(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      usr_id INTEGER NOT NULL,
      name TEXT NOT NULL,
      system_name TEXT NOT NULL,
      system_logo_path TEXT NOT NULL,
      created_at TEXT NOT NULL,
      updated_at TEXT NOT NULL
    )
  ''');
    await db.execute('''
    CREATE TABLE system_title(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      usr_id INTEGER NOT NULL,
      name TEXT NOT NULL,
      system_name TEXT NOT NULL,
      created_at TEXT NOT NULL,
      updated_at TEXT NOT NULL
    )
  ''');
  }

//savings themes
  Future<int> saveThemes(
      int usrID,
      String name,
      String appBarColor,
      String bottomNavColor,
      String drawerColor,
      int status,
      String createdAt,
      String updatedAt) async {
    final db = await database;
    return await db.insert(
      'themes',
      {
        'usr_id': usrID,
        'theme_name': name,
        'app_bar_color': appBarColor,
        'bottom_nav_bar_color': bottomNavColor,
        'drawer_color': drawerColor,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //saving user location
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

//saving system themes
  Future<int> saveSystemTheme(
    int usrID,
    String name,
    String systemName,
    String systemLogoPath,
    int status,
    String createdAt,
    String updatedAt,
  ) async {
    final db = await database;
    return await db.insert(
      'system_theme',
      {
        'usr_id': usrID,
        'name': name,
        'system_name': systemName,
        'system_logo_path': systemLogoPath,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> saveSystemThemeTitle(
    int usrID,
    String name,
    String systemName,
    String createdAt,
    String updatedAt,
  ) async {
    final db = await database;
    return await db.insert(
      'system_title',
      {
        'usr_id': usrID,
        'name': name,
        'system_name': systemName,
        'created_at': createdAt,
        'updated_at': updatedAt,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> useTheme(int id, int status, String updatedAt) async {
    final db = await database;
    return await db.update(
      'themes',
      {'status': status, 'updated_at': updatedAt},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> useSystemTheme(int id, int status, String updatedAt) async {
    final db = await database;
    return await db.update(
      'system_theme',
      {'status': status, 'updated_at': updatedAt},
      where: 'id = ?',
      whereArgs: [id],
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

  Future<List<Map<String, dynamic>>> getSystemThemes(int userID) async {
    final db = await database;
    return await db.query(
      'system_theme',
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

  Future<List<Map<String, dynamic>>> getSystemThemesTitle(int userID) async {
    final db = await database;
    return await db.query(
      'system_title',
      where: 'usr_id = ?',
      whereArgs: [userID],
    );
  }

  Future<Map<String, dynamic>?> getActivatedTheme(int userID) async {
    final db = await database;
    // Query for the activated theme (status = 1)
    List<Map<String, dynamic>> result = await db.query(
      'themes',
      where: 'usr_id = ? AND status = ?', // Adding the 'status = 1' condition
      whereArgs: [userID, 1],
      limit: 1, // Ensures only one record is returned
    );

    if (result.isNotEmpty) {
      return result.first; // Return the first (and only) record
    } else {
      return null; // No active theme found
    }
  }

  Future<Map<String, dynamic>?> getActiveSystemTheme(int userID) async {
    final db = await database;
    // Query for the activated theme (status = 1)
    List<Map<String, dynamic>> result = await db.query(
      'system_theme',
      where: 'usr_id = ? AND status = ?', // Adding the 'status = 1' condition
      whereArgs: [userID, 1],
      limit: 1, // Ensures only one record is returned
    );

    if (result.isNotEmpty) {
      return result.first; // Return the first (and only) record
    } else {
      return null; // No active theme found
    }
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
