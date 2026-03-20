import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../models/race_time.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DatabaseService — thin wrapper sobre AppDatabase (drift).
// Mantiene la misma API pública para race_provider y api_service.
// Compatible con Android, iOS y Web (SQLite/IndexedDB vía drift_flutter).
// ─────────────────────────────────────────────────────────────────────────────

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  final AppDatabase _db = AppDatabase();

  // ── Sessions ──────────────────────────────────────────────────────────────

  Future<int> saveSession({
    required int idEquipo,
    required int idHeat,
    required String nombreEquipo,
    required String nombreHeat,
  }) =>
      _db.into(_db.hyroxRaceSessions).insert(
            HyroxRaceSessionsCompanion.insert(
              idEquipo: idEquipo,
              idHeat: idHeat,
              nombreEquipo: nombreEquipo,
              nombreHeat: nombreHeat,
              fecha: DateTime.now().toIso8601String(),
            ),
          );

  Future<void> finalizeSession(int sessionId) =>
      (_db.update(_db.hyroxRaceSessions)
            ..where((t) => t.id.equals(sessionId)))
          .write(const HyroxRaceSessionsCompanion(finalizada: Value(1)));

  // ── Tiempos ───────────────────────────────────────────────────────────────

  Future<int> saveTime(RaceTime raceTime) =>
      _db.into(_db.hyroxTiempos).insert(
            HyroxTiemposCompanion.insert(
              idEquipo: raceTime.idEquipo,
              idEstacion: raceTime.idEstacion,
              tiempoMs: raceTime.tiempoMs,
              tiempoInicio: Value(raceTime.tiempoInicio?.toIso8601String()),
              tiempoFin: Value(raceTime.tiempoFin?.toIso8601String()),
              sincronizado: const Value(0),
            ),
          );

  Future<void> markSynced(int id) =>
      (_db.update(_db.hyroxTiempos)..where((t) => t.id.equals(id)))
          .write(const HyroxTiemposCompanion(sincronizado: Value(1)));

  Future<List<RaceTime>> getPendingSync() async {
    final rows = await (_db.select(_db.hyroxTiempos)
          ..where((t) => t.sincronizado.equals(0)))
        .get();
    return rows.map(_rowToRaceTime).toList();
  }

  Future<List<RaceTime>> getTimesByEquipo(int idEquipo) async {
    final rows = await (_db.select(_db.hyroxTiempos)
          ..where((t) => t.idEquipo.equals(idEquipo))
          ..orderBy([(t) => OrderingTerm.asc(t.idEstacion)]))
        .get();
    return rows.map(_rowToRaceTime).toList();
  }

  Future<void> deleteTime(int id) =>
      (_db.delete(_db.hyroxTiempos)..where((t) => t.id.equals(id))).go();

  // ── Penalizaciones ────────────────────────────────────────────────────────

  Future<int> savePenalty({
    required int sessionId,
    required int idEquipo,
    required int idEstacion,
    required int moduleId,
    required int penaltyTypeId,
    required int penaltySeconds,
    required int timerMsAtPenalty,
  }) =>
      _db.into(_db.hyroxPenaltyLog).insert(
            HyroxPenaltyLogCompanion.insert(
              sessionId: sessionId,
              idEquipo: idEquipo,
              idEstacion: idEstacion,
              moduleId: moduleId,
              penaltyTypeId: penaltyTypeId,
              penaltySeconds: penaltySeconds,
              timerMsAtPenalty: timerMsAtPenalty,
              appliedAt: Value(DateTime.now()),
            ),
          );

  Future<List<Map<String, dynamic>>> getPenaltiesBySession(
      int sessionId) async {
    final rows = await (_db.select(_db.hyroxPenaltyLog)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.asc(t.appliedAt)]))
        .get();
    return rows.map(_penaltyRowToMap).toList();
  }

  Future<List<Map<String, dynamic>>> getPenaltiesByEstacion(
      int sessionId, int idEstacion) async {
    final rows = await (_db.select(_db.hyroxPenaltyLog)
          ..where((t) =>
              t.sessionId.equals(sessionId) & t.idEstacion.equals(idEstacion))
          ..orderBy([(t) => OrderingTerm.asc(t.appliedAt)]))
        .get();
    return rows.map(_penaltyRowToMap).toList();
  }

  // ── Helpers de conversión ─────────────────────────────────────────────────

  RaceTime _rowToRaceTime(HyroxTiempo row) => RaceTime(
        id: row.id,
        idEquipo: row.idEquipo,
        idEstacion: row.idEstacion,
        tiempoMs: row.tiempoMs,
        tiempoInicio: row.tiempoInicio != null ? DateTime.tryParse(row.tiempoInicio!) : null,
        tiempoFin: row.tiempoFin != null ? DateTime.tryParse(row.tiempoFin!) : null,
        sincronizado: row.sincronizado == 1,
      );

  Map<String, dynamic> _penaltyRowToMap(HyroxPenaltyLogData row) => {
        'id': row.id,
        'session_id': row.sessionId,
        'id_equipo': row.idEquipo,
        'id_estacion': row.idEstacion,
        'module_id': row.moduleId,
        'penalty_type_id': row.penaltyTypeId,
        'penalty_seconds': row.penaltySeconds,
        'timer_ms_at_penalty': row.timerMsAtPenalty,
        'applied_at': row.appliedAt.toIso8601String(),
        'sincronizado': row.sincronizado,
      };

  // ── Cierre ────────────────────────────────────────────────────────────────

  Future<void> close() => _db.close();
}
