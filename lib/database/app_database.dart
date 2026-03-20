// ignore_for_file: type=lint
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';

part 'app_database.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Tablas — usamos DateTimeColumn para fechas (drift lo maneja cross-platform)
// ─────────────────────────────────────────────────────────────────────────────

class HyroxTiempos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idEquipo => integer()();
  IntColumn get idEstacion => integer()();
  IntColumn get tiempoMs => integer()();
  TextColumn get tiempoInicio => text().nullable()();
  TextColumn get tiempoFin => text().nullable()();
  IntColumn get sincronizado => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class HyroxRaceSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idEquipo => integer()();
  IntColumn get idHeat => integer()();
  TextColumn get nombreEquipo => text()();
  TextColumn get nombreHeat => text()();
  TextColumn get fecha => text()();
  IntColumn get finalizada => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class HyroxModules extends Table {
  IntColumn get id => integer()();
  TextColumn get key => text().unique()();
  TextColumn get nombre => text()();
  TextColumn get descripcion => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class HyroxPenaltyTypes extends Table {
  IntColumn get id => integer()();
  IntColumn get moduleId => integer()();
  TextColumn get label => text()();
  TextColumn get description => text().nullable()();
  IntColumn get penaltySeconds => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class HyroxPenaltyLog extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer()();
  IntColumn get idEquipo => integer()();
  IntColumn get idEstacion => integer()();
  IntColumn get moduleId => integer()();
  IntColumn get penaltyTypeId => integer()();
  IntColumn get penaltySeconds => integer()();
  IntColumn get timerMsAtPenalty => integer()();
  DateTimeColumn get appliedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get sincronizado => integer().withDefault(const Constant(0))();
}

// ─────────────────────────────────────────────────────────────────────────────
// Base de datos principal
// ─────────────────────────────────────────────────────────────────────────────

@DriftDatabase(tables: [
  HyroxTiempos,
  HyroxRaceSessions,
  HyroxModules,
  HyroxPenaltyTypes,
  HyroxPenaltyLog,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openDb());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedStaticData();
        },
      );

  static QueryExecutor _openDb() {
    return driftDatabase(
      name: 'mallkubox_race',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.dart.js'),
        onResult: (result) {
          if (result.missingFeatures.isNotEmpty) {
            debugPrint(
              'drift: using ${result.chosenImplementation} '
              'missing: ${result.missingFeatures}',
            );
          }
        },
      ),
    );
  }

  // ── Seed de datos estáticos ───────────────────────────────────────────────

  Future<void> _seedStaticData() async {
    final modules = [
      HyroxModulesCompanion.insert(id: const Value(1),  key: 'run',        nombre: 'Run',               descripcion: const Value('Tramo de carrera entre estaciones')),
      HyroxModulesCompanion.insert(id: const Value(2),  key: 'ski_erg',    nombre: 'SkiErg',            descripcion: const Value('Máquina de ski ergómetro')),
      HyroxModulesCompanion.insert(id: const Value(3),  key: 'sled_push',  nombre: 'Sled Push',         descripcion: const Value('Empuje de trineo con peso')),
      HyroxModulesCompanion.insert(id: const Value(4),  key: 'sled_pull',  nombre: 'Sled Pull',         descripcion: const Value('Halado de trineo con peso')),
      HyroxModulesCompanion.insert(id: const Value(5),  key: 'burpees',    nombre: 'Burpee Broad Jump', descripcion: const Value('Burpees con salto largo')),
      HyroxModulesCompanion.insert(id: const Value(6),  key: 'row_erg',    nombre: 'Rowing',            descripcion: const Value('Remo en ergómetro')),
      HyroxModulesCompanion.insert(id: const Value(7),  key: 'farmer',     nombre: 'Farmer Carry',      descripcion: const Value('Cargada de pesas con caminata')),
      HyroxModulesCompanion.insert(id: const Value(8),  key: 'lunges',     nombre: 'Sandbag Lunges',    descripcion: const Value('Estocadas con sacos de arena')),
      HyroxModulesCompanion.insert(id: const Value(9),  key: 'wall_ball',  nombre: 'Wall Ball Shots',   descripcion: const Value('Lanzamientos de balón a la pared')),
      HyroxModulesCompanion.insert(id: const Value(10), key: 'sit_up',     nombre: 'Plate Sit-Up',      descripcion: const Value('Abdominales con plato de peso')),
      HyroxModulesCompanion.insert(id: const Value(11), key: 'kettlebell', nombre: 'Kettlebell Swing',  descripcion: const Value('Balanceo de kettlebell (American)')),
    ];
    await batch((b) => b.insertAllOnConflictUpdate(hyroxModules, modules));

    final penalties = [
      _pt(1,  0, 'Equipo incorrecto',    'Uso de equipo no aprobado o peso no reglamentario', 120),
      _pt(2,  0, 'Asistencia externa',   'Recibir ayuda no permitida de otra persona',        180),
      _pt(3,  0, 'Roxzone incorrecto',   'Entrada/salida incorrecta del área de estación',    120),
      _pt(4,  0, 'Orden incorrecto',     'Completar estaciones en orden equivocado',          180),
      _pt(5,  1, 'Vuelta incompleta',    'No completar los metros reglamentarios del tramo',  180),
      _pt(6,  2, 'Rep incompleta',       'Rango de movimiento insuficiente en brazos',         15),
      _pt(7,  2, 'Máquina soltada',      'Soltar correas antes de completar la distancia',     30),
      _pt(8,  2, 'Distancia incompleta', 'No completar la distancia reglamentaria',           120),
      _pt(9,  3, 'Carril incompleto',    'No completar un carril completo de empuje',         180),
      _pt(10, 3, 'Técnica incorrecta',   'Empuje con técnica no reglamentaria',                15),
      _pt(11, 4, 'Carril incompleto',    'No completar un carril completo de halado',         180),
      _pt(12, 4, 'Distancia de retiro',  'Penalización de distancia (2da advertencia)',        30),
      _pt(13, 5, 'Rep inválida',         'Burpee sin pecho al suelo o salto incompleto',       15),
      _pt(14, 5, 'No llega a la placa',  'El salto no supera la marca de altura',              15),
      _pt(15, 5, 'Dist. penalización',   '5m de distancia por 2da advertencia',                30),
      _pt(16, 6, 'Stroke incompleto',    'Sin extensión total de piernas en el stroke',        15),
      _pt(17, 6, 'Distancia incompleta', 'No completar los metros reglamentarios',            120),
      _pt(18, 7, 'Soltar pesas',         'Dejar caer las pesas al suelo',                      15),
      _pt(19, 7, 'Vuelta faltante',      'No completar una vuelta del recorrido',             180),
      _pt(20, 7, 'Carga incorrecta',     'No cargar ambas pesas durante el recorrido',         30),
      _pt(21, 8, 'Rodilla toca suelo',   'La rodilla trasera hace contacto con el piso',       15),
      _pt(22, 8, 'Paso corto',           'Zancada insuficiente (muslo no paralelo al suelo)',  15),
      _pt(23, 8, 'Distancia incompleta', 'No completar el recorrido reglamentario',           180),
      _pt(24, 9, 'No llega al objetivo', 'La pelota no supera la marca de altura',             15),
      _pt(25, 9, 'Rep inválida',         'Sentadilla sin bajar a 90° o lanzamiento incorrecto', 15),
      _pt(26, 9, 'Peso incorrecto',      'Uso de pelota con peso no reglamentario',            120),
      _pt(27, 10, 'Rep incompleta',      'No llegar a posición vertical con el plato',         15),
      _pt(28, 10, 'ROM incorrecto',      'Manos no detrás de la cabeza al bajar',              15),
      _pt(29, 11, 'Swing incompleto',    'Kettlebell no llega a nivel de hombros',             15),
      _pt(30, 11, 'Rep inválida',        'Sin extensión completa de cadera en el swing',       15),
      _pt(31, 11, 'Peso incorrecto',     'Uso de peso no reglamentario para la categoría',    120),
    ];
    await batch((b) => b.insertAllOnConflictUpdate(hyroxPenaltyTypes, penalties));
  }

  HyroxPenaltyTypesCompanion _pt(int id, int mod, String label, String desc, int secs) =>
      HyroxPenaltyTypesCompanion.insert(
        id: Value(id),
        moduleId: mod,
        label: label,
        description: Value(desc),
        penaltySeconds: secs,
      );
}
