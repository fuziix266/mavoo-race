import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/race_time.dart';
import 'database_service.dart';

class ApiService {
  // URL del servidor de producción
  static const String baseUrl = 'https://mavoo.fit/races/api';
  // Para pruebas locales en la misma red WiFi, usa la IP del PC:
  // static const String baseUrl = 'http://192.168.x.x/mavoo-laminas/public/races/api';
  static const Duration timeout = Duration(seconds: 15);

  final DatabaseService _db = DatabaseService();

  // ── Sync automático ────────────────────────────────────────────────────────
  Timer? _syncTimer;
  bool _syncing = false;

  /// Inicia el timer de sincronización automática.
  /// Reintenta cada [intervalSeconds] segundos mientras haya tiempos pendientes.
  void startAutoSync({int intervalSeconds = 30}) {
    stopAutoSync(); // evitar duplicados
    _syncTimer = Timer.periodic(
      Duration(seconds: intervalSeconds),
      (_) => _autoSyncTick(),
    );
    debugPrint('[ApiService] Auto-sync iniciado (cada ${intervalSeconds}s)');
  }

  /// Detiene el timer de sincronización automática.
  void stopAutoSync() {
    _syncTimer?.cancel();
    _syncTimer = null;
  }

  Future<void> _autoSyncTick() async {
    if (_syncing) return; // evitar ejecuciones concurrentes
    _syncing = true;
    try {
      final synced = await syncPending();
      if (synced > 0) {
        debugPrint('[ApiService] Auto-sync: $synced tiempos sincronizados');
      }
    } catch (e) {
      debugPrint('[ApiService] Auto-sync error: $e');
    } finally {
      _syncing = false;
    }
  }

  // ── Envío de tiempos ───────────────────────────────────────────────────────

  /// Envía un tiempo al backend.
  /// En web: reintenta hasta [maxRetries] veces con backoff exponencial.
  /// Si falla, queda pendiente en SQLite/IndexedDB para auto-sync posterior.
  Future<bool> sendTime(RaceTime raceTime, {int maxRetries = 3}) async {
    for (int attempt = 0; attempt <= maxRetries; attempt++) {
      try {
        final response = await http
            .post(
              Uri.parse('$baseUrl/tiempo'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(raceTime.toApiMap()),
            )
            .timeout(timeout);

        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);
          if (body['success'] == true && raceTime.id != null) {
            await _db.markSynced(raceTime.id!);
            return true;
          }
        }
        // Server respondió pero no fue success → no reintentar
        break;
      } catch (e) {
        // Sin conexión o timeout
        if (attempt < maxRetries) {
          // Backoff exponencial: 1s, 2s, 4s
          final delay = Duration(seconds: 1 << attempt);
          debugPrint(
            '[ApiService] Reintento ${attempt + 1}/$maxRetries en ${delay.inSeconds}s',
          );
          await Future.delayed(delay);
        }
      }
    }
    return false;
  }

  /// Intenta sincronizar todos los tiempos pendientes
  Future<int> syncPending() async {
    int synced = 0;
    final pending = await _db.getPendingSync();
    for (final rt in pending) {
      // Para sync pendientes usamos 1 solo reintento (el auto-sync volverá a intentar)
      if (await sendTime(rt, maxRetries: 1)) synced++;
    }
    return synced;
  }

  /// Obtiene resultados del dashboard (puede fallar sin conexión)
  Future<Map<String, dynamic>?> getResults() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/resultados'))
          .timeout(timeout);
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (_) {}
    return null;
  }

  /// Ping al servidor
  Future<bool> isServerReachable() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/ping'))
          .timeout(const Duration(seconds: 3));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
