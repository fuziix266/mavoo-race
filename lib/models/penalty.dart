// Modelo de penalizaciones Hyrox por estación
// Basado en reglamento internacional Hyrox 2024-2026

class PenaltyItem {
  const PenaltyItem({
    required this.label,
    required this.description,
    required this.penaltySeconds,
  });

  final String label;           // nombre corto para el botón
  final String description;     // descripción completa
  final int penaltySeconds;     // segundos a agregar al tiempo

  String get formattedPenalty {
    if (penaltySeconds >= 60) {
      final m = penaltySeconds ~/ 60;
      final s = penaltySeconds % 60;
      return s > 0 ? '+${m}m ${s}s' : '+${m}m';
    }
    return '+${penaltySeconds}s';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Penalizaciones globales (aplican a cualquier estación)
// ─────────────────────────────────────────────────────────────────────────────

const List<PenaltyItem> _generalPenalties = [
  PenaltyItem(
    label: 'Equipo incorrecto',
    description: 'Uso de equipo no aprobado o peso no reglamentario',
    penaltySeconds: 120, // 2 min
  ),
  PenaltyItem(
    label: 'Asistencia externa',
    description: 'Recibir ayuda no permitida de otra persona',
    penaltySeconds: 180, // 3 min
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// Penalizaciones por tipo de estación
// ─────────────────────────────────────────────────────────────────────────────

const Map<String, List<PenaltyItem>> stationPenalties = {

  'run': [
    PenaltyItem(
      label: 'Vuelta incompleta',
      description: 'No completar los 800m reglamentarios',
      penaltySeconds: 180, // 3 min
    ),
    PenaltyItem(
      label: 'Orden incorrecto',
      description: 'Ingresar a estación equivocada',
      penaltySeconds: 180, // 3 min
    ),
  ],

  'ski erg': [
    PenaltyItem(
      label: 'Rep incompleta',
      description: 'Rango de movimiento insuficiente (brazos no completan)',
      penaltySeconds: 15,
    ),
    PenaltyItem(
      label: 'Máquina soltada',
      description: 'Soltar las correas antes de completar la distancia',
      penaltySeconds: 30,
    ),
    PenaltyItem(
      label: 'Distancia incompleta',
      description: 'No completar la distancia reglamentaria',
      penaltySeconds: 120, // 2 min
    ),
  ],

  'farmer carry': [
    PenaltyItem(
      label: 'Soltar pesas',
      description: 'Dejar caer las pesas al suelo (por caída)',
      penaltySeconds: 15,
    ),
    PenaltyItem(
      label: 'Vuelta faltante',
      description: 'No completar una vuelta completa del recorrido',
      penaltySeconds: 180, // 3 min
    ),
    PenaltyItem(
      label: 'Carga incorrecta',
      description: 'No cargar ambas pesas durante el recorrido',
      penaltySeconds: 30,
    ),
  ],

  'row erg': [
    PenaltyItem(
      label: 'Rep incompleta',
      description: 'Stroke incompleto (sin extensión total de piernas)',
      penaltySeconds: 15,
    ),
    PenaltyItem(
      label: 'Distancia incompleta',
      description: 'No completar los metros reglamentarios',
      penaltySeconds: 120, // 2 min
    ),
  ],

  'burpees': [
    PenaltyItem(
      label: 'Rep inválida',
      description: 'Burpee sin contacto del pecho al suelo o salto incompleto',
      penaltySeconds: 15,
    ),
    PenaltyItem(
      label: 'No llega a la placa',
      description: 'El salto no supera la placa en altura',
      penaltySeconds: 15,
    ),
    PenaltyItem(
      label: '5 metros distancia',
      description: 'Penalización de distancia (2da advertencia)',
      penaltySeconds: 30,
    ),
  ],

  'plate sit up': [
    PenaltyItem(
      label: 'Rep incompleta',
      description: 'No llegar a posición vertical con el plato',
      penaltySeconds: 15,
    ),
    PenaltyItem(
      label: 'Manos incorrectas',
      description: 'Manos no detrás de la cabeza al bajar',
      penaltySeconds: 15,
    ),
  ],

  'lunges': [
    PenaltyItem(
      label: 'Rodilla toca suelo',
      description: 'La rodilla trasera hace contacto con el piso',
      penaltySeconds: 15,
    ),
    PenaltyItem(
      label: 'Paso corto',
      description: 'Zancada insuficiente (muslo no paralelo al suelo)',
      penaltySeconds: 15,
    ),
    PenaltyItem(
      label: 'Distancia incompleta',
      description: 'No completar el recorrido reglamentario',
      penaltySeconds: 180, // 3 min
    ),
  ],

  'kettlebell': [
    PenaltyItem(
      label: 'Swing incompleto',
      description: 'Kettlebell no llega a nivel de hombros (American Swing)',
      penaltySeconds: 15,
    ),
    PenaltyItem(
      label: 'Rep inválida',
      description: 'Sin extensión completa de cadera en el swing',
      penaltySeconds: 15,
    ),
    PenaltyItem(
      label: 'Peso incorrecto',
      description: 'Uso de peso no reglamentario para la categoría',
      penaltySeconds: 120, // 2 min
    ),
  ],

  'wall ball': [
    PenaltyItem(
      label: 'No llega al objetivo',
      description: 'La pelota no supera la marca de altura reglamentaria',
      penaltySeconds: 15,
    ),
    PenaltyItem(
      label: 'Rep inválida',
      description: 'Sentadilla sin bajar a 90° o lanzamiento incorrecto',
      penaltySeconds: 15,
    ),
    PenaltyItem(
      label: 'Peso incorrecto',
      description: 'Uso de pelota con peso no reglamentario',
      penaltySeconds: 120, // 2 min
    ),
  ],
};

// ─────────────────────────────────────────────────────────────────────────────
// Helper: obtener penalizaciones para una estación por nombre/tipo
// ─────────────────────────────────────────────────────────────────────────────

List<PenaltyItem> getPenaltiesForStation(String tipo, String nombre) {
  final n = nombre.toLowerCase();
  List<PenaltyItem>? specific;

  if (tipo == 'run') {
    specific = stationPenalties['run'];
  } else if (n.contains('ski')) {
    specific = stationPenalties['ski erg'];
  } else if (n.contains('farmer') || n.contains('carry')) {
    specific = stationPenalties['farmer carry'];
  } else if (n.contains('row')) {
    specific = stationPenalties['row erg'];
  } else if (n.contains('burpee')) {
    specific = stationPenalties['burpees'];
  } else if (n.contains('sit') || n.contains('plate')) {
    specific = stationPenalties['plate sit up'];
  } else if (n.contains('lunge')) {
    specific = stationPenalties['lunges'];
  } else if (n.contains('kettlebell') || n.contains('swing')) {
    specific = stationPenalties['kettlebell'];
  } else if (n.contains('wall') || n.contains('ball')) {
    specific = stationPenalties['wall ball'];
  }

  return [
    ...?specific,
    ..._generalPenalties,
  ];
}
