// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HyroxTiemposTable extends HyroxTiempos
    with TableInfo<$HyroxTiemposTable, HyroxTiempo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HyroxTiemposTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idEquipoMeta = const VerificationMeta(
    'idEquipo',
  );
  @override
  late final GeneratedColumn<int> idEquipo = GeneratedColumn<int>(
    'id_equipo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idEstacionMeta = const VerificationMeta(
    'idEstacion',
  );
  @override
  late final GeneratedColumn<int> idEstacion = GeneratedColumn<int>(
    'id_estacion',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tiempoMsMeta = const VerificationMeta(
    'tiempoMs',
  );
  @override
  late final GeneratedColumn<int> tiempoMs = GeneratedColumn<int>(
    'tiempo_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tiempoInicioMeta = const VerificationMeta(
    'tiempoInicio',
  );
  @override
  late final GeneratedColumn<String> tiempoInicio = GeneratedColumn<String>(
    'tiempo_inicio',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tiempoFinMeta = const VerificationMeta(
    'tiempoFin',
  );
  @override
  late final GeneratedColumn<String> tiempoFin = GeneratedColumn<String>(
    'tiempo_fin',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sincronizadoMeta = const VerificationMeta(
    'sincronizado',
  );
  @override
  late final GeneratedColumn<int> sincronizado = GeneratedColumn<int>(
    'sincronizado',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    idEquipo,
    idEstacion,
    tiempoMs,
    tiempoInicio,
    tiempoFin,
    sincronizado,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hyrox_tiempos';
  @override
  VerificationContext validateIntegrity(
    Insertable<HyroxTiempo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_equipo')) {
      context.handle(
        _idEquipoMeta,
        idEquipo.isAcceptableOrUnknown(data['id_equipo']!, _idEquipoMeta),
      );
    } else if (isInserting) {
      context.missing(_idEquipoMeta);
    }
    if (data.containsKey('id_estacion')) {
      context.handle(
        _idEstacionMeta,
        idEstacion.isAcceptableOrUnknown(data['id_estacion']!, _idEstacionMeta),
      );
    } else if (isInserting) {
      context.missing(_idEstacionMeta);
    }
    if (data.containsKey('tiempo_ms')) {
      context.handle(
        _tiempoMsMeta,
        tiempoMs.isAcceptableOrUnknown(data['tiempo_ms']!, _tiempoMsMeta),
      );
    } else if (isInserting) {
      context.missing(_tiempoMsMeta);
    }
    if (data.containsKey('tiempo_inicio')) {
      context.handle(
        _tiempoInicioMeta,
        tiempoInicio.isAcceptableOrUnknown(
          data['tiempo_inicio']!,
          _tiempoInicioMeta,
        ),
      );
    }
    if (data.containsKey('tiempo_fin')) {
      context.handle(
        _tiempoFinMeta,
        tiempoFin.isAcceptableOrUnknown(data['tiempo_fin']!, _tiempoFinMeta),
      );
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
        _sincronizadoMeta,
        sincronizado.isAcceptableOrUnknown(
          data['sincronizado']!,
          _sincronizadoMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HyroxTiempo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HyroxTiempo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      idEquipo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_equipo'],
      )!,
      idEstacion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_estacion'],
      )!,
      tiempoMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tiempo_ms'],
      )!,
      tiempoInicio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tiempo_inicio'],
      ),
      tiempoFin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tiempo_fin'],
      ),
      sincronizado: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sincronizado'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HyroxTiemposTable createAlias(String alias) {
    return $HyroxTiemposTable(attachedDatabase, alias);
  }
}

class HyroxTiempo extends DataClass implements Insertable<HyroxTiempo> {
  final int id;
  final int idEquipo;
  final int idEstacion;
  final int tiempoMs;
  final String? tiempoInicio;
  final String? tiempoFin;
  final int sincronizado;
  final DateTime createdAt;
  const HyroxTiempo({
    required this.id,
    required this.idEquipo,
    required this.idEstacion,
    required this.tiempoMs,
    this.tiempoInicio,
    this.tiempoFin,
    required this.sincronizado,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_equipo'] = Variable<int>(idEquipo);
    map['id_estacion'] = Variable<int>(idEstacion);
    map['tiempo_ms'] = Variable<int>(tiempoMs);
    if (!nullToAbsent || tiempoInicio != null) {
      map['tiempo_inicio'] = Variable<String>(tiempoInicio);
    }
    if (!nullToAbsent || tiempoFin != null) {
      map['tiempo_fin'] = Variable<String>(tiempoFin);
    }
    map['sincronizado'] = Variable<int>(sincronizado);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HyroxTiemposCompanion toCompanion(bool nullToAbsent) {
    return HyroxTiemposCompanion(
      id: Value(id),
      idEquipo: Value(idEquipo),
      idEstacion: Value(idEstacion),
      tiempoMs: Value(tiempoMs),
      tiempoInicio: tiempoInicio == null && nullToAbsent
          ? const Value.absent()
          : Value(tiempoInicio),
      tiempoFin: tiempoFin == null && nullToAbsent
          ? const Value.absent()
          : Value(tiempoFin),
      sincronizado: Value(sincronizado),
      createdAt: Value(createdAt),
    );
  }

  factory HyroxTiempo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HyroxTiempo(
      id: serializer.fromJson<int>(json['id']),
      idEquipo: serializer.fromJson<int>(json['idEquipo']),
      idEstacion: serializer.fromJson<int>(json['idEstacion']),
      tiempoMs: serializer.fromJson<int>(json['tiempoMs']),
      tiempoInicio: serializer.fromJson<String?>(json['tiempoInicio']),
      tiempoFin: serializer.fromJson<String?>(json['tiempoFin']),
      sincronizado: serializer.fromJson<int>(json['sincronizado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idEquipo': serializer.toJson<int>(idEquipo),
      'idEstacion': serializer.toJson<int>(idEstacion),
      'tiempoMs': serializer.toJson<int>(tiempoMs),
      'tiempoInicio': serializer.toJson<String?>(tiempoInicio),
      'tiempoFin': serializer.toJson<String?>(tiempoFin),
      'sincronizado': serializer.toJson<int>(sincronizado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HyroxTiempo copyWith({
    int? id,
    int? idEquipo,
    int? idEstacion,
    int? tiempoMs,
    Value<String?> tiempoInicio = const Value.absent(),
    Value<String?> tiempoFin = const Value.absent(),
    int? sincronizado,
    DateTime? createdAt,
  }) => HyroxTiempo(
    id: id ?? this.id,
    idEquipo: idEquipo ?? this.idEquipo,
    idEstacion: idEstacion ?? this.idEstacion,
    tiempoMs: tiempoMs ?? this.tiempoMs,
    tiempoInicio: tiempoInicio.present ? tiempoInicio.value : this.tiempoInicio,
    tiempoFin: tiempoFin.present ? tiempoFin.value : this.tiempoFin,
    sincronizado: sincronizado ?? this.sincronizado,
    createdAt: createdAt ?? this.createdAt,
  );
  HyroxTiempo copyWithCompanion(HyroxTiemposCompanion data) {
    return HyroxTiempo(
      id: data.id.present ? data.id.value : this.id,
      idEquipo: data.idEquipo.present ? data.idEquipo.value : this.idEquipo,
      idEstacion: data.idEstacion.present
          ? data.idEstacion.value
          : this.idEstacion,
      tiempoMs: data.tiempoMs.present ? data.tiempoMs.value : this.tiempoMs,
      tiempoInicio: data.tiempoInicio.present
          ? data.tiempoInicio.value
          : this.tiempoInicio,
      tiempoFin: data.tiempoFin.present ? data.tiempoFin.value : this.tiempoFin,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HyroxTiempo(')
          ..write('id: $id, ')
          ..write('idEquipo: $idEquipo, ')
          ..write('idEstacion: $idEstacion, ')
          ..write('tiempoMs: $tiempoMs, ')
          ..write('tiempoInicio: $tiempoInicio, ')
          ..write('tiempoFin: $tiempoFin, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    idEquipo,
    idEstacion,
    tiempoMs,
    tiempoInicio,
    tiempoFin,
    sincronizado,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HyroxTiempo &&
          other.id == this.id &&
          other.idEquipo == this.idEquipo &&
          other.idEstacion == this.idEstacion &&
          other.tiempoMs == this.tiempoMs &&
          other.tiempoInicio == this.tiempoInicio &&
          other.tiempoFin == this.tiempoFin &&
          other.sincronizado == this.sincronizado &&
          other.createdAt == this.createdAt);
}

class HyroxTiemposCompanion extends UpdateCompanion<HyroxTiempo> {
  final Value<int> id;
  final Value<int> idEquipo;
  final Value<int> idEstacion;
  final Value<int> tiempoMs;
  final Value<String?> tiempoInicio;
  final Value<String?> tiempoFin;
  final Value<int> sincronizado;
  final Value<DateTime> createdAt;
  const HyroxTiemposCompanion({
    this.id = const Value.absent(),
    this.idEquipo = const Value.absent(),
    this.idEstacion = const Value.absent(),
    this.tiempoMs = const Value.absent(),
    this.tiempoInicio = const Value.absent(),
    this.tiempoFin = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HyroxTiemposCompanion.insert({
    this.id = const Value.absent(),
    required int idEquipo,
    required int idEstacion,
    required int tiempoMs,
    this.tiempoInicio = const Value.absent(),
    this.tiempoFin = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : idEquipo = Value(idEquipo),
       idEstacion = Value(idEstacion),
       tiempoMs = Value(tiempoMs);
  static Insertable<HyroxTiempo> custom({
    Expression<int>? id,
    Expression<int>? idEquipo,
    Expression<int>? idEstacion,
    Expression<int>? tiempoMs,
    Expression<String>? tiempoInicio,
    Expression<String>? tiempoFin,
    Expression<int>? sincronizado,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idEquipo != null) 'id_equipo': idEquipo,
      if (idEstacion != null) 'id_estacion': idEstacion,
      if (tiempoMs != null) 'tiempo_ms': tiempoMs,
      if (tiempoInicio != null) 'tiempo_inicio': tiempoInicio,
      if (tiempoFin != null) 'tiempo_fin': tiempoFin,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HyroxTiemposCompanion copyWith({
    Value<int>? id,
    Value<int>? idEquipo,
    Value<int>? idEstacion,
    Value<int>? tiempoMs,
    Value<String?>? tiempoInicio,
    Value<String?>? tiempoFin,
    Value<int>? sincronizado,
    Value<DateTime>? createdAt,
  }) {
    return HyroxTiemposCompanion(
      id: id ?? this.id,
      idEquipo: idEquipo ?? this.idEquipo,
      idEstacion: idEstacion ?? this.idEstacion,
      tiempoMs: tiempoMs ?? this.tiempoMs,
      tiempoInicio: tiempoInicio ?? this.tiempoInicio,
      tiempoFin: tiempoFin ?? this.tiempoFin,
      sincronizado: sincronizado ?? this.sincronizado,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idEquipo.present) {
      map['id_equipo'] = Variable<int>(idEquipo.value);
    }
    if (idEstacion.present) {
      map['id_estacion'] = Variable<int>(idEstacion.value);
    }
    if (tiempoMs.present) {
      map['tiempo_ms'] = Variable<int>(tiempoMs.value);
    }
    if (tiempoInicio.present) {
      map['tiempo_inicio'] = Variable<String>(tiempoInicio.value);
    }
    if (tiempoFin.present) {
      map['tiempo_fin'] = Variable<String>(tiempoFin.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<int>(sincronizado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HyroxTiemposCompanion(')
          ..write('id: $id, ')
          ..write('idEquipo: $idEquipo, ')
          ..write('idEstacion: $idEstacion, ')
          ..write('tiempoMs: $tiempoMs, ')
          ..write('tiempoInicio: $tiempoInicio, ')
          ..write('tiempoFin: $tiempoFin, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $HyroxRaceSessionsTable extends HyroxRaceSessions
    with TableInfo<$HyroxRaceSessionsTable, HyroxRaceSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HyroxRaceSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idEquipoMeta = const VerificationMeta(
    'idEquipo',
  );
  @override
  late final GeneratedColumn<int> idEquipo = GeneratedColumn<int>(
    'id_equipo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idHeatMeta = const VerificationMeta('idHeat');
  @override
  late final GeneratedColumn<int> idHeat = GeneratedColumn<int>(
    'id_heat',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreEquipoMeta = const VerificationMeta(
    'nombreEquipo',
  );
  @override
  late final GeneratedColumn<String> nombreEquipo = GeneratedColumn<String>(
    'nombre_equipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreHeatMeta = const VerificationMeta(
    'nombreHeat',
  );
  @override
  late final GeneratedColumn<String> nombreHeat = GeneratedColumn<String>(
    'nombre_heat',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<String> fecha = GeneratedColumn<String>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _finalizadaMeta = const VerificationMeta(
    'finalizada',
  );
  @override
  late final GeneratedColumn<int> finalizada = GeneratedColumn<int>(
    'finalizada',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    idEquipo,
    idHeat,
    nombreEquipo,
    nombreHeat,
    fecha,
    finalizada,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hyrox_race_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<HyroxRaceSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_equipo')) {
      context.handle(
        _idEquipoMeta,
        idEquipo.isAcceptableOrUnknown(data['id_equipo']!, _idEquipoMeta),
      );
    } else if (isInserting) {
      context.missing(_idEquipoMeta);
    }
    if (data.containsKey('id_heat')) {
      context.handle(
        _idHeatMeta,
        idHeat.isAcceptableOrUnknown(data['id_heat']!, _idHeatMeta),
      );
    } else if (isInserting) {
      context.missing(_idHeatMeta);
    }
    if (data.containsKey('nombre_equipo')) {
      context.handle(
        _nombreEquipoMeta,
        nombreEquipo.isAcceptableOrUnknown(
          data['nombre_equipo']!,
          _nombreEquipoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nombreEquipoMeta);
    }
    if (data.containsKey('nombre_heat')) {
      context.handle(
        _nombreHeatMeta,
        nombreHeat.isAcceptableOrUnknown(data['nombre_heat']!, _nombreHeatMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreHeatMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('finalizada')) {
      context.handle(
        _finalizadaMeta,
        finalizada.isAcceptableOrUnknown(data['finalizada']!, _finalizadaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HyroxRaceSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HyroxRaceSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      idEquipo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_equipo'],
      )!,
      idHeat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_heat'],
      )!,
      nombreEquipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre_equipo'],
      )!,
      nombreHeat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre_heat'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fecha'],
      )!,
      finalizada: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}finalizada'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HyroxRaceSessionsTable createAlias(String alias) {
    return $HyroxRaceSessionsTable(attachedDatabase, alias);
  }
}

class HyroxRaceSession extends DataClass
    implements Insertable<HyroxRaceSession> {
  final int id;
  final int idEquipo;
  final int idHeat;
  final String nombreEquipo;
  final String nombreHeat;
  final String fecha;
  final int finalizada;
  final DateTime createdAt;
  const HyroxRaceSession({
    required this.id,
    required this.idEquipo,
    required this.idHeat,
    required this.nombreEquipo,
    required this.nombreHeat,
    required this.fecha,
    required this.finalizada,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_equipo'] = Variable<int>(idEquipo);
    map['id_heat'] = Variable<int>(idHeat);
    map['nombre_equipo'] = Variable<String>(nombreEquipo);
    map['nombre_heat'] = Variable<String>(nombreHeat);
    map['fecha'] = Variable<String>(fecha);
    map['finalizada'] = Variable<int>(finalizada);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HyroxRaceSessionsCompanion toCompanion(bool nullToAbsent) {
    return HyroxRaceSessionsCompanion(
      id: Value(id),
      idEquipo: Value(idEquipo),
      idHeat: Value(idHeat),
      nombreEquipo: Value(nombreEquipo),
      nombreHeat: Value(nombreHeat),
      fecha: Value(fecha),
      finalizada: Value(finalizada),
      createdAt: Value(createdAt),
    );
  }

  factory HyroxRaceSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HyroxRaceSession(
      id: serializer.fromJson<int>(json['id']),
      idEquipo: serializer.fromJson<int>(json['idEquipo']),
      idHeat: serializer.fromJson<int>(json['idHeat']),
      nombreEquipo: serializer.fromJson<String>(json['nombreEquipo']),
      nombreHeat: serializer.fromJson<String>(json['nombreHeat']),
      fecha: serializer.fromJson<String>(json['fecha']),
      finalizada: serializer.fromJson<int>(json['finalizada']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idEquipo': serializer.toJson<int>(idEquipo),
      'idHeat': serializer.toJson<int>(idHeat),
      'nombreEquipo': serializer.toJson<String>(nombreEquipo),
      'nombreHeat': serializer.toJson<String>(nombreHeat),
      'fecha': serializer.toJson<String>(fecha),
      'finalizada': serializer.toJson<int>(finalizada),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HyroxRaceSession copyWith({
    int? id,
    int? idEquipo,
    int? idHeat,
    String? nombreEquipo,
    String? nombreHeat,
    String? fecha,
    int? finalizada,
    DateTime? createdAt,
  }) => HyroxRaceSession(
    id: id ?? this.id,
    idEquipo: idEquipo ?? this.idEquipo,
    idHeat: idHeat ?? this.idHeat,
    nombreEquipo: nombreEquipo ?? this.nombreEquipo,
    nombreHeat: nombreHeat ?? this.nombreHeat,
    fecha: fecha ?? this.fecha,
    finalizada: finalizada ?? this.finalizada,
    createdAt: createdAt ?? this.createdAt,
  );
  HyroxRaceSession copyWithCompanion(HyroxRaceSessionsCompanion data) {
    return HyroxRaceSession(
      id: data.id.present ? data.id.value : this.id,
      idEquipo: data.idEquipo.present ? data.idEquipo.value : this.idEquipo,
      idHeat: data.idHeat.present ? data.idHeat.value : this.idHeat,
      nombreEquipo: data.nombreEquipo.present
          ? data.nombreEquipo.value
          : this.nombreEquipo,
      nombreHeat: data.nombreHeat.present
          ? data.nombreHeat.value
          : this.nombreHeat,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      finalizada: data.finalizada.present
          ? data.finalizada.value
          : this.finalizada,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HyroxRaceSession(')
          ..write('id: $id, ')
          ..write('idEquipo: $idEquipo, ')
          ..write('idHeat: $idHeat, ')
          ..write('nombreEquipo: $nombreEquipo, ')
          ..write('nombreHeat: $nombreHeat, ')
          ..write('fecha: $fecha, ')
          ..write('finalizada: $finalizada, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    idEquipo,
    idHeat,
    nombreEquipo,
    nombreHeat,
    fecha,
    finalizada,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HyroxRaceSession &&
          other.id == this.id &&
          other.idEquipo == this.idEquipo &&
          other.idHeat == this.idHeat &&
          other.nombreEquipo == this.nombreEquipo &&
          other.nombreHeat == this.nombreHeat &&
          other.fecha == this.fecha &&
          other.finalizada == this.finalizada &&
          other.createdAt == this.createdAt);
}

class HyroxRaceSessionsCompanion extends UpdateCompanion<HyroxRaceSession> {
  final Value<int> id;
  final Value<int> idEquipo;
  final Value<int> idHeat;
  final Value<String> nombreEquipo;
  final Value<String> nombreHeat;
  final Value<String> fecha;
  final Value<int> finalizada;
  final Value<DateTime> createdAt;
  const HyroxRaceSessionsCompanion({
    this.id = const Value.absent(),
    this.idEquipo = const Value.absent(),
    this.idHeat = const Value.absent(),
    this.nombreEquipo = const Value.absent(),
    this.nombreHeat = const Value.absent(),
    this.fecha = const Value.absent(),
    this.finalizada = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HyroxRaceSessionsCompanion.insert({
    this.id = const Value.absent(),
    required int idEquipo,
    required int idHeat,
    required String nombreEquipo,
    required String nombreHeat,
    required String fecha,
    this.finalizada = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : idEquipo = Value(idEquipo),
       idHeat = Value(idHeat),
       nombreEquipo = Value(nombreEquipo),
       nombreHeat = Value(nombreHeat),
       fecha = Value(fecha);
  static Insertable<HyroxRaceSession> custom({
    Expression<int>? id,
    Expression<int>? idEquipo,
    Expression<int>? idHeat,
    Expression<String>? nombreEquipo,
    Expression<String>? nombreHeat,
    Expression<String>? fecha,
    Expression<int>? finalizada,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idEquipo != null) 'id_equipo': idEquipo,
      if (idHeat != null) 'id_heat': idHeat,
      if (nombreEquipo != null) 'nombre_equipo': nombreEquipo,
      if (nombreHeat != null) 'nombre_heat': nombreHeat,
      if (fecha != null) 'fecha': fecha,
      if (finalizada != null) 'finalizada': finalizada,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HyroxRaceSessionsCompanion copyWith({
    Value<int>? id,
    Value<int>? idEquipo,
    Value<int>? idHeat,
    Value<String>? nombreEquipo,
    Value<String>? nombreHeat,
    Value<String>? fecha,
    Value<int>? finalizada,
    Value<DateTime>? createdAt,
  }) {
    return HyroxRaceSessionsCompanion(
      id: id ?? this.id,
      idEquipo: idEquipo ?? this.idEquipo,
      idHeat: idHeat ?? this.idHeat,
      nombreEquipo: nombreEquipo ?? this.nombreEquipo,
      nombreHeat: nombreHeat ?? this.nombreHeat,
      fecha: fecha ?? this.fecha,
      finalizada: finalizada ?? this.finalizada,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idEquipo.present) {
      map['id_equipo'] = Variable<int>(idEquipo.value);
    }
    if (idHeat.present) {
      map['id_heat'] = Variable<int>(idHeat.value);
    }
    if (nombreEquipo.present) {
      map['nombre_equipo'] = Variable<String>(nombreEquipo.value);
    }
    if (nombreHeat.present) {
      map['nombre_heat'] = Variable<String>(nombreHeat.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<String>(fecha.value);
    }
    if (finalizada.present) {
      map['finalizada'] = Variable<int>(finalizada.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HyroxRaceSessionsCompanion(')
          ..write('id: $id, ')
          ..write('idEquipo: $idEquipo, ')
          ..write('idHeat: $idHeat, ')
          ..write('nombreEquipo: $nombreEquipo, ')
          ..write('nombreHeat: $nombreHeat, ')
          ..write('fecha: $fecha, ')
          ..write('finalizada: $finalizada, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $HyroxModulesTable extends HyroxModules
    with TableInfo<$HyroxModulesTable, HyroxModule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HyroxModulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, key, nombre, descripcion];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hyrox_modules';
  @override
  VerificationContext validateIntegrity(
    Insertable<HyroxModule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HyroxModule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HyroxModule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
    );
  }

  @override
  $HyroxModulesTable createAlias(String alias) {
    return $HyroxModulesTable(attachedDatabase, alias);
  }
}

class HyroxModule extends DataClass implements Insertable<HyroxModule> {
  final int id;
  final String key;
  final String nombre;
  final String? descripcion;
  const HyroxModule({
    required this.id,
    required this.key,
    required this.nombre,
    this.descripcion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    return map;
  }

  HyroxModulesCompanion toCompanion(bool nullToAbsent) {
    return HyroxModulesCompanion(
      id: Value(id),
      key: Value(key),
      nombre: Value(nombre),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
    );
  }

  factory HyroxModule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HyroxModule(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String?>(descripcion),
    };
  }

  HyroxModule copyWith({
    int? id,
    String? key,
    String? nombre,
    Value<String?> descripcion = const Value.absent(),
  }) => HyroxModule(
    id: id ?? this.id,
    key: key ?? this.key,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
  );
  HyroxModule copyWithCompanion(HyroxModulesCompanion data) {
    return HyroxModule(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HyroxModule(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, key, nombre, descripcion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HyroxModule &&
          other.id == this.id &&
          other.key == this.key &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion);
}

class HyroxModulesCompanion extends UpdateCompanion<HyroxModule> {
  final Value<int> id;
  final Value<String> key;
  final Value<String> nombre;
  final Value<String?> descripcion;
  const HyroxModulesCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
  });
  HyroxModulesCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required String nombre,
    this.descripcion = const Value.absent(),
  }) : key = Value(key),
       nombre = Value(nombre);
  static Insertable<HyroxModule> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<String>? nombre,
    Expression<String>? descripcion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
    });
  }

  HyroxModulesCompanion copyWith({
    Value<int>? id,
    Value<String>? key,
    Value<String>? nombre,
    Value<String?>? descripcion,
  }) {
    return HyroxModulesCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HyroxModulesCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion')
          ..write(')'))
        .toString();
  }
}

class $HyroxPenaltyTypesTable extends HyroxPenaltyTypes
    with TableInfo<$HyroxPenaltyTypesTable, HyroxPenaltyType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HyroxPenaltyTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _moduleIdMeta = const VerificationMeta(
    'moduleId',
  );
  @override
  late final GeneratedColumn<int> moduleId = GeneratedColumn<int>(
    'module_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _penaltySecondsMeta = const VerificationMeta(
    'penaltySeconds',
  );
  @override
  late final GeneratedColumn<int> penaltySeconds = GeneratedColumn<int>(
    'penalty_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    moduleId,
    label,
    description,
    penaltySeconds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hyrox_penalty_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<HyroxPenaltyType> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('module_id')) {
      context.handle(
        _moduleIdMeta,
        moduleId.isAcceptableOrUnknown(data['module_id']!, _moduleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_moduleIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('penalty_seconds')) {
      context.handle(
        _penaltySecondsMeta,
        penaltySeconds.isAcceptableOrUnknown(
          data['penalty_seconds']!,
          _penaltySecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_penaltySecondsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HyroxPenaltyType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HyroxPenaltyType(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      moduleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}module_id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      penaltySeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}penalty_seconds'],
      )!,
    );
  }

  @override
  $HyroxPenaltyTypesTable createAlias(String alias) {
    return $HyroxPenaltyTypesTable(attachedDatabase, alias);
  }
}

class HyroxPenaltyType extends DataClass
    implements Insertable<HyroxPenaltyType> {
  final int id;
  final int moduleId;
  final String label;
  final String? description;
  final int penaltySeconds;
  const HyroxPenaltyType({
    required this.id,
    required this.moduleId,
    required this.label,
    this.description,
    required this.penaltySeconds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['module_id'] = Variable<int>(moduleId);
    map['label'] = Variable<String>(label);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['penalty_seconds'] = Variable<int>(penaltySeconds);
    return map;
  }

  HyroxPenaltyTypesCompanion toCompanion(bool nullToAbsent) {
    return HyroxPenaltyTypesCompanion(
      id: Value(id),
      moduleId: Value(moduleId),
      label: Value(label),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      penaltySeconds: Value(penaltySeconds),
    );
  }

  factory HyroxPenaltyType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HyroxPenaltyType(
      id: serializer.fromJson<int>(json['id']),
      moduleId: serializer.fromJson<int>(json['moduleId']),
      label: serializer.fromJson<String>(json['label']),
      description: serializer.fromJson<String?>(json['description']),
      penaltySeconds: serializer.fromJson<int>(json['penaltySeconds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'moduleId': serializer.toJson<int>(moduleId),
      'label': serializer.toJson<String>(label),
      'description': serializer.toJson<String?>(description),
      'penaltySeconds': serializer.toJson<int>(penaltySeconds),
    };
  }

  HyroxPenaltyType copyWith({
    int? id,
    int? moduleId,
    String? label,
    Value<String?> description = const Value.absent(),
    int? penaltySeconds,
  }) => HyroxPenaltyType(
    id: id ?? this.id,
    moduleId: moduleId ?? this.moduleId,
    label: label ?? this.label,
    description: description.present ? description.value : this.description,
    penaltySeconds: penaltySeconds ?? this.penaltySeconds,
  );
  HyroxPenaltyType copyWithCompanion(HyroxPenaltyTypesCompanion data) {
    return HyroxPenaltyType(
      id: data.id.present ? data.id.value : this.id,
      moduleId: data.moduleId.present ? data.moduleId.value : this.moduleId,
      label: data.label.present ? data.label.value : this.label,
      description: data.description.present
          ? data.description.value
          : this.description,
      penaltySeconds: data.penaltySeconds.present
          ? data.penaltySeconds.value
          : this.penaltySeconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HyroxPenaltyType(')
          ..write('id: $id, ')
          ..write('moduleId: $moduleId, ')
          ..write('label: $label, ')
          ..write('description: $description, ')
          ..write('penaltySeconds: $penaltySeconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, moduleId, label, description, penaltySeconds);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HyroxPenaltyType &&
          other.id == this.id &&
          other.moduleId == this.moduleId &&
          other.label == this.label &&
          other.description == this.description &&
          other.penaltySeconds == this.penaltySeconds);
}

class HyroxPenaltyTypesCompanion extends UpdateCompanion<HyroxPenaltyType> {
  final Value<int> id;
  final Value<int> moduleId;
  final Value<String> label;
  final Value<String?> description;
  final Value<int> penaltySeconds;
  const HyroxPenaltyTypesCompanion({
    this.id = const Value.absent(),
    this.moduleId = const Value.absent(),
    this.label = const Value.absent(),
    this.description = const Value.absent(),
    this.penaltySeconds = const Value.absent(),
  });
  HyroxPenaltyTypesCompanion.insert({
    this.id = const Value.absent(),
    required int moduleId,
    required String label,
    this.description = const Value.absent(),
    required int penaltySeconds,
  }) : moduleId = Value(moduleId),
       label = Value(label),
       penaltySeconds = Value(penaltySeconds);
  static Insertable<HyroxPenaltyType> custom({
    Expression<int>? id,
    Expression<int>? moduleId,
    Expression<String>? label,
    Expression<String>? description,
    Expression<int>? penaltySeconds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (moduleId != null) 'module_id': moduleId,
      if (label != null) 'label': label,
      if (description != null) 'description': description,
      if (penaltySeconds != null) 'penalty_seconds': penaltySeconds,
    });
  }

  HyroxPenaltyTypesCompanion copyWith({
    Value<int>? id,
    Value<int>? moduleId,
    Value<String>? label,
    Value<String?>? description,
    Value<int>? penaltySeconds,
  }) {
    return HyroxPenaltyTypesCompanion(
      id: id ?? this.id,
      moduleId: moduleId ?? this.moduleId,
      label: label ?? this.label,
      description: description ?? this.description,
      penaltySeconds: penaltySeconds ?? this.penaltySeconds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (moduleId.present) {
      map['module_id'] = Variable<int>(moduleId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (penaltySeconds.present) {
      map['penalty_seconds'] = Variable<int>(penaltySeconds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HyroxPenaltyTypesCompanion(')
          ..write('id: $id, ')
          ..write('moduleId: $moduleId, ')
          ..write('label: $label, ')
          ..write('description: $description, ')
          ..write('penaltySeconds: $penaltySeconds')
          ..write(')'))
        .toString();
  }
}

class $HyroxPenaltyLogTable extends HyroxPenaltyLog
    with TableInfo<$HyroxPenaltyLogTable, HyroxPenaltyLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HyroxPenaltyLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idEquipoMeta = const VerificationMeta(
    'idEquipo',
  );
  @override
  late final GeneratedColumn<int> idEquipo = GeneratedColumn<int>(
    'id_equipo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idEstacionMeta = const VerificationMeta(
    'idEstacion',
  );
  @override
  late final GeneratedColumn<int> idEstacion = GeneratedColumn<int>(
    'id_estacion',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moduleIdMeta = const VerificationMeta(
    'moduleId',
  );
  @override
  late final GeneratedColumn<int> moduleId = GeneratedColumn<int>(
    'module_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _penaltyTypeIdMeta = const VerificationMeta(
    'penaltyTypeId',
  );
  @override
  late final GeneratedColumn<int> penaltyTypeId = GeneratedColumn<int>(
    'penalty_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _penaltySecondsMeta = const VerificationMeta(
    'penaltySeconds',
  );
  @override
  late final GeneratedColumn<int> penaltySeconds = GeneratedColumn<int>(
    'penalty_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timerMsAtPenaltyMeta = const VerificationMeta(
    'timerMsAtPenalty',
  );
  @override
  late final GeneratedColumn<int> timerMsAtPenalty = GeneratedColumn<int>(
    'timer_ms_at_penalty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appliedAtMeta = const VerificationMeta(
    'appliedAt',
  );
  @override
  late final GeneratedColumn<DateTime> appliedAt = GeneratedColumn<DateTime>(
    'applied_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _sincronizadoMeta = const VerificationMeta(
    'sincronizado',
  );
  @override
  late final GeneratedColumn<int> sincronizado = GeneratedColumn<int>(
    'sincronizado',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    idEquipo,
    idEstacion,
    moduleId,
    penaltyTypeId,
    penaltySeconds,
    timerMsAtPenalty,
    appliedAt,
    sincronizado,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hyrox_penalty_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<HyroxPenaltyLogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('id_equipo')) {
      context.handle(
        _idEquipoMeta,
        idEquipo.isAcceptableOrUnknown(data['id_equipo']!, _idEquipoMeta),
      );
    } else if (isInserting) {
      context.missing(_idEquipoMeta);
    }
    if (data.containsKey('id_estacion')) {
      context.handle(
        _idEstacionMeta,
        idEstacion.isAcceptableOrUnknown(data['id_estacion']!, _idEstacionMeta),
      );
    } else if (isInserting) {
      context.missing(_idEstacionMeta);
    }
    if (data.containsKey('module_id')) {
      context.handle(
        _moduleIdMeta,
        moduleId.isAcceptableOrUnknown(data['module_id']!, _moduleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_moduleIdMeta);
    }
    if (data.containsKey('penalty_type_id')) {
      context.handle(
        _penaltyTypeIdMeta,
        penaltyTypeId.isAcceptableOrUnknown(
          data['penalty_type_id']!,
          _penaltyTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_penaltyTypeIdMeta);
    }
    if (data.containsKey('penalty_seconds')) {
      context.handle(
        _penaltySecondsMeta,
        penaltySeconds.isAcceptableOrUnknown(
          data['penalty_seconds']!,
          _penaltySecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_penaltySecondsMeta);
    }
    if (data.containsKey('timer_ms_at_penalty')) {
      context.handle(
        _timerMsAtPenaltyMeta,
        timerMsAtPenalty.isAcceptableOrUnknown(
          data['timer_ms_at_penalty']!,
          _timerMsAtPenaltyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timerMsAtPenaltyMeta);
    }
    if (data.containsKey('applied_at')) {
      context.handle(
        _appliedAtMeta,
        appliedAt.isAcceptableOrUnknown(data['applied_at']!, _appliedAtMeta),
      );
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
        _sincronizadoMeta,
        sincronizado.isAcceptableOrUnknown(
          data['sincronizado']!,
          _sincronizadoMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HyroxPenaltyLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HyroxPenaltyLogData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      )!,
      idEquipo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_equipo'],
      )!,
      idEstacion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_estacion'],
      )!,
      moduleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}module_id'],
      )!,
      penaltyTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}penalty_type_id'],
      )!,
      penaltySeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}penalty_seconds'],
      )!,
      timerMsAtPenalty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timer_ms_at_penalty'],
      )!,
      appliedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}applied_at'],
      )!,
      sincronizado: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sincronizado'],
      )!,
    );
  }

  @override
  $HyroxPenaltyLogTable createAlias(String alias) {
    return $HyroxPenaltyLogTable(attachedDatabase, alias);
  }
}

class HyroxPenaltyLogData extends DataClass
    implements Insertable<HyroxPenaltyLogData> {
  final int id;
  final int sessionId;
  final int idEquipo;
  final int idEstacion;
  final int moduleId;
  final int penaltyTypeId;
  final int penaltySeconds;
  final int timerMsAtPenalty;
  final DateTime appliedAt;
  final int sincronizado;
  const HyroxPenaltyLogData({
    required this.id,
    required this.sessionId,
    required this.idEquipo,
    required this.idEstacion,
    required this.moduleId,
    required this.penaltyTypeId,
    required this.penaltySeconds,
    required this.timerMsAtPenalty,
    required this.appliedAt,
    required this.sincronizado,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['id_equipo'] = Variable<int>(idEquipo);
    map['id_estacion'] = Variable<int>(idEstacion);
    map['module_id'] = Variable<int>(moduleId);
    map['penalty_type_id'] = Variable<int>(penaltyTypeId);
    map['penalty_seconds'] = Variable<int>(penaltySeconds);
    map['timer_ms_at_penalty'] = Variable<int>(timerMsAtPenalty);
    map['applied_at'] = Variable<DateTime>(appliedAt);
    map['sincronizado'] = Variable<int>(sincronizado);
    return map;
  }

  HyroxPenaltyLogCompanion toCompanion(bool nullToAbsent) {
    return HyroxPenaltyLogCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      idEquipo: Value(idEquipo),
      idEstacion: Value(idEstacion),
      moduleId: Value(moduleId),
      penaltyTypeId: Value(penaltyTypeId),
      penaltySeconds: Value(penaltySeconds),
      timerMsAtPenalty: Value(timerMsAtPenalty),
      appliedAt: Value(appliedAt),
      sincronizado: Value(sincronizado),
    );
  }

  factory HyroxPenaltyLogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HyroxPenaltyLogData(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      idEquipo: serializer.fromJson<int>(json['idEquipo']),
      idEstacion: serializer.fromJson<int>(json['idEstacion']),
      moduleId: serializer.fromJson<int>(json['moduleId']),
      penaltyTypeId: serializer.fromJson<int>(json['penaltyTypeId']),
      penaltySeconds: serializer.fromJson<int>(json['penaltySeconds']),
      timerMsAtPenalty: serializer.fromJson<int>(json['timerMsAtPenalty']),
      appliedAt: serializer.fromJson<DateTime>(json['appliedAt']),
      sincronizado: serializer.fromJson<int>(json['sincronizado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'idEquipo': serializer.toJson<int>(idEquipo),
      'idEstacion': serializer.toJson<int>(idEstacion),
      'moduleId': serializer.toJson<int>(moduleId),
      'penaltyTypeId': serializer.toJson<int>(penaltyTypeId),
      'penaltySeconds': serializer.toJson<int>(penaltySeconds),
      'timerMsAtPenalty': serializer.toJson<int>(timerMsAtPenalty),
      'appliedAt': serializer.toJson<DateTime>(appliedAt),
      'sincronizado': serializer.toJson<int>(sincronizado),
    };
  }

  HyroxPenaltyLogData copyWith({
    int? id,
    int? sessionId,
    int? idEquipo,
    int? idEstacion,
    int? moduleId,
    int? penaltyTypeId,
    int? penaltySeconds,
    int? timerMsAtPenalty,
    DateTime? appliedAt,
    int? sincronizado,
  }) => HyroxPenaltyLogData(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    idEquipo: idEquipo ?? this.idEquipo,
    idEstacion: idEstacion ?? this.idEstacion,
    moduleId: moduleId ?? this.moduleId,
    penaltyTypeId: penaltyTypeId ?? this.penaltyTypeId,
    penaltySeconds: penaltySeconds ?? this.penaltySeconds,
    timerMsAtPenalty: timerMsAtPenalty ?? this.timerMsAtPenalty,
    appliedAt: appliedAt ?? this.appliedAt,
    sincronizado: sincronizado ?? this.sincronizado,
  );
  HyroxPenaltyLogData copyWithCompanion(HyroxPenaltyLogCompanion data) {
    return HyroxPenaltyLogData(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      idEquipo: data.idEquipo.present ? data.idEquipo.value : this.idEquipo,
      idEstacion: data.idEstacion.present
          ? data.idEstacion.value
          : this.idEstacion,
      moduleId: data.moduleId.present ? data.moduleId.value : this.moduleId,
      penaltyTypeId: data.penaltyTypeId.present
          ? data.penaltyTypeId.value
          : this.penaltyTypeId,
      penaltySeconds: data.penaltySeconds.present
          ? data.penaltySeconds.value
          : this.penaltySeconds,
      timerMsAtPenalty: data.timerMsAtPenalty.present
          ? data.timerMsAtPenalty.value
          : this.timerMsAtPenalty,
      appliedAt: data.appliedAt.present ? data.appliedAt.value : this.appliedAt,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HyroxPenaltyLogData(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('idEquipo: $idEquipo, ')
          ..write('idEstacion: $idEstacion, ')
          ..write('moduleId: $moduleId, ')
          ..write('penaltyTypeId: $penaltyTypeId, ')
          ..write('penaltySeconds: $penaltySeconds, ')
          ..write('timerMsAtPenalty: $timerMsAtPenalty, ')
          ..write('appliedAt: $appliedAt, ')
          ..write('sincronizado: $sincronizado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    idEquipo,
    idEstacion,
    moduleId,
    penaltyTypeId,
    penaltySeconds,
    timerMsAtPenalty,
    appliedAt,
    sincronizado,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HyroxPenaltyLogData &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.idEquipo == this.idEquipo &&
          other.idEstacion == this.idEstacion &&
          other.moduleId == this.moduleId &&
          other.penaltyTypeId == this.penaltyTypeId &&
          other.penaltySeconds == this.penaltySeconds &&
          other.timerMsAtPenalty == this.timerMsAtPenalty &&
          other.appliedAt == this.appliedAt &&
          other.sincronizado == this.sincronizado);
}

class HyroxPenaltyLogCompanion extends UpdateCompanion<HyroxPenaltyLogData> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<int> idEquipo;
  final Value<int> idEstacion;
  final Value<int> moduleId;
  final Value<int> penaltyTypeId;
  final Value<int> penaltySeconds;
  final Value<int> timerMsAtPenalty;
  final Value<DateTime> appliedAt;
  final Value<int> sincronizado;
  const HyroxPenaltyLogCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.idEquipo = const Value.absent(),
    this.idEstacion = const Value.absent(),
    this.moduleId = const Value.absent(),
    this.penaltyTypeId = const Value.absent(),
    this.penaltySeconds = const Value.absent(),
    this.timerMsAtPenalty = const Value.absent(),
    this.appliedAt = const Value.absent(),
    this.sincronizado = const Value.absent(),
  });
  HyroxPenaltyLogCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required int idEquipo,
    required int idEstacion,
    required int moduleId,
    required int penaltyTypeId,
    required int penaltySeconds,
    required int timerMsAtPenalty,
    this.appliedAt = const Value.absent(),
    this.sincronizado = const Value.absent(),
  }) : sessionId = Value(sessionId),
       idEquipo = Value(idEquipo),
       idEstacion = Value(idEstacion),
       moduleId = Value(moduleId),
       penaltyTypeId = Value(penaltyTypeId),
       penaltySeconds = Value(penaltySeconds),
       timerMsAtPenalty = Value(timerMsAtPenalty);
  static Insertable<HyroxPenaltyLogData> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<int>? idEquipo,
    Expression<int>? idEstacion,
    Expression<int>? moduleId,
    Expression<int>? penaltyTypeId,
    Expression<int>? penaltySeconds,
    Expression<int>? timerMsAtPenalty,
    Expression<DateTime>? appliedAt,
    Expression<int>? sincronizado,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (idEquipo != null) 'id_equipo': idEquipo,
      if (idEstacion != null) 'id_estacion': idEstacion,
      if (moduleId != null) 'module_id': moduleId,
      if (penaltyTypeId != null) 'penalty_type_id': penaltyTypeId,
      if (penaltySeconds != null) 'penalty_seconds': penaltySeconds,
      if (timerMsAtPenalty != null) 'timer_ms_at_penalty': timerMsAtPenalty,
      if (appliedAt != null) 'applied_at': appliedAt,
      if (sincronizado != null) 'sincronizado': sincronizado,
    });
  }

  HyroxPenaltyLogCompanion copyWith({
    Value<int>? id,
    Value<int>? sessionId,
    Value<int>? idEquipo,
    Value<int>? idEstacion,
    Value<int>? moduleId,
    Value<int>? penaltyTypeId,
    Value<int>? penaltySeconds,
    Value<int>? timerMsAtPenalty,
    Value<DateTime>? appliedAt,
    Value<int>? sincronizado,
  }) {
    return HyroxPenaltyLogCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      idEquipo: idEquipo ?? this.idEquipo,
      idEstacion: idEstacion ?? this.idEstacion,
      moduleId: moduleId ?? this.moduleId,
      penaltyTypeId: penaltyTypeId ?? this.penaltyTypeId,
      penaltySeconds: penaltySeconds ?? this.penaltySeconds,
      timerMsAtPenalty: timerMsAtPenalty ?? this.timerMsAtPenalty,
      appliedAt: appliedAt ?? this.appliedAt,
      sincronizado: sincronizado ?? this.sincronizado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (idEquipo.present) {
      map['id_equipo'] = Variable<int>(idEquipo.value);
    }
    if (idEstacion.present) {
      map['id_estacion'] = Variable<int>(idEstacion.value);
    }
    if (moduleId.present) {
      map['module_id'] = Variable<int>(moduleId.value);
    }
    if (penaltyTypeId.present) {
      map['penalty_type_id'] = Variable<int>(penaltyTypeId.value);
    }
    if (penaltySeconds.present) {
      map['penalty_seconds'] = Variable<int>(penaltySeconds.value);
    }
    if (timerMsAtPenalty.present) {
      map['timer_ms_at_penalty'] = Variable<int>(timerMsAtPenalty.value);
    }
    if (appliedAt.present) {
      map['applied_at'] = Variable<DateTime>(appliedAt.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<int>(sincronizado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HyroxPenaltyLogCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('idEquipo: $idEquipo, ')
          ..write('idEstacion: $idEstacion, ')
          ..write('moduleId: $moduleId, ')
          ..write('penaltyTypeId: $penaltyTypeId, ')
          ..write('penaltySeconds: $penaltySeconds, ')
          ..write('timerMsAtPenalty: $timerMsAtPenalty, ')
          ..write('appliedAt: $appliedAt, ')
          ..write('sincronizado: $sincronizado')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HyroxTiemposTable hyroxTiempos = $HyroxTiemposTable(this);
  late final $HyroxRaceSessionsTable hyroxRaceSessions =
      $HyroxRaceSessionsTable(this);
  late final $HyroxModulesTable hyroxModules = $HyroxModulesTable(this);
  late final $HyroxPenaltyTypesTable hyroxPenaltyTypes =
      $HyroxPenaltyTypesTable(this);
  late final $HyroxPenaltyLogTable hyroxPenaltyLog = $HyroxPenaltyLogTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    hyroxTiempos,
    hyroxRaceSessions,
    hyroxModules,
    hyroxPenaltyTypes,
    hyroxPenaltyLog,
  ];
}

typedef $$HyroxTiemposTableCreateCompanionBuilder =
    HyroxTiemposCompanion Function({
      Value<int> id,
      required int idEquipo,
      required int idEstacion,
      required int tiempoMs,
      Value<String?> tiempoInicio,
      Value<String?> tiempoFin,
      Value<int> sincronizado,
      Value<DateTime> createdAt,
    });
typedef $$HyroxTiemposTableUpdateCompanionBuilder =
    HyroxTiemposCompanion Function({
      Value<int> id,
      Value<int> idEquipo,
      Value<int> idEstacion,
      Value<int> tiempoMs,
      Value<String?> tiempoInicio,
      Value<String?> tiempoFin,
      Value<int> sincronizado,
      Value<DateTime> createdAt,
    });

class $$HyroxTiemposTableFilterComposer
    extends Composer<_$AppDatabase, $HyroxTiemposTable> {
  $$HyroxTiemposTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idEquipo => $composableBuilder(
    column: $table.idEquipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idEstacion => $composableBuilder(
    column: $table.idEstacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tiempoMs => $composableBuilder(
    column: $table.tiempoMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tiempoInicio => $composableBuilder(
    column: $table.tiempoInicio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tiempoFin => $composableBuilder(
    column: $table.tiempoFin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sincronizado => $composableBuilder(
    column: $table.sincronizado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HyroxTiemposTableOrderingComposer
    extends Composer<_$AppDatabase, $HyroxTiemposTable> {
  $$HyroxTiemposTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idEquipo => $composableBuilder(
    column: $table.idEquipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idEstacion => $composableBuilder(
    column: $table.idEstacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tiempoMs => $composableBuilder(
    column: $table.tiempoMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tiempoInicio => $composableBuilder(
    column: $table.tiempoInicio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tiempoFin => $composableBuilder(
    column: $table.tiempoFin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sincronizado => $composableBuilder(
    column: $table.sincronizado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HyroxTiemposTableAnnotationComposer
    extends Composer<_$AppDatabase, $HyroxTiemposTable> {
  $$HyroxTiemposTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get idEquipo =>
      $composableBuilder(column: $table.idEquipo, builder: (column) => column);

  GeneratedColumn<int> get idEstacion => $composableBuilder(
    column: $table.idEstacion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tiempoMs =>
      $composableBuilder(column: $table.tiempoMs, builder: (column) => column);

  GeneratedColumn<String> get tiempoInicio => $composableBuilder(
    column: $table.tiempoInicio,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tiempoFin =>
      $composableBuilder(column: $table.tiempoFin, builder: (column) => column);

  GeneratedColumn<int> get sincronizado => $composableBuilder(
    column: $table.sincronizado,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HyroxTiemposTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HyroxTiemposTable,
          HyroxTiempo,
          $$HyroxTiemposTableFilterComposer,
          $$HyroxTiemposTableOrderingComposer,
          $$HyroxTiemposTableAnnotationComposer,
          $$HyroxTiemposTableCreateCompanionBuilder,
          $$HyroxTiemposTableUpdateCompanionBuilder,
          (
            HyroxTiempo,
            BaseReferences<_$AppDatabase, $HyroxTiemposTable, HyroxTiempo>,
          ),
          HyroxTiempo,
          PrefetchHooks Function()
        > {
  $$HyroxTiemposTableTableManager(_$AppDatabase db, $HyroxTiemposTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HyroxTiemposTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HyroxTiemposTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HyroxTiemposTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> idEquipo = const Value.absent(),
                Value<int> idEstacion = const Value.absent(),
                Value<int> tiempoMs = const Value.absent(),
                Value<String?> tiempoInicio = const Value.absent(),
                Value<String?> tiempoFin = const Value.absent(),
                Value<int> sincronizado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HyroxTiemposCompanion(
                id: id,
                idEquipo: idEquipo,
                idEstacion: idEstacion,
                tiempoMs: tiempoMs,
                tiempoInicio: tiempoInicio,
                tiempoFin: tiempoFin,
                sincronizado: sincronizado,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int idEquipo,
                required int idEstacion,
                required int tiempoMs,
                Value<String?> tiempoInicio = const Value.absent(),
                Value<String?> tiempoFin = const Value.absent(),
                Value<int> sincronizado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HyroxTiemposCompanion.insert(
                id: id,
                idEquipo: idEquipo,
                idEstacion: idEstacion,
                tiempoMs: tiempoMs,
                tiempoInicio: tiempoInicio,
                tiempoFin: tiempoFin,
                sincronizado: sincronizado,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HyroxTiemposTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HyroxTiemposTable,
      HyroxTiempo,
      $$HyroxTiemposTableFilterComposer,
      $$HyroxTiemposTableOrderingComposer,
      $$HyroxTiemposTableAnnotationComposer,
      $$HyroxTiemposTableCreateCompanionBuilder,
      $$HyroxTiemposTableUpdateCompanionBuilder,
      (
        HyroxTiempo,
        BaseReferences<_$AppDatabase, $HyroxTiemposTable, HyroxTiempo>,
      ),
      HyroxTiempo,
      PrefetchHooks Function()
    >;
typedef $$HyroxRaceSessionsTableCreateCompanionBuilder =
    HyroxRaceSessionsCompanion Function({
      Value<int> id,
      required int idEquipo,
      required int idHeat,
      required String nombreEquipo,
      required String nombreHeat,
      required String fecha,
      Value<int> finalizada,
      Value<DateTime> createdAt,
    });
typedef $$HyroxRaceSessionsTableUpdateCompanionBuilder =
    HyroxRaceSessionsCompanion Function({
      Value<int> id,
      Value<int> idEquipo,
      Value<int> idHeat,
      Value<String> nombreEquipo,
      Value<String> nombreHeat,
      Value<String> fecha,
      Value<int> finalizada,
      Value<DateTime> createdAt,
    });

class $$HyroxRaceSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $HyroxRaceSessionsTable> {
  $$HyroxRaceSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idEquipo => $composableBuilder(
    column: $table.idEquipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idHeat => $composableBuilder(
    column: $table.idHeat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombreEquipo => $composableBuilder(
    column: $table.nombreEquipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombreHeat => $composableBuilder(
    column: $table.nombreHeat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get finalizada => $composableBuilder(
    column: $table.finalizada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HyroxRaceSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $HyroxRaceSessionsTable> {
  $$HyroxRaceSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idEquipo => $composableBuilder(
    column: $table.idEquipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idHeat => $composableBuilder(
    column: $table.idHeat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombreEquipo => $composableBuilder(
    column: $table.nombreEquipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombreHeat => $composableBuilder(
    column: $table.nombreHeat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get finalizada => $composableBuilder(
    column: $table.finalizada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HyroxRaceSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HyroxRaceSessionsTable> {
  $$HyroxRaceSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get idEquipo =>
      $composableBuilder(column: $table.idEquipo, builder: (column) => column);

  GeneratedColumn<int> get idHeat =>
      $composableBuilder(column: $table.idHeat, builder: (column) => column);

  GeneratedColumn<String> get nombreEquipo => $composableBuilder(
    column: $table.nombreEquipo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nombreHeat => $composableBuilder(
    column: $table.nombreHeat,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<int> get finalizada => $composableBuilder(
    column: $table.finalizada,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HyroxRaceSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HyroxRaceSessionsTable,
          HyroxRaceSession,
          $$HyroxRaceSessionsTableFilterComposer,
          $$HyroxRaceSessionsTableOrderingComposer,
          $$HyroxRaceSessionsTableAnnotationComposer,
          $$HyroxRaceSessionsTableCreateCompanionBuilder,
          $$HyroxRaceSessionsTableUpdateCompanionBuilder,
          (
            HyroxRaceSession,
            BaseReferences<
              _$AppDatabase,
              $HyroxRaceSessionsTable,
              HyroxRaceSession
            >,
          ),
          HyroxRaceSession,
          PrefetchHooks Function()
        > {
  $$HyroxRaceSessionsTableTableManager(
    _$AppDatabase db,
    $HyroxRaceSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HyroxRaceSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HyroxRaceSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HyroxRaceSessionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> idEquipo = const Value.absent(),
                Value<int> idHeat = const Value.absent(),
                Value<String> nombreEquipo = const Value.absent(),
                Value<String> nombreHeat = const Value.absent(),
                Value<String> fecha = const Value.absent(),
                Value<int> finalizada = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HyroxRaceSessionsCompanion(
                id: id,
                idEquipo: idEquipo,
                idHeat: idHeat,
                nombreEquipo: nombreEquipo,
                nombreHeat: nombreHeat,
                fecha: fecha,
                finalizada: finalizada,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int idEquipo,
                required int idHeat,
                required String nombreEquipo,
                required String nombreHeat,
                required String fecha,
                Value<int> finalizada = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HyroxRaceSessionsCompanion.insert(
                id: id,
                idEquipo: idEquipo,
                idHeat: idHeat,
                nombreEquipo: nombreEquipo,
                nombreHeat: nombreHeat,
                fecha: fecha,
                finalizada: finalizada,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HyroxRaceSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HyroxRaceSessionsTable,
      HyroxRaceSession,
      $$HyroxRaceSessionsTableFilterComposer,
      $$HyroxRaceSessionsTableOrderingComposer,
      $$HyroxRaceSessionsTableAnnotationComposer,
      $$HyroxRaceSessionsTableCreateCompanionBuilder,
      $$HyroxRaceSessionsTableUpdateCompanionBuilder,
      (
        HyroxRaceSession,
        BaseReferences<
          _$AppDatabase,
          $HyroxRaceSessionsTable,
          HyroxRaceSession
        >,
      ),
      HyroxRaceSession,
      PrefetchHooks Function()
    >;
typedef $$HyroxModulesTableCreateCompanionBuilder =
    HyroxModulesCompanion Function({
      Value<int> id,
      required String key,
      required String nombre,
      Value<String?> descripcion,
    });
typedef $$HyroxModulesTableUpdateCompanionBuilder =
    HyroxModulesCompanion Function({
      Value<int> id,
      Value<String> key,
      Value<String> nombre,
      Value<String?> descripcion,
    });

class $$HyroxModulesTableFilterComposer
    extends Composer<_$AppDatabase, $HyroxModulesTable> {
  $$HyroxModulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HyroxModulesTableOrderingComposer
    extends Composer<_$AppDatabase, $HyroxModulesTable> {
  $$HyroxModulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HyroxModulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HyroxModulesTable> {
  $$HyroxModulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );
}

class $$HyroxModulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HyroxModulesTable,
          HyroxModule,
          $$HyroxModulesTableFilterComposer,
          $$HyroxModulesTableOrderingComposer,
          $$HyroxModulesTableAnnotationComposer,
          $$HyroxModulesTableCreateCompanionBuilder,
          $$HyroxModulesTableUpdateCompanionBuilder,
          (
            HyroxModule,
            BaseReferences<_$AppDatabase, $HyroxModulesTable, HyroxModule>,
          ),
          HyroxModule,
          PrefetchHooks Function()
        > {
  $$HyroxModulesTableTableManager(_$AppDatabase db, $HyroxModulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HyroxModulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HyroxModulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HyroxModulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
              }) => HyroxModulesCompanion(
                id: id,
                key: key,
                nombre: nombre,
                descripcion: descripcion,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String key,
                required String nombre,
                Value<String?> descripcion = const Value.absent(),
              }) => HyroxModulesCompanion.insert(
                id: id,
                key: key,
                nombre: nombre,
                descripcion: descripcion,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HyroxModulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HyroxModulesTable,
      HyroxModule,
      $$HyroxModulesTableFilterComposer,
      $$HyroxModulesTableOrderingComposer,
      $$HyroxModulesTableAnnotationComposer,
      $$HyroxModulesTableCreateCompanionBuilder,
      $$HyroxModulesTableUpdateCompanionBuilder,
      (
        HyroxModule,
        BaseReferences<_$AppDatabase, $HyroxModulesTable, HyroxModule>,
      ),
      HyroxModule,
      PrefetchHooks Function()
    >;
typedef $$HyroxPenaltyTypesTableCreateCompanionBuilder =
    HyroxPenaltyTypesCompanion Function({
      Value<int> id,
      required int moduleId,
      required String label,
      Value<String?> description,
      required int penaltySeconds,
    });
typedef $$HyroxPenaltyTypesTableUpdateCompanionBuilder =
    HyroxPenaltyTypesCompanion Function({
      Value<int> id,
      Value<int> moduleId,
      Value<String> label,
      Value<String?> description,
      Value<int> penaltySeconds,
    });

class $$HyroxPenaltyTypesTableFilterComposer
    extends Composer<_$AppDatabase, $HyroxPenaltyTypesTable> {
  $$HyroxPenaltyTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get moduleId => $composableBuilder(
    column: $table.moduleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get penaltySeconds => $composableBuilder(
    column: $table.penaltySeconds,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HyroxPenaltyTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $HyroxPenaltyTypesTable> {
  $$HyroxPenaltyTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get moduleId => $composableBuilder(
    column: $table.moduleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get penaltySeconds => $composableBuilder(
    column: $table.penaltySeconds,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HyroxPenaltyTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HyroxPenaltyTypesTable> {
  $$HyroxPenaltyTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get moduleId =>
      $composableBuilder(column: $table.moduleId, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get penaltySeconds => $composableBuilder(
    column: $table.penaltySeconds,
    builder: (column) => column,
  );
}

class $$HyroxPenaltyTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HyroxPenaltyTypesTable,
          HyroxPenaltyType,
          $$HyroxPenaltyTypesTableFilterComposer,
          $$HyroxPenaltyTypesTableOrderingComposer,
          $$HyroxPenaltyTypesTableAnnotationComposer,
          $$HyroxPenaltyTypesTableCreateCompanionBuilder,
          $$HyroxPenaltyTypesTableUpdateCompanionBuilder,
          (
            HyroxPenaltyType,
            BaseReferences<
              _$AppDatabase,
              $HyroxPenaltyTypesTable,
              HyroxPenaltyType
            >,
          ),
          HyroxPenaltyType,
          PrefetchHooks Function()
        > {
  $$HyroxPenaltyTypesTableTableManager(
    _$AppDatabase db,
    $HyroxPenaltyTypesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HyroxPenaltyTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HyroxPenaltyTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HyroxPenaltyTypesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> moduleId = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> penaltySeconds = const Value.absent(),
              }) => HyroxPenaltyTypesCompanion(
                id: id,
                moduleId: moduleId,
                label: label,
                description: description,
                penaltySeconds: penaltySeconds,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int moduleId,
                required String label,
                Value<String?> description = const Value.absent(),
                required int penaltySeconds,
              }) => HyroxPenaltyTypesCompanion.insert(
                id: id,
                moduleId: moduleId,
                label: label,
                description: description,
                penaltySeconds: penaltySeconds,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HyroxPenaltyTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HyroxPenaltyTypesTable,
      HyroxPenaltyType,
      $$HyroxPenaltyTypesTableFilterComposer,
      $$HyroxPenaltyTypesTableOrderingComposer,
      $$HyroxPenaltyTypesTableAnnotationComposer,
      $$HyroxPenaltyTypesTableCreateCompanionBuilder,
      $$HyroxPenaltyTypesTableUpdateCompanionBuilder,
      (
        HyroxPenaltyType,
        BaseReferences<
          _$AppDatabase,
          $HyroxPenaltyTypesTable,
          HyroxPenaltyType
        >,
      ),
      HyroxPenaltyType,
      PrefetchHooks Function()
    >;
typedef $$HyroxPenaltyLogTableCreateCompanionBuilder =
    HyroxPenaltyLogCompanion Function({
      Value<int> id,
      required int sessionId,
      required int idEquipo,
      required int idEstacion,
      required int moduleId,
      required int penaltyTypeId,
      required int penaltySeconds,
      required int timerMsAtPenalty,
      Value<DateTime> appliedAt,
      Value<int> sincronizado,
    });
typedef $$HyroxPenaltyLogTableUpdateCompanionBuilder =
    HyroxPenaltyLogCompanion Function({
      Value<int> id,
      Value<int> sessionId,
      Value<int> idEquipo,
      Value<int> idEstacion,
      Value<int> moduleId,
      Value<int> penaltyTypeId,
      Value<int> penaltySeconds,
      Value<int> timerMsAtPenalty,
      Value<DateTime> appliedAt,
      Value<int> sincronizado,
    });

class $$HyroxPenaltyLogTableFilterComposer
    extends Composer<_$AppDatabase, $HyroxPenaltyLogTable> {
  $$HyroxPenaltyLogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idEquipo => $composableBuilder(
    column: $table.idEquipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idEstacion => $composableBuilder(
    column: $table.idEstacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get moduleId => $composableBuilder(
    column: $table.moduleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get penaltyTypeId => $composableBuilder(
    column: $table.penaltyTypeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get penaltySeconds => $composableBuilder(
    column: $table.penaltySeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timerMsAtPenalty => $composableBuilder(
    column: $table.timerMsAtPenalty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get appliedAt => $composableBuilder(
    column: $table.appliedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sincronizado => $composableBuilder(
    column: $table.sincronizado,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HyroxPenaltyLogTableOrderingComposer
    extends Composer<_$AppDatabase, $HyroxPenaltyLogTable> {
  $$HyroxPenaltyLogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idEquipo => $composableBuilder(
    column: $table.idEquipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idEstacion => $composableBuilder(
    column: $table.idEstacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get moduleId => $composableBuilder(
    column: $table.moduleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get penaltyTypeId => $composableBuilder(
    column: $table.penaltyTypeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get penaltySeconds => $composableBuilder(
    column: $table.penaltySeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timerMsAtPenalty => $composableBuilder(
    column: $table.timerMsAtPenalty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get appliedAt => $composableBuilder(
    column: $table.appliedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sincronizado => $composableBuilder(
    column: $table.sincronizado,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HyroxPenaltyLogTableAnnotationComposer
    extends Composer<_$AppDatabase, $HyroxPenaltyLogTable> {
  $$HyroxPenaltyLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<int> get idEquipo =>
      $composableBuilder(column: $table.idEquipo, builder: (column) => column);

  GeneratedColumn<int> get idEstacion => $composableBuilder(
    column: $table.idEstacion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get moduleId =>
      $composableBuilder(column: $table.moduleId, builder: (column) => column);

  GeneratedColumn<int> get penaltyTypeId => $composableBuilder(
    column: $table.penaltyTypeId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get penaltySeconds => $composableBuilder(
    column: $table.penaltySeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timerMsAtPenalty => $composableBuilder(
    column: $table.timerMsAtPenalty,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get appliedAt =>
      $composableBuilder(column: $table.appliedAt, builder: (column) => column);

  GeneratedColumn<int> get sincronizado => $composableBuilder(
    column: $table.sincronizado,
    builder: (column) => column,
  );
}

class $$HyroxPenaltyLogTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HyroxPenaltyLogTable,
          HyroxPenaltyLogData,
          $$HyroxPenaltyLogTableFilterComposer,
          $$HyroxPenaltyLogTableOrderingComposer,
          $$HyroxPenaltyLogTableAnnotationComposer,
          $$HyroxPenaltyLogTableCreateCompanionBuilder,
          $$HyroxPenaltyLogTableUpdateCompanionBuilder,
          (
            HyroxPenaltyLogData,
            BaseReferences<
              _$AppDatabase,
              $HyroxPenaltyLogTable,
              HyroxPenaltyLogData
            >,
          ),
          HyroxPenaltyLogData,
          PrefetchHooks Function()
        > {
  $$HyroxPenaltyLogTableTableManager(
    _$AppDatabase db,
    $HyroxPenaltyLogTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HyroxPenaltyLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HyroxPenaltyLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HyroxPenaltyLogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<int> idEquipo = const Value.absent(),
                Value<int> idEstacion = const Value.absent(),
                Value<int> moduleId = const Value.absent(),
                Value<int> penaltyTypeId = const Value.absent(),
                Value<int> penaltySeconds = const Value.absent(),
                Value<int> timerMsAtPenalty = const Value.absent(),
                Value<DateTime> appliedAt = const Value.absent(),
                Value<int> sincronizado = const Value.absent(),
              }) => HyroxPenaltyLogCompanion(
                id: id,
                sessionId: sessionId,
                idEquipo: idEquipo,
                idEstacion: idEstacion,
                moduleId: moduleId,
                penaltyTypeId: penaltyTypeId,
                penaltySeconds: penaltySeconds,
                timerMsAtPenalty: timerMsAtPenalty,
                appliedAt: appliedAt,
                sincronizado: sincronizado,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sessionId,
                required int idEquipo,
                required int idEstacion,
                required int moduleId,
                required int penaltyTypeId,
                required int penaltySeconds,
                required int timerMsAtPenalty,
                Value<DateTime> appliedAt = const Value.absent(),
                Value<int> sincronizado = const Value.absent(),
              }) => HyroxPenaltyLogCompanion.insert(
                id: id,
                sessionId: sessionId,
                idEquipo: idEquipo,
                idEstacion: idEstacion,
                moduleId: moduleId,
                penaltyTypeId: penaltyTypeId,
                penaltySeconds: penaltySeconds,
                timerMsAtPenalty: timerMsAtPenalty,
                appliedAt: appliedAt,
                sincronizado: sincronizado,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HyroxPenaltyLogTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HyroxPenaltyLogTable,
      HyroxPenaltyLogData,
      $$HyroxPenaltyLogTableFilterComposer,
      $$HyroxPenaltyLogTableOrderingComposer,
      $$HyroxPenaltyLogTableAnnotationComposer,
      $$HyroxPenaltyLogTableCreateCompanionBuilder,
      $$HyroxPenaltyLogTableUpdateCompanionBuilder,
      (
        HyroxPenaltyLogData,
        BaseReferences<
          _$AppDatabase,
          $HyroxPenaltyLogTable,
          HyroxPenaltyLogData
        >,
      ),
      HyroxPenaltyLogData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HyroxTiemposTableTableManager get hyroxTiempos =>
      $$HyroxTiemposTableTableManager(_db, _db.hyroxTiempos);
  $$HyroxRaceSessionsTableTableManager get hyroxRaceSessions =>
      $$HyroxRaceSessionsTableTableManager(_db, _db.hyroxRaceSessions);
  $$HyroxModulesTableTableManager get hyroxModules =>
      $$HyroxModulesTableTableManager(_db, _db.hyroxModules);
  $$HyroxPenaltyTypesTableTableManager get hyroxPenaltyTypes =>
      $$HyroxPenaltyTypesTableTableManager(_db, _db.hyroxPenaltyTypes);
  $$HyroxPenaltyLogTableTableManager get hyroxPenaltyLog =>
      $$HyroxPenaltyLogTableTableManager(_db, _db.hyroxPenaltyLog);
}
