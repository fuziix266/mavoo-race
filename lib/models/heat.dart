class Heat {
  final int id;
  final String nombre;
  final String categoria;
  final String horaInicio;
  final List<Team> equipos;

  const Heat({
    required this.id,
    required this.nombre,
    required this.categoria,
    required this.horaInicio,
    required this.equipos,
  });

  factory Heat.fromMap(Map<String, dynamic> map, {List<Team> equipos = const []}) {
    return Heat(
      id: map['id'],
      nombre: map['nombre'],
      categoria: map['categoria'],
      horaInicio: map['hora_inicio'],
      equipos: equipos,
    );
  }

  /// Datos hardcoded del evento MALLKUBOX 2026
  static List<Heat> get allHeats => [
    Heat(
      id: 1, nombre: 'Heat 1', categoria: 'Duplas Mujeres Amateur', horaInicio: '08:00',
      equipos: [
        Team(id: 1, idHeat: 1, nombre: 'Imparables'),
        Team(id: 2, idHeat: 1, nombre: 'Las Morenasas'),
        Team(id: 3, idHeat: 1, nombre: 'Sinchi Warmi'),
        Team(id: 4, idHeat: 1, nombre: 'Las 30&Fuertes'),
      ],
    ),
    Heat(
      id: 2, nombre: 'Heat 2', categoria: 'Duplas Mujeres Amateur', horaInicio: '08:30',
      equipos: [
        Team(id: 5, idHeat: 2, nombre: 'Las Despist-hadas'),
        Team(id: 6, idHeat: 2, nombre: 'Barbara y Nicol'),
        Team(id: 7, idHeat: 2, nombre: 'Máquinas Primerizas'),
      ],
    ),
    Heat(
      id: 3, nombre: 'Heat 3', categoria: 'Duplas Hombres Amateur', horaInicio: '10:00',
      equipos: [
        Team(id: 8, idHeat: 3, nombre: 'Pinky y Cerebro'),
        Team(id: 9, idHeat: 3, nombre: 'Team CMT'),
        Team(id: 10, idHeat: 3, nombre: 'Los Hermanos Torres'),
        Team(id: 11, idHeat: 3, nombre: 'Mix Meta'),
        Team(id: 12, idHeat: 3, nombre: 'Team Eleven'),
      ],
    ),
    Heat(
      id: 4, nombre: 'Heat 4', categoria: 'Individual Hombres Pro', horaInicio: '12:00',
      equipos: [],
    ),
    Heat(
      id: 5, nombre: 'Heat 5', categoria: 'Duplas Mixtas Amateur', horaInicio: '14:00',
      equipos: [
        Team(id: 13, idHeat: 5, nombre: 'Studio Indómito'),
        Team(id: 14, idHeat: 5, nombre: 'Mix Meta Junior'),
        Team(id: 15, idHeat: 5, nombre: 'Pulso Indomalku'),
      ],
    ),
    Heat(
      id: 6, nombre: 'Heat 6', categoria: 'Duplas Mixtas Amateur', horaInicio: '14:30',
      equipos: [
        Team(id: 16, idHeat: 6, nombre: 'No Runners'),
        Team(id: 17, idHeat: 6, nombre: 'Mix Meta'),
        Team(id: 18, idHeat: 6, nombre: '40/20'),
      ],
    ),
  ];
}

class Team {
  final int id;
  final int idHeat;
  final String nombre;

  const Team({
    required this.id,
    required this.idHeat,
    required this.nombre,
  });

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'],
      idHeat: map['id_heat'],
      nombre: map['nombre'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'id_heat': idHeat, 'nombre': nombre};
  }
}
