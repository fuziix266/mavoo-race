class Station {
  final int id;
  final int orden;
  final String tipo; // 'run' | 'estacion'
  final String nombre;
  final String descripcion;
  final String? pesoAmateur;
  final String? pesoPro;
  final int color; // ARGB color value

  const Station({
    required this.id,
    required this.orden,
    required this.tipo,
    required this.nombre,
    required this.descripcion,
    this.pesoAmateur,
    this.pesoPro,
    required this.color,
  });

  bool get isRun => tipo == 'run';

  factory Station.fromMap(Map<String, dynamic> map) {
    return Station(
      id: map['id'],
      orden: map['orden'],
      tipo: map['tipo'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      pesoAmateur: map['peso_amateur'],
      pesoPro: map['peso_pro'],
      color: map['color'] ?? 0xFFFF6B00,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orden': orden,
      'tipo': tipo,
      'nombre': nombre,
      'descripcion': descripcion,
      'peso_amateur': pesoAmateur,
      'peso_pro': pesoPro,
      'color': color,
    };
  }

  /// Lista completa de los 16 segmentos del MALLKUBOX ARICA RACE 2026
  static List<Station> get allStations => [
    const Station(
      id: 1, orden: 1, tipo: 'run',
      nombre: 'RUN 1', descripcion: 'Carrera 800 mt',
      color: 0xFF00D4FF,
    ),
    const Station(
      id: 2, orden: 2, tipo: 'estacion',
      nombre: 'Ski Erg', descripcion: '1.000 mt',
      color: 0xFF7B2FBE,
    ),
    const Station(
      id: 3, orden: 3, tipo: 'run',
      nombre: 'RUN 2', descripcion: 'Carrera 800 mt',
      color: 0xFF00D4FF,
    ),
    const Station(
      id: 4, orden: 4, tipo: 'estacion',
      nombre: 'Farmer Carry', descripcion: '200 mt',
      pesoAmateur: '16 kg / 22,5 kg',
      pesoPro: '24 kg',
      color: 0xFFFF6B00,
    ),
    const Station(
      id: 5, orden: 5, tipo: 'run',
      nombre: 'RUN 3', descripcion: 'Carrera 800 mt',
      color: 0xFF00D4FF,
    ),
    const Station(
      id: 6, orden: 6, tipo: 'estacion',
      nombre: 'Row Erg', descripcion: '1.000 mt',
      color: 0xFF7B2FBE,
    ),
    const Station(
      id: 7, orden: 7, tipo: 'run',
      nombre: 'RUN 4', descripcion: 'Carrera 800 mt',
      color: 0xFF00D4FF,
    ),
    const Station(
      id: 8, orden: 8, tipo: 'estacion',
      nombre: 'Burpees to Plate', descripcion: '100 reps',
      pesoAmateur: '15 lb',
      pesoPro: '25 lb',
      color: 0xFFFF1744,
    ),
    const Station(
      id: 9, orden: 9, tipo: 'run',
      nombre: 'RUN 5', descripcion: 'Carrera 800 mt',
      color: 0xFF00D4FF,
    ),
    const Station(
      id: 10, orden: 10, tipo: 'estacion',
      nombre: 'Plate Sit Up', descripcion: '100 reps',
      pesoAmateur: '25 lb',
      pesoPro: '35 lb',
      color: 0xFF00BFA5,
    ),
    const Station(
      id: 11, orden: 11, tipo: 'run',
      nombre: 'RUN 6', descripcion: 'Carrera 800 mt',
      color: 0xFF00D4FF,
    ),
    const Station(
      id: 12, orden: 12, tipo: 'estacion',
      nombre: 'Lunges Estacionarias', descripcion: '100 reps',
      pesoAmateur: '15 kg / 25 kg',
      pesoPro: '35 kg',
      color: 0xFFFF6B00,
    ),
    const Station(
      id: 13, orden: 13, tipo: 'run',
      nombre: 'RUN 7', descripcion: 'Carrera 800 mt',
      color: 0xFF00D4FF,
    ),
    const Station(
      id: 14, orden: 14, tipo: 'estacion',
      nombre: 'Kettlebell Swing', descripcion: '100 reps',
      pesoAmateur: '16 kg / 20 kg',
      pesoPro: '24 kg',
      color: 0xFF7B2FBE,
    ),
    const Station(
      id: 15, orden: 15, tipo: 'run',
      nombre: 'RUN 8', descripcion: 'Carrera 800 mt',
      color: 0xFF00D4FF,
    ),
    const Station(
      id: 16, orden: 16, tipo: 'estacion',
      nombre: 'Wall Ball Shots', descripcion: '100 reps',
      pesoAmateur: '5 kg / 7 kg',
      pesoPro: '9 kg',
      color: 0xFFFF1744,
    ),
  ];
}
