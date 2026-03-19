class RaceTime {
  final int? id;
  final int idEquipo;
  final int idEstacion;
  final int tiempoMs; // Tiempo en milisegundos
  final DateTime? tiempoInicio;
  final DateTime? tiempoFin;
  bool sincronizado;

  RaceTime({
    this.id,
    required this.idEquipo,
    required this.idEstacion,
    required this.tiempoMs,
    this.tiempoInicio,
    this.tiempoFin,
    this.sincronizado = false,
  });

  /// Tiempo formateado como HH:mm:ss.mmm
  String get tiempoFormateado {
    final total = tiempoMs;
    final horas = (total ~/ 3600000).toString().padLeft(2, '0');
    final minutos = ((total % 3600000) ~/ 60000).toString().padLeft(2, '0');
    final segundos = ((total % 60000) ~/ 1000).toString().padLeft(2, '0');
    final millis = ((total % 1000) ~/ 10).toString().padLeft(2, '0');
    return '$horas:$minutos:$segundos.$millis';
  }

  /// Tiempo en segundos (para API)
  double get tiempoSegundos => tiempoMs / 1000.0;

  factory RaceTime.fromMap(Map<String, dynamic> map) {
    return RaceTime(
      id: map['id'],
      idEquipo: map['id_equipo'],
      idEstacion: map['id_estacion'],
      tiempoMs: map['tiempo_ms'],
      tiempoInicio: map['tiempo_inicio'] != null
          ? DateTime.tryParse(map['tiempo_inicio'])
          : null,
      tiempoFin: map['tiempo_fin'] != null
          ? DateTime.tryParse(map['tiempo_fin'])
          : null,
      sincronizado: (map['sincronizado'] ?? 0) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'id_equipo': idEquipo,
      'id_estacion': idEstacion,
      'tiempo_ms': tiempoMs,
      'tiempo_inicio': tiempoInicio?.toIso8601String(),
      'tiempo_fin': tiempoFin?.toIso8601String(),
      'sincronizado': sincronizado ? 1 : 0,
    };
  }

  Map<String, dynamic> toApiMap() {
    return {
      'id_equipo': idEquipo,
      'id_estacion': idEstacion,
      'tiempo_segundos': tiempoSegundos,
      'tiempo_inicio': tiempoInicio?.toIso8601String(),
      'tiempo_fin': tiempoFin?.toIso8601String(),
    };
  }
}
