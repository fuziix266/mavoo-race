import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/station.dart';
import '../models/heat.dart';
import '../models/race_time.dart';
import '../models/penalty.dart';
import '../services/database_service.dart';
import '../services/api_service.dart';

enum RaceState { idle, running, paused, finished }

class RaceProvider with ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  final ApiService _api = ApiService();

  // Selección
  Heat? selectedHeat;
  Team? selectedTeam;

  // Carrera
  final List<Station> stations = Station.allStations;
  int currentStationIndex = 0;
  RaceState raceState = RaceState.idle;

  // Cronómetro
  Timer? _timer;
  int _elapsedMs = 0;        // tiempo actual de la estación
  DateTime? _startTime;

  // Historial de tiempos (ya guardados)
  final List<RaceTime> completedTimes = [];
  // Tiempo provisional (pendiente de confirmar al iniciar la siguiente estación)
  RaceTime? _pendingTime;
  int? _sessionId;

  // Penalizaciones
  int totalPenaltyMs = 0;    // suma total de penalizaciones de la estación
  int penaltyCount = 0;      // cantidad de penalizaciones aplicadas

  // ── Getters ───────────────────────────────────────────────────────────────

  Station get currentStation => stations[currentStationIndex];
  int get elapsedMs => _elapsedMs;
  bool get isRunning => raceState == RaceState.running;
  bool get isFirstStation => currentStationIndex == 0;
  bool get isLastStation => currentStationIndex == stations.length - 1;
  bool get hasFinishedCurrentStation => _pendingTime != null;
  /// Permite volver si: no es la primera estación Y el cronómetro no está corriendo
  bool get canGoBack => currentStationIndex > 0 && !isRunning;

  /// Suma acumulada de todos los tiempos completados (en ms)
  int get totalMs => completedTimes.fold(0, (sum, t) => sum + t.tiempoMs);

  /// Tiempo total formateado HH:mm:ss
  String get formattedTotalTime {
    final ms = totalMs;
    final h = (ms ~/ 3600000).toString().padLeft(2, '0');
    final m = ((ms % 3600000) ~/ 60000).toString().padLeft(2, '0');
    final s = ((ms % 60000) ~/ 1000).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  String get formattedTime {
    final ms = _elapsedMs;
    final h = (ms ~/ 3600000).toString().padLeft(2, '0');
    final m = ((ms % 3600000) ~/ 60000).toString().padLeft(2, '0');
    final s = ((ms % 60000) ~/ 1000).toString().padLeft(2, '0');
    final cs = ((ms % 1000) ~/ 10).toString().padLeft(2, '0');
    return '$h:$m:$s.$cs';
  }

  // ── Configuración ─────────────────────────────────────────────────────────

  void selectHeat(Heat heat) {
    selectedHeat = heat;
    selectedTeam = null;
    notifyListeners();
  }

  void selectTeam(Team team) {
    selectedTeam = team;
    notifyListeners();
  }

  Future<void> startRace() async {
    if (selectedTeam == null || selectedHeat == null) return;
    currentStationIndex = 0;
    completedTimes.clear();
    _pendingTime = null;
    _elapsedMs = 0;
    raceState = RaceState.idle;

    // Crear sesión en SQLite
    _sessionId = await _db.saveSession(
      idEquipo: selectedTeam!.id,
      idHeat: selectedHeat!.id,
      nombreEquipo: selectedTeam!.nombre,
      nombreHeat: selectedHeat!.nombre,
    );
    notifyListeners();
  }

  // ── Cronómetro ────────────────────────────────────────────────────────────

  void startTimer() {
    if (raceState == RaceState.running) return;

    // Cancelar cualquier timer anterior que pudiera estar corriendo
    _timer?.cancel();
    _timer = null;

    // Si había un tiempo provisional pendiente, lo descartamos
    // (no debería ocurrir aquí, pero por seguridad)
    _pendingTime = null;

    raceState = RaceState.running;
    _elapsedMs = 0;
    _startTime = DateTime.now();

    _timer = Timer.periodic(const Duration(milliseconds: 17), (_) {
      if (_startTime != null) {
        _elapsedMs = DateTime.now().difference(_startTime!).inMilliseconds;
        notifyListeners();
      }
    });
  }

  /// Reanudar el cronómetro desde el tiempo actual (sin reiniciar a 0)
  void resumeTimer() {
    if (raceState == RaceState.running) return;
    // Descartamos el pendingTime (el usuario quiere corregir el tiempo)
    _pendingTime = null;
    raceState = RaceState.running;
    // Ajustamos _startTime para que el elapsed acumulado se mantenga
    _startTime = DateTime.now().subtract(Duration(milliseconds: _elapsedMs));

    _timer = Timer.periodic(const Duration(milliseconds: 17), (_) {
      if (_startTime != null) {
        _elapsedMs = DateTime.now().difference(_startTime!).inMilliseconds;
        notifyListeners();
      }
    });
  }

  /// Agregar penalización al tiempo. Recibe el PenaltyItem completo para persistir en BD.
  void addPenalty(PenaltyItem penalty) {
    final ms = penalty.penaltySeconds * 1000;
    totalPenaltyMs += ms;
    penaltyCount++;

    // Capturamos el timer en el momento justo antes de alterar el tiempo
    final timerMsAtPenalty = _elapsedMs;

    // Ajustar el cronómetro
    if (raceState == RaceState.running && _startTime != null) {
      _startTime = _startTime!.subtract(Duration(milliseconds: ms));
    } else {
      _elapsedMs += ms;
    }
    notifyListeners();

    // Persistir en BD en background (no bloquear la UI)
    if (_sessionId != null && selectedTeam != null) {
      final station = currentStation;
      final module = getModuleForStation(station.tipo, station.nombre);
      _db.savePenalty(
        sessionId: _sessionId!,
        idEquipo: selectedTeam!.id,
        idEstacion: station.id,
        moduleId: module?.id ?? 0,
        penaltyTypeId: penalty.id,
        penaltySeconds: penalty.penaltySeconds,
        timerMsAtPenalty: timerMsAtPenalty,
      );
    }
  }

  /// Parar el cronómetro y crear un tiempo provisional (aún NO guardado en DB)
  void stopTimer() {
    if (raceState != RaceState.running) return;
    _timer?.cancel();
    raceState = RaceState.paused;

    final finishTime = DateTime.now();
    _pendingTime = RaceTime(
      idEquipo: selectedTeam!.id,
      idEstacion: currentStation.id,
      tiempoMs: _elapsedMs,
      tiempoInicio: _startTime,
      tiempoFin: finishTime,
    );
    notifyListeners();
  }

  /// Confirmar el tiempo provisional -> guardarlo en SQLite -> avanzar estación
  Future<void> _confirmPendingTime() async {
    final pending = _pendingTime;
    if (pending == null) return;

    final id = await _db.saveTime(pending);
    final saved = RaceTime(
      id: id,
      idEquipo: pending.idEquipo,
      idEstacion: pending.idEstacion,
      tiempoMs: pending.tiempoMs,
      tiempoInicio: pending.tiempoInicio,
      tiempoFin: pending.tiempoFin,
    );
    completedTimes.add(saved);
    _pendingTime = null;

    // Intentar sync en background (no bloquear UI)
    _api.sendTime(saved);
  }

  /// Avanzar a la siguiente estación: confirma el tiempo pendiente YA y limpia el estado
  Future<void> goToNextStation() async {
    if (currentStationIndex >= stations.length - 1) return;

    // Confirmar el tiempo provisional AHORA (guardar en SQLite + sync)
    if (_pendingTime != null) {
      await _confirmPendingTime();
    }

    currentStationIndex++;
    _elapsedMs = 0;
    _pendingTime = null; // garantizar limpieza total
    totalPenaltyMs = 0;  // resetear penalizaciones de la estación
    penaltyCount = 0;
    raceState = RaceState.idle;
    notifyListeners();
  }


  /// BOTÓN VOLVER: descarta el tiempo provisional y vuelve a la estación anterior
  /// El cronómetro continúa desde cero (la estación anterior se re-cronometra).
  /// IMPORTANTE: el tiempo registrado en completedTimes de la estación anterior
  /// se elimina y el árbitro debe volver a cronometrar esa estación.
  Future<void> goBack() async {
    if (currentStationIndex <= 0) return;

    _timer?.cancel();
    _pendingTime = null; // Descarta tiempo provisional
    _elapsedMs = 0;

    // Si ya habíamos guardado el tiempo de la estación anterior, lo eliminamos
    if (completedTimes.isNotEmpty) {
      final last = completedTimes.removeLast();
      if (last.id != null) {
        await _db.deleteTime(last.id!);
      }
    }

    currentStationIndex--;
    raceState = RaceState.idle;
    notifyListeners();
  }

  /// Finalizar la carrera completa
  Future<void> finishRace() async {
    if (_pendingTime != null) {
      await _confirmPendingTime();
    }
    _timer?.cancel();
    if (_sessionId != null) {
      await _db.finalizeSession(_sessionId!);
    }
    raceState = RaceState.finished;

    // Sync en background
    _api.syncPending();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
