import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/race_time.dart';
import '../models/penalty.dart';

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
      version: 2,
      onCreate: _createTables,
      onUpgrade: _onUpgrade,
    );
  }

  // ── Crear todas las tablas (DB nueva) ─────────────────────────────────────

  Future<void> _createTables(Database db, int version) async {
    // Tiempos por estación
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

    // Sesiones de carrera
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

    // Módulos Hyrox (tipos de estación) — sincronizados con datos estáticos
    await db.execute('''
      CREATE TABLE IF NOT EXISTS hyrox_modules (
        id INTEGER PRIMARY KEY,
        key TEXT NOT NULL UNIQUE,
        nombre TEXT NOT NULL,
        descripcion TEXT
      )
    ''');

    // Tipos de penalización por módulo — sincronizados con datos estáticos
    await db.execute('''
      CREATE TABLE IF NOT EXISTS hyrox_penalty_types (
        id INTEGER PRIMARY KEY,
        module_id INTEGER NOT NULL,
        label TEXT NOT NULL,
        description TEXT,
        penalty_seconds INTEGER NOT NULL,
        FOREIGN KEY (module_id) REFERENCES hyrox_modules(id)
      )
    ''');

    // Log de penalizaciones aplicadas en carrera
    await db.execute('''
      CREATE TABLE IF NOT EXISTS hyrox_penalty_log (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        session_id INTEGER NOT NULL,
        id_equipo INTEGER NOT NULL,
        id_estacion INTEGER NOT NULL,
        module_id INTEGER NOT NULL,
        penalty_type_id INTEGER NOT NULL,
        penalty_seconds INTEGER NOT NULL,
        timer_ms_at_penalty INTEGER NOT NULL,
        applied_at TEXT DEFAULT (datetime('now')),
        sincronizado INTEGER DEFAULT 0,
        FOREIGN KEY (session_id) REFERENCES hyrox_race_sessions(id),
        FOREIGN KEY (penalty_type_id) REFERENCES hyrox_penalty_types(id)
      )
    ''');

    // Seed: insertar módulos y tipos de penalización estáticos
    await _seedStaticData(db);
  }

  // ── Migración v1 → v2 ─────────────────────────────────────────────────────

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS hyrox_modules (
          id INTEGER PRIMARY KEY,
          key TEXT NOT NULL UNIQUE,
          nombre TEXT NOT NULL,
          descripcion TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS hyrox_penalty_types (
          id INTEGER PRIMARY KEY,
          module_id INTEGER NOT NULL,
          label TEXT NOT NULL,
          description TEXT,
          penalty_seconds INTEGER NOT NULL
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS hyrox_penalty_log (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          session_id INTEGER NOT NULL,
          id_equipo INTEGER NOT NULL,
          id_estacion INTEGER NOT NULL,
          module_id INTEGER NOT NULL,
          penalty_type_id INTEGER NOT NULL,
          penalty_seconds INTEGER NOT NULL,
          timer_ms_at_penalty INTEGER NOT NULL,
          applied_at TEXT DEFAULT (datetime('now')),
          sincronizado INTEGER DEFAULT 0
        )
      ''');

      await _seedStaticData(db);
    }
  }

  // ── Seed: poblar módulos y tipos de penalización desde datos estáticos ────

  Future<void> _seedStaticData(Database db) async {
    final batch = db.batch();

    // Módulos Hyrox
    for (final m in hyroxModules) {
      batch.insert(
        'hyrox_modules',
        {'id': m.id, 'key': m.key, 'nombre': m.nombre, 'descripcion': m.descripcion},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }

    // Tipos de penalización
    for (final p in allPenaltyTypes) {
      batch.insert(
        'hyrox_penalty_types',
        {
          'id': p.id,
          'module_id': p.moduleId,
          'label': p.label,
          'description': p.description,
          'penalty_seconds': p.penaltySeconds,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }

    await batch.commit(noResult: true);
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

  // ── Penalizaciones ────────────────────────────────────────────────────────

  /// Registra una penalización aplicada durante la carrera.
  /// [timerMsAtPenalty]: milisegundos del cronómetro en el momento de aplicar.
  Future<int> savePenalty({
    required int sessionId,
    required int idEquipo,
    required int idEstacion,
    required int moduleId,
    required int penaltyTypeId,
    required int penaltySeconds,
    required int timerMsAtPenalty,
  }) async {
    final db = await database;
    return await db.insert('hyrox_penalty_log', {
      'session_id': sessionId,
      'id_equipo': idEquipo,
      'id_estacion': idEstacion,
      'module_id': moduleId,
      'penalty_type_id': penaltyTypeId,
      'penalty_seconds': penaltySeconds,
      'timer_ms_at_penalty': timerMsAtPenalty,
      'applied_at': DateTime.now().toIso8601String(),
      'sincronizado': 0,
    });
  }

  Future<List<Map<String, dynamic>>> getPenaltiesBySession(int sessionId) async {
    final db = await database;
    return await db.query(
      'hyrox_penalty_log',
      where: 'session_id = ?',
      whereArgs: [sessionId],
      orderBy: 'applied_at ASC',
    );
  }

  Future<List<Map<String, dynamic>>> getPenaltiesByEstacion(
      int sessionId, int idEstacion) async {
    final db = await database;
    return await db.query(
      'hyrox_penalty_log',
      where: 'session_id = ? AND id_estacion = ?',
      whereArgs: [sessionId, idEstacion],
      orderBy: 'applied_at ASC',
    );
  }

  // ── Cierre ────────────────────────────────────────────────────────────────

  Future<void> close() async {
    final db = _db;
    if (db != null) {
      await db.close();
      _db = null;
    }
  }
}
