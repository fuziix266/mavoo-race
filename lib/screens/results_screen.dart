import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/race_provider.dart';
import '../models/race_time.dart';
import '../models/station.dart';
import 'home_screen.dart';

// ─────────────────────────────────────────────────────────────────────────────
// RESULTS SCREEN — Mismo estilo claro del HomeScreen
// Fondo F5F6FA, header gradiente, cards blancas
// ─────────────────────────────────────────────────────────────────────────────

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  static const List<Color> _stationColors = [
    Color(0xFF6C5CE7),
    Color(0xFF00B4D8),
    Color(0xFF00B894),
    Color(0xFFFF7675),
    Color(0xFFFDAA5D),
    Color(0xFFA29BFE),
    Color(0xFF74B9FF),
    Color(0xFFFF9FF3),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.read<RaceProvider>();
    final times = provider.completedTimes;
    final stations = provider.stations;

    final totalMs = times.fold<int>(0, (sum, t) => sum + t.tiempoMs);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Header ────────────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: _ResultsHeader(
                teamName: provider.selectedTeam?.nombre ?? '',
                heatName: provider.selectedHeat?.nombre ?? '',
                totalMs: totalMs,
                stationCount: times.length,
              ),
            ),

            // ── Sección tiempos ───────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 18,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C5CE7),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'TIEMPOS POR ESTACIÓN',
                      style: GoogleFonts.rajdhani(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54,
                        letterSpacing: 2.5,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${times.length} estaciones',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final time = times[i];
                  final station = stations.firstWhere(
                    (s) => s.id == time.idEstacion,
                    orElse: () => stations[i < stations.length ? i : 0],
                  );
                  final color = _stationColors[i % _stationColors.length];
                  // Detectar si es el mejor tiempo
                  final isBest = times.isNotEmpty &&
                      time.tiempoMs ==
                          times
                              .map((t) => t.tiempoMs)
                              .reduce((a, b) => a < b ? a : b);

                  return _TimeCard(
                    station: station,
                    raceTime: time,
                    color: color,
                    index: i + 1,
                    isBest: isBest && times.length > 1,
                  );
                },
                childCount: times.length,
              ),
            ),

            // ── Botón nueva carrera ───────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (route) => false,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 62,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C5CE7), Color(0xFF00B4D8)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C5CE7).withAlpha(80),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.replay_rounded,
                            color: Colors.white, size: 22),
                        const SizedBox(width: 10),
                        Text(
                          'NUEVA CARRERA',
                          style: GoogleFonts.rajdhani(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header con gradiente y resumen
// ─────────────────────────────────────────────────────────────────────────────

class _ResultsHeader extends StatelessWidget {
  const _ResultsHeader({
    required this.teamName,
    required this.heatName,
    required this.totalMs,
    required this.stationCount,
  });

  final String teamName;
  final String heatName;
  final int totalMs;
  final int stationCount;

  String _formatMs(int ms) {
    final h = (ms ~/ 3600000).toString().padLeft(2, '0');
    final m = ((ms % 3600000) ~/ 60000).toString().padLeft(2, '0');
    final s = ((ms % 60000) ~/ 1000).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6C5CE7), Color(0xFF00B4D8)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C5CE7).withAlpha(80),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trofeo + título
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¡CARRERA\nFINALIZADA!',
                      style: GoogleFonts.rajdhani(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1,
                        height: 1.05,
                      ),
                    ),
                    if (teamName.isNotEmpty)
                      Text(
                        teamName,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    if (heatName.isNotEmpty)
                      Text(
                        heatName,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: Colors.white54,
                        ),
                      ),
                  ],
                ),
              ),
              const Icon(
                Icons.emoji_events_rounded,
                color: Colors.white,
                size: 52,
              ),
            ],
          ),

          const SizedBox(height: 20),
          Container(height: 1, color: Colors.white.withAlpha(50)),
          const SizedBox(height: 20),

          // Tiempo total destacado
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TIEMPO TOTAL',
                      style: GoogleFonts.rajdhani(
                        fontSize: 11,
                        color: Colors.white54,
                        letterSpacing: 3,
                      ),
                    ),
                    Text(
                      _formatMs(totalMs),
                      style: GoogleFonts.rajdhani(
                        fontSize: 46,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              // Badge estaciones completadas
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: Colors.white.withAlpha(50), width: 1),
                ),
                child: Column(
                  children: [
                    Text(
                      '$stationCount',
                      style: GoogleFonts.rajdhani(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.0,
                      ),
                    ),
                    Text(
                      'ESTACIONES',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        color: Colors.white70,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Card de tiempo por estación — fondo blanco, barra lateral de color
// ─────────────────────────────────────────────────────────────────────────────

class _TimeCard extends StatelessWidget {
  const _TimeCard({
    required this.station,
    required this.raceTime,
    required this.color,
    required this.index,
    required this.isBest,
  });

  final Station station;
  final RaceTime raceTime;
  final Color color;
  final int index;
  final bool isBest;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isBest ? color : const Color(0xFFEAECF0),
          width: isBest ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Barra lateral de color
          Container(
            width: 5,
            height: 62,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(13),
                bottomLeft: Radius.circular(13),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Número
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '$index',
                style: GoogleFonts.rajdhani(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: color,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Nombre estación
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        station.nombre,
                        style: GoogleFonts.rajdhani(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                    ),
                    if (isBest)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: color.withAlpha(20),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '★ MEJOR',
                          style: GoogleFonts.rajdhani(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: color,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  station.descripcion,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          // Tiempo + sync icon
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  raceTime.tiempoFormateado,
                  style: GoogleFonts.rajdhani(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: color,
                    letterSpacing: 1,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      raceTime.sincronizado
                          ? Icons.cloud_done_rounded
                          : Icons.phone_android_rounded,
                      size: 11,
                      color: raceTime.sincronizado
                          ? Colors.green
                          : Colors.black26,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      raceTime.sincronizado ? 'sync' : 'local',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        color: raceTime.sincronizado
                            ? Colors.green
                            : Colors.black26,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
