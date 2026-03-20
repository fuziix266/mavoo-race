// ─────────────────────────────────────────────────────────────────────────────
// Módulos Hyrox — todos los tipos de estación posibles en una carrera Hyrox
// IDs fijos que coinciden con la tabla hyrox_modules en la BD local
// Los datos se usan en la app de forma estática para velocidad instantánea.
// La BD solo guarda el LOG de lo que ocurre en carrera.
// ─────────────────────────────────────────────────────────────────────────────

class HyroxModule {
  const HyroxModule({
    required this.id,
    required this.key,
    required this.nombre,
    required this.descripcion,
  });

  final int id;
  final String key;       // clave interna para match con estaciones
  final String nombre;    // nombre display
  final String descripcion;
}

const List<HyroxModule> hyroxModules = [
  HyroxModule(id: 1,  key: 'run',        nombre: 'Run',              descripcion: 'Tramo de carrera entre estaciones'),
  HyroxModule(id: 2,  key: 'ski_erg',    nombre: 'SkiErg',           descripcion: 'Máquina de ski ergómetro'),
  HyroxModule(id: 3,  key: 'sled_push',  nombre: 'Sled Push',        descripcion: 'Empuje de trineo con peso'),
  HyroxModule(id: 4,  key: 'sled_pull',  nombre: 'Sled Pull',        descripcion: 'Halado de trineo con peso'),
  HyroxModule(id: 5,  key: 'burpees',    nombre: 'Burpee Broad Jump',descripcion: 'Burpees con salto largo'),
  HyroxModule(id: 6,  key: 'row_erg',    nombre: 'Rowing',           descripcion: 'Remo en ergómetro'),
  HyroxModule(id: 7,  key: 'farmer',     nombre: 'Farmer Carry',     descripcion: 'Cargada de pesas con caminata'),
  HyroxModule(id: 8,  key: 'lunges',     nombre: 'Sandbag Lunges',   descripcion: 'Estocadas con sacos de arena'),
  HyroxModule(id: 9,  key: 'wall_ball',  nombre: 'Wall Ball Shots',  descripcion: 'Lanzamientos de balón a la pared'),
  HyroxModule(id: 10, key: 'sit_up',     nombre: 'Plate Sit-Up',     descripcion: 'Abdominales con plato de peso'),
  HyroxModule(id: 11, key: 'kettlebell', nombre: 'Kettlebell Swing', descripcion: 'Balanceo de kettlebell (American)'),
];

// Helper para obtener el módulo desde el tipo y/o nombre de estación
HyroxModule? getModuleForStation(String tipo, String nombre) {
  final n = nombre.toLowerCase();
  final t = tipo.toLowerCase();

  if (t == 'run') return hyroxModules.firstWhere((m) => m.key == 'run');
  if (n.contains('ski')) return hyroxModules.firstWhere((m) => m.key == 'ski_erg');
  if (n.contains('sled') && n.contains('push')) return hyroxModules.firstWhere((m) => m.key == 'sled_push');
  if (n.contains('sled') && n.contains('pull')) return hyroxModules.firstWhere((m) => m.key == 'sled_pull');
  if (n.contains('burpee')) return hyroxModules.firstWhere((m) => m.key == 'burpees');
  if (n.contains('row')) return hyroxModules.firstWhere((m) => m.key == 'row_erg');
  if (n.contains('farmer') || n.contains('carry')) return hyroxModules.firstWhere((m) => m.key == 'farmer');
  if (n.contains('lunge')) return hyroxModules.firstWhere((m) => m.key == 'lunges');
  if (n.contains('wall') || n.contains('ball')) return hyroxModules.firstWhere((m) => m.key == 'wall_ball');
  if (n.contains('sit') || n.contains('plate')) return hyroxModules.firstWhere((m) => m.key == 'sit_up');
  if (n.contains('kettlebell') || n.contains('swing')) return hyroxModules.firstWhere((m) => m.key == 'kettlebell');
  return null;
}

// ─────────────────────────────────────────────────────────────────────────────
// Tipos de Penalización — Mallkubox Arica Race 2026
// ─────────────────────────────────────────────────────────────────────────────

class PenaltyItem {
  const PenaltyItem({
    required this.id,
    required this.moduleId,
    required this.label,
    required this.description,
    required this.penaltySeconds,
  });

  final int id;           // PK en hyrox_penalty_types
  final int moduleId;     // FK → HyroxModule.id (0 = global / todos los módulos)
  final String label;
  final String description;
  final int penaltySeconds;

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
// Catálogo de penalizaciones — Mallkubox Arica Race 2026
//
// Solo en ERG (Ski Erg después de Run 1, Row Erg después de Run 3):
//   • 5" por penalización en ergs
//
// Siempre disponibles (en todas las estaciones):
//   • 5" por actitud antideportiva
//   • 5" por tomar agua
//   • 3' por saltarse una estación
// ─────────────────────────────────────────────────────────────────────────────

/// Penalización específica para estaciones ERG (Ski Erg y Row Erg)
const PenaltyItem _penaltyErg = PenaltyItem(
  id: 1,
  moduleId: 2, // ERG
  label: 'Penalización Erg',
  description: 'Ejecución incorrecta del ejercicio: rango de movimiento incompleto o técnica deficiente',
  penaltySeconds: 5,
);

/// Penalizaciones globales — aparecen en TODAS las estaciones
const List<PenaltyItem> _globalPenalties = [
  PenaltyItem(
    id: 2,
    moduleId: 0,
    label: 'Actitud antideportiva',
    description: 'Conducta inapropiada o falta de respeto hacia jueces, competidores u organización',
    penaltySeconds: 5,
  ),
  PenaltyItem(
    id: 3,
    moduleId: 0,
    label: 'Tomar agua',
    description: 'Hidratarse durante la estación activa fuera de las zonas permitidas',
    penaltySeconds: 5,
  ),
  PenaltyItem(
    id: 4,
    moduleId: 0,
    label: 'Saltarse una estación',
    description: 'No completar o saltarse una estación del circuito de carrera',
    penaltySeconds: 180,
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// Helper: obtener penalizaciones para una estación
// Las ERG (Ski Erg y Row Erg) muestran las 4 penalizaciones.
// El resto de estaciones solo muestra las 3 globales.
// ─────────────────────────────────────────────────────────────────────────────

bool _isErgStation(String nombre) {
  final n = nombre.toLowerCase();
  return n.contains('ski') || n.contains('row') || n.contains('erg');
}

List<PenaltyItem> getPenaltiesForStation(String tipo, String nombre) {
  if (_isErgStation(nombre)) {
    return [_penaltyErg, ..._globalPenalties];
  }
  return [..._globalPenalties];
}
