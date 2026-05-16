import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
export 'package:sqflite/sqflite.dart' show ConflictAlgorithm;

class DBController {
  static final DBController _instance = DBController._internal();

  factory DBController() => _instance;

  DBController._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await createSolidConfigHistory(db);
        await createPatternConfigHistory(db);
        await createNodesDataCache(db);
      },
    );
  }

  Future<int> insert(String table, Map<String, dynamic> values,
      {ConflictAlgorithm? conflictAlgorithm}) async {
    final db = await database;
    return await db.insert(table, values, conflictAlgorithm: conflictAlgorithm);
  }

  Future<List<Map<String, dynamic>>> query(String table,
      {String? where, List<Object?> whereArgs = const []}) async {
    final db = await database;
    return await db.query(table, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(
      {required String table,
      required String where,
      required List<Object?> whereArgs}) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future clear({required String table}) async {
    final db = await database;
    await db.delete(table);
  }

  Future<void> createSolidConfigHistory(Database db) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS solid_config_history (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            color INTEGER
          )
        ''');
  }

  Future<void> createPatternConfigHistory(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS pattern_config_history (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pattern TEXT NOT NULL
    )
  ''');
  }

  Future<void> createNodesDataCache(Database db) async {
    await db.execute('''
   CREATE TABLE IF NOT EXISTS art_net_nodes (
    macAddress PRIMARY KEY,
    ipAddress TEXT,
    netmask TEXT,
    gateWay TEXT,
    dhcpEnabled INTEGER,
    dhcpCapable INTEGER,
    isAvailable INTEGER,
    longName TEXT,
    shortName TEXT,
    swIn0 INTEGER,
    netSwitch INTEGER,
    universe INTEGER,
    numberOfLeds INTEGER,
    colorModel TEXT,
    nodeOutputType TEXT,
    ledsPerGroup INTEGER,
    nodeLightConfiguration TEXT
  )''');
  }
}
