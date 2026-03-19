import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/race_time.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _db;

  Future<Database> get database async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mallkubox_race.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS hyrox_tiempos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_equipo INTEGER NOT NULL,
        id_estacion INTEGER NOT NULL,
        tiempo_ms INTEGER NOT NULL,
        tiempo_inicio TEXT,
        tiempo_fin TEXT,
        sincronizado INTEGER DEFAULT 0,
        created_at TEXT DEFAULT (datetime('now'))
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS hyrox_race_sessions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_equipo INTEGER NOT NULL,
        id_heat INTEGER NOT NULL,
        nombre_equipo TEXT NOT NULL,
        nombre_heat TEXT NOT NULL,
        fecha TEXT NOT NULL,
        finalizada INTEGER DEFAULT 0,
        created_at TEXT DEFAULT (datetime('now'))
      )
    ''');
  }

  // ── Sessions ──────────────────────────────────────────────────────────────

  Future<int> saveSession({
    required int idEquipo,
    required int idHeat,
    required String nombreEquipo,
    required String nombreHeat,
  }) async {
    final db = await database;
    return await db.insert('hyrox_race_sessions', {
      'id_equipo': idEquipo,
      'id_heat': idHeat,
      'nombre_equipo': nombreEquipo,
      'nombre_heat': nombreHeat,
      'fecha': DateTime.now().toIso8601String(),
      'finalizada': 0,
    });
  }

  Future<void> finalizeSession(int sessionId) async {
    final db = await database;
    await db.update(
      'hyrox_race_sessions',
      {'finalizada': 1},
      where: 'id = ?',
      whereArgs: [sessionId],
    );
  }

  // ── Tiempos ───────────────────────────────────────────────────────────────

  Future<int> saveTime(RaceTime raceTime) async {
    final db = await database;
    return await db.insert('hyrox_tiempos', raceTime.toMap());
  }

  Future<void> markSynced(int id) async {
    final db = await database;
    await db.update(
      'hyrox_tiempos',
      {'sincronizado': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<RaceTime>> getPendingSync() async {
    final db = await database;
    final maps = await db.query(
      'hyrox_tiempos',
      where: 'sincronizado = 0',
    );
    return maps.map((m) => RaceTime.fromMap(m)).toList();
  }

  Future<List<RaceTime>> getTimesByEquipo(int idEquipo) async {
    final db = await database;
    final maps = await db.query(
      'hyrox_tiempos',
      where: 'id_equipo = ?',
      whereArgs: [idEquipo],
      orderBy: 'id_estacion ASC',
    );
    return maps.map((m) => RaceTime.fromMap(m)).toList();
  }

  Future<void> deleteTime(int id) async {
    final db = await database;
    await db.delete('hyrox_tiempos', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = _db;
    if (db != null) {
      await db.close();
      _db = null;
    }
  }
}
