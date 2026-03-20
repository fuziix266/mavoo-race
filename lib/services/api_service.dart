import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/race_time.dart';
import 'database_service.dart';

class ApiService {
  // URL del servidor de producción
  static const String baseUrl = 'https://mavoo.fit/hyrox/api';
  // Para pruebas locales en la misma red WiFi, usa la IP del PC:
  // static const String baseUrl = 'http://192.168.x.x/mavoo-laminas/public/hyrox/api';
  static const Duration timeout = Duration(seconds: 15);


  final DatabaseService _db = DatabaseService();

  /// Envía un tiempo al backend. Si falla, queda pendiente en SQLite.
  Future<bool> sendTime(RaceTime raceTime) async {
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
    } catch (e) {
      // Sin conexión, el dato ya está seguro en SQLite
    }
    return false;
  }

  /// Intenta sincronizar todos los tiempos pendientes
  Future<int> syncPending() async {
    int synced = 0;
    final pending = await _db.getPendingSync();
    for (final rt in pending) {
      if (await sendTime(rt)) synced++;
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
