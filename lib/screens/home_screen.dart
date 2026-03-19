import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/race_provider.dart';
import '../models/heat.dart';
import 'race_screen.dart';

// ─────────────────────────────────────────────────────────────────────────────
// HOME SCREEN — Diseño minimalista claro, colorido y moderno
// Fondo blanco/hueso, acentos de color por heat, tipografía bold
// ─────────────────────────────────────────────────────────────────────────────

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RaceProvider>();
    final heats = Heat.allHeats;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Logo / Header ───────────────────────────────────────────────
            SliverToBoxAdapter(
              child: _HomeHeader(),
            ),

            // ── Sección: Selecciona tu Heat ─────────────────────────────────
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
                      'SELECCIONA TU HEAT',
                      style: GoogleFonts.rajdhani(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final heat = heats[i];
                  final isSelected = provider.selectedHeat?.id == heat.id;
                  return _HeatCard(
                    heat: heat,
                    isSelected: isSelected,
                    onTap: () => provider.selectHeat(heat),
                  );
                },
                childCount: heats.length,
              ),
            ),

            // ── Sección: Selecciona tu Equipo ───────────────────────────────
            if (provider.selectedHeat != null &&
                provider.selectedHeat!.equipos.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 10),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 18,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00B894),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'SELECCIONA TU EQUIPO',
                        style: GoogleFonts.rajdhani(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Colors.black54,
                          letterSpacing: 2.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final team = provider.selectedHeat!.equipos[i];
                    final isSelected = provider.selectedTeam?.id == team.id;
                    return _TeamTile(
                      team: team,
                      isSelected: isSelected,
                      onTap: () => provider.selectTeam(team),
                    );
                  },
                  childCount: provider.selectedHeat!.equipos.length,
                ),
              ),
            ],

            // ── Botón Iniciar Carrera ────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
                child: _StartButton(
                  enabled: provider.selectedTeam != null,
                  onTap: () => _startRace(context, provider),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  Future<void> _startRace(BuildContext context, RaceProvider provider) async {
    await provider.startRace();
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RaceScreen()),
      );
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header: Logo + Título + Fecha
// ─────────────────────────────────────────────────────────────────────────────

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
      decoration: BoxDecoration(
        // Header con gradiente sutil teal → indigo — marca de la app
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MALLKUBOX',
                      style: GoogleFonts.rajdhani(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 3,
                        height: 1.0,
                      ),
                    ),
                    Text(
                      'ARICA RACE 2026',
                      style: GoogleFonts.rajdhani(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                        letterSpacing: 4,
                      ),
                    ),
                  ],
                ),
              ),
              FaIcon(
                FontAwesomeIcons.stopwatch,
                color: Colors.white.withAlpha(180),
                size: 40,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 1,
            color: Colors.white.withAlpha(50),
          ),
          const SizedBox(height: 16),
          // Info rápida de la carrera
          Row(
            children: [
              _InfoBadge(
                icon: Icons.calendar_today_rounded,
                label: 'Sábado 21 Marzo',
              ),
              const SizedBox(width: 12),
              _InfoBadge(
                icon: Icons.directions_run_rounded,
                label: '16 estaciones',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  const _InfoBadge({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: Colors.white60),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tarjeta de Heat — fondo blanco, borde de color izquierdo
// ─────────────────────────────────────────────────────────────────────────────

class _HeatCard extends StatelessWidget {
  const _HeatCard({
    required this.heat,
    required this.isSelected,
    required this.onTap,
  });
  final Heat heat;
  final bool isSelected;
  final VoidCallback onTap;

  static const List<Color> _heatColors = [
    Color(0xFF6C5CE7), // indigo
    Color(0xFF00B4D8), // cyan
    Color(0xFF00B894), // teal
    Color(0xFFFF7675), // coral
    Color(0xFFFDAA5D), // naranja
    Color(0xFFA29BFE), // lavanda
  ];

  @override
  Widget build(BuildContext context) {
    final color = _heatColors[(heat.id - 1) % _heatColors.length];

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : const Color(0xFFEAECF0),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? color.withAlpha(40)
                  : Colors.black.withAlpha(10),
              blurRadius: isSelected ? 16 : 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Barra lateral de color
            Container(
              width: 5,
              height: 72,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Número del heat
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '${heat.id}',
                  style: GoogleFonts.rajdhani(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: color,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heat.nombre,
                    style: GoogleFonts.rajdhani(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                  Text(
                    '${heat.categoria} · ${heat.horaInicio} hrs',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.black45,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: heat.equipos.isEmpty
                  ? Text(
                      'Sin equipos',
                      style: GoogleFonts.inter(
                          fontSize: 10, color: Colors.black26),
                    )
                  : AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: isSelected
                          ? Icon(Icons.check_circle_rounded,
                              color: color, size: 22, key: const ValueKey('check'))
                          : Icon(Icons.radio_button_unchecked_rounded,
                              color: Colors.black12, size: 22, key: const ValueKey('empty')),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tile de equipo — minimalista, fondo blanco
// ─────────────────────────────────────────────────────────────────────────────

class _TeamTile extends StatelessWidget {
  const _TeamTile({
    required this.team,
    required this.isSelected,
    required this.onTap,
  });
  final dynamic team;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF00B894);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? color.withAlpha(15) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? color : const Color(0xFFEAECF0),
            width: isSelected ? 2 : 1,
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
            Icon(
              Icons.group_rounded,
              color: isSelected ? color : Colors.black26,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                team.nombre,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  color: isSelected ? color : const Color(0xFF444457),
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_rounded, color: color, size: 20),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Botón Iniciar Carrera
// ─────────────────────────────────────────────────────────────────────────────

class _StartButton extends StatelessWidget {
  const _StartButton({required this.enabled, required this.onTap});
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: enabled ? 1.0 : 0.35,
      duration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            gradient: enabled
                ? const LinearGradient(
                    colors: [Color(0xFF6C5CE7), Color(0xFF00B4D8)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : LinearGradient(
                    colors: [Colors.grey.shade300, Colors.grey.shade200],
                  ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: enabled
                ? [
                    BoxShadow(
                      color: const Color(0xFF6C5CE7).withAlpha(90),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    )
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'INICIAR CARRERA',
                style: GoogleFonts.rajdhani(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: enabled ? Colors.white : Colors.black26,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.arrow_forward_rounded,
                color: enabled ? Colors.white : Colors.black26,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
