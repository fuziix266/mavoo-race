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
// Tipos de Penalización — con IDs fijos que coinciden con hyrox_penalty_types
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
// Catálogo completo de tipos de penalización — IDs fijos
// module_id 0 = aplica a cualquier módulo (penalización global)
// ─────────────────────────────────────────────────────────────────────────────

const List<PenaltyItem> allPenaltyTypes = [
  // ── Globales (module_id = 0) ────────────────────────────
  PenaltyItem(id: 1,  moduleId: 0, label: 'Equipo incorrecto',    description: 'Uso de equipo no aprobado o peso no reglamentario', penaltySeconds: 120),
  PenaltyItem(id: 2,  moduleId: 0, label: 'Asistencia externa',   description: 'Recibir ayuda no permitida de otra persona',        penaltySeconds: 180),
  PenaltyItem(id: 3,  moduleId: 0, label: 'Roxzone incorrecto',   description: 'Entrada/salida incorrecta del área de estación',    penaltySeconds: 120),
  PenaltyItem(id: 4,  moduleId: 0, label: 'Orden incorrecto',     description: 'Completar estaciones en orden equivocado',          penaltySeconds: 180),

  // ── Run (module_id = 1) ─────────────────────────────────
  PenaltyItem(id: 5,  moduleId: 1, label: 'Vuelta incompleta',    description: 'No completar los metros reglamentarios del tramo',  penaltySeconds: 180),

  // ── SkiErg (module_id = 2) ──────────────────────────────
  PenaltyItem(id: 6,  moduleId: 2, label: 'Rep incompleta',       description: 'Rango de movimiento insuficiente en brazos',        penaltySeconds: 15),
  PenaltyItem(id: 7,  moduleId: 2, label: 'Máquina soltada',      description: 'Soltar correas antes de completar la distancia',    penaltySeconds: 30),
  PenaltyItem(id: 8,  moduleId: 2, label: 'Distancia incompleta', description: 'No completar la distancia reglamentaria',           penaltySeconds: 120),

  // ── Sled Push (module_id = 3) ───────────────────────────
  PenaltyItem(id: 9,  moduleId: 3, label: 'Carril incompleto',    description: 'No completar un carril completo de empuje',         penaltySeconds: 180),
  PenaltyItem(id: 10, moduleId: 3, label: 'Técnica incorrecta',   description: 'Empuje con técnica no reglamentaria',               penaltySeconds: 15),

  // ── Sled Pull (module_id = 4) ───────────────────────────
  PenaltyItem(id: 11, moduleId: 4, label: 'Carril incompleto',    description: 'No completar un carril completo de halado',         penaltySeconds: 180),
  PenaltyItem(id: 12, moduleId: 4, label: 'Distancia de retiro',  description: 'Penalización de distancia (2da advertencia)',       penaltySeconds: 30),

  // ── Burpees (module_id = 5) ─────────────────────────────
  PenaltyItem(id: 13, moduleId: 5, label: 'Rep inválida',         description: 'Burpee sin pecho al suelo o salto incompleto',      penaltySeconds: 15),
  PenaltyItem(id: 14, moduleId: 5, label: 'No llega a la placa',  description: 'El salto no supera la marca de altura',             penaltySeconds: 15),
  PenaltyItem(id: 15, moduleId: 5, label: 'Dist. penalización',   description: '5m de distancia por 2da advertencia',               penaltySeconds: 30),

  // ── Rowing (module_id = 6) ──────────────────────────────
  PenaltyItem(id: 16, moduleId: 6, label: 'Stroke incompleto',    description: 'Sin extensión total de piernas en el stroke',       penaltySeconds: 15),
  PenaltyItem(id: 17, moduleId: 6, label: 'Distancia incompleta', description: 'No completar los metros reglamentarios',            penaltySeconds: 120),

  // ── Farmer Carry (module_id = 7) ────────────────────────
  PenaltyItem(id: 18, moduleId: 7, label: 'Soltar pesas',         description: 'Dejar caer las pesas al suelo',                    penaltySeconds: 15),
  PenaltyItem(id: 19, moduleId: 7, label: 'Vuelta faltante',      description: 'No completar una vuelta del recorrido',            penaltySeconds: 180),
  PenaltyItem(id: 20, moduleId: 7, label: 'Carga incorrecta',     description: 'No cargar ambas pesas durante el recorrido',       penaltySeconds: 30),

  // ── Lunges (module_id = 8) ──────────────────────────────
  PenaltyItem(id: 21, moduleId: 8, label: 'Rodilla toca suelo',   description: 'La rodilla trasera hace contacto con el piso',     penaltySeconds: 15),
  PenaltyItem(id: 22, moduleId: 8, label: 'Paso corto',           description: 'Zancada insuficiente (muslo no paralelo al suelo)',  penaltySeconds: 15),
  PenaltyItem(id: 23, moduleId: 8, label: 'Distancia incompleta', description: 'No completar el recorrido reglamentario',           penaltySeconds: 180),

  // ── Wall Ball (module_id = 9) ───────────────────────────
  PenaltyItem(id: 24, moduleId: 9, label: 'No llega al objetivo', description: 'La pelota no supera la marca de altura',           penaltySeconds: 15),
  PenaltyItem(id: 25, moduleId: 9, label: 'Rep inválida',         description: 'Sentadilla sin bajar a 90° o lanzamiento incorrecto', penaltySeconds: 15),
  PenaltyItem(id: 26, moduleId: 9, label: 'Peso incorrecto',      description: 'Uso de pelota con peso no reglamentario',          penaltySeconds: 120),

  // ── Plate Sit-Up (module_id = 10) ───────────────────────
  PenaltyItem(id: 27, moduleId: 10, label: 'Rep incompleta',      description: 'No llegar a posición vertical con el plato',       penaltySeconds: 15),
  PenaltyItem(id: 28, moduleId: 10, label: 'ROM incorrecto',      description: 'Manos no detrás de la cabeza al bajar',            penaltySeconds: 15),

  // ── Kettlebell (module_id = 11) ─────────────────────────
  PenaltyItem(id: 29, moduleId: 11, label: 'Swing incompleto',    description: 'Kettlebell no llega a nivel de hombros',           penaltySeconds: 15),
  PenaltyItem(id: 30, moduleId: 11, label: 'Rep inválida',        description: 'Sin extensión completa de cadera en el swing',     penaltySeconds: 15),
  PenaltyItem(id: 31, moduleId: 11, label: 'Peso incorrecto',     description: 'Uso de peso no reglamentario para la categoría',   penaltySeconds: 120),
];

// ─────────────────────────────────────────────────────────────────────────────
// Helper: obtener penalizaciones para una estación (específicas + globales)
// ─────────────────────────────────────────────────────────────────────────────

List<PenaltyItem> getPenaltiesForStation(String tipo, String nombre) {
  final module = getModuleForStation(tipo, nombre);
  final moduleId = module?.id ?? 0;

  final specific = allPenaltyTypes.where((p) => p.moduleId == moduleId).toList();
  final globals   = allPenaltyTypes.where((p) => p.moduleId == 0).toList();

  return [...specific, ...globals];
}
