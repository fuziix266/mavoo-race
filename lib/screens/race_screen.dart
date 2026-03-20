import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/race_provider.dart';
import '../models/station.dart';
import '../models/race_time.dart';
import '../models/penalty.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'results_screen.dart';

// ─────────────────────────────────────────────────────────────────────────────
// RACE SCREEN — Gradient Hero Design
// Fondo: gradiente del color de la estación (claro arriba → oscuro abajo)
// Centro: tiempo enorme con fontFeature.tabularFigures (sin saltos)
// Base: panel frosted glass con info de estación y botones de acción
// ─────────────────────────────────────────────────────────────────────────────

class RaceScreen extends StatelessWidget {
  const RaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RaceProvider>();

    if (provider.raceState == RaceState.finished) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ResultsScreen()),
        );
      });
    }

    final station = provider.currentStation;
    final stationColor = Color(station.color);

    // Gradiente: más claro arriba-derecha → color puro → oscuro abajo-izquierda
    // Contraste aumentado para que sea visible incluso en colores claros (celeste)
    final gradLight = Color.lerp(stationColor, Colors.white, 0.60)!;
    final gradDark  = Color.lerp(stationColor, Colors.black, 0.55)!;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [gradLight, stationColor, gradDark],
            stops: const [0.0, 0.50, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── Dots de progreso ─────────────────────────────────────────
              _ProgressDots(provider: provider, stationColor: stationColor),

              // ── Fila: Botón atrás + Pill de estación ─────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    _BackIconButton(
                      canGoBack: provider.canGoBack,
                      isRunning: provider.isRunning,
                      onPressed: () => _showBackDialog(
                        context: context,
                        provider: provider,
                        stationColor: stationColor,
                      ),
                      onExit: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Center(child: _StationPill(station: station)),
                    ),
                    // Botón Home — simetría con el botón de atrás
                    GestureDetector(
                      onTap: () => _showExitDialog(
                        context: context,
                        stationColor: stationColor,
                      ),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(30),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: Colors.white.withAlpha(40), width: 1),
                        ),
                        child: const Icon(
                          Icons.home_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Tiempo + Ícono centrados (Expanded ocupa todo el resto) ──
              Expanded(
                child: _HeroTimer(
                  provider: provider,
                  station: station,
                ),
              ),

              // ── Panel frosted glass inferior ─────────────────────────────
              _GlassPanel(
                station: station,
                provider: provider,
                stationColor: stationColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Puntos de progreso (16 dots arriba, como la imagen de referencia)
// ─────────────────────────────────────────────────────────────────────────────

class _ProgressDots extends StatelessWidget {
  const _ProgressDots({required this.provider, required this.stationColor});
  final RaceProvider provider;
  final Color stationColor;

  @override
  Widget build(BuildContext context) {
    final done = provider.completedTimes.length;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(16, (i) {
              final isCompleted = i < done;
              final isCurrent   = i == provider.currentStationIndex;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2.5),
                width: isCurrent ? 14 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Colors.white
                      : isCurrent
                          ? Colors.white70
                          : Colors.white24,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          const SizedBox(height: 6),
          Text(
            '${done} of 16 done',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.white60,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Pill con el nombre de la estación actual
// ─────────────────────────────────────────────────────────────────────────────

class _StationPill extends StatelessWidget {
  const _StationPill({required this.station});
  final Station station;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white30, width: 1),
      ),
      child: Text(
        station.nombre.toUpperCase(),
        style: GoogleFonts.rajdhani(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: 2.5,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tiempo gigante centrado — CLAVE: FontFeature.tabularFigures() evita que
// el layout salte cuando cambian los dígitos. Cada cifra ocupa el mismo ancho.
// ─────────────────────────────────────────────────────────────────────────────

class _HeroTimer extends StatelessWidget {
  const _HeroTimer({required this.provider, required this.station});
  final RaceProvider provider;
  final Station station;

  @override
  Widget build(BuildContext context) {
    // Parsear el tiempo formateado: "00:02:47.83"
    final raw       = provider.formattedTime;          // HH:MM:SS.cs
    final parts     = raw.split('.');
    final mainParts = parts[0].split(':');

    // Extraer horas, minutos, segundos, centisegundos
    final h  = mainParts.length >= 3 ? mainParts[0] : '00'; // horas
    final mm = mainParts.length >= 3 ? mainParts[1] : (mainParts.length >= 2 ? mainParts[0] : '00');
    final ss = mainParts.last;
    final cs = parts.length > 1 ? parts[1] : '00';
    final hasHours = (int.tryParse(h) ?? 0) > 0;

    // Estilo base para todos los dígitos: tabularFigures asegura ancho fijo
    final tabularStyle = GoogleFonts.rajdhani(
      fontSize: 96,
      fontWeight: FontWeight.w900,
      color: Colors.white,
      height: 1.0,
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ─ Ícono FA del ejercicio — centrado entre el pill y los números
          _StationIllustration(station: station),
          const SizedBox(height: 20),

          // Horas (solo si > 0)
          if (hasHours)
            Text(
              '$h:',
              style: tabularStyle.copyWith(
                fontSize: 48,
                color: Colors.white60,
              ),
            ),

          // MM:SS  —  bloque principal
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              // MM — contenedor fijo 2 dígitos
              SizedBox(
                width: 116,
                child: Text(
                  mm,
                  textAlign: TextAlign.right,
                  style: tabularStyle,
                ),
              ),
              // Separador ":"
              Text(
                ':',
                style: tabularStyle.copyWith(color: Colors.white70),
              ),
              // SS — contenedor fijo 2 dígitos
              SizedBox(
                width: 116,
                child: Text(
                  ss,
                  textAlign: TextAlign.left,
                  style: tabularStyle,
                ),
              ),
            ],
          ),

          // Centisegundos — en una línea aparte, más pequeños, en fijo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '.',
                style: tabularStyle.copyWith(
                  fontSize: 40,
                  color: Colors.white60,
                ),
              ),
              // Ancho FIJO para los cs — nunca salta aunque cambie de 9→10
              SizedBox(
                width: 60,
                child: Text(
                  cs,
                  style: tabularStyle.copyWith(
                    fontSize: 48,
                    color: Colors.white,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Indicador de estado
          if (provider.isRunning)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'EN CURSO',
                  style: GoogleFonts.rajdhani(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white70,
                    letterSpacing: 3,
                  ),
                ),
              ],
            )
          else
            Text(
              provider.hasFinishedCurrentStation
                  ? 'LISTO — PRESIONA SIGUIENTE'
                  : 'PRESIONA INICIO',
              style: GoogleFonts.rajdhani(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white54,
                letterSpacing: 2,
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Panel frosted glass inferior
// ─────────────────────────────────────────────────────────────────────────────

class _GlassPanel extends StatelessWidget {
  const _GlassPanel({
    required this.station,
    required this.provider,
    required this.stationColor,
  });
  final Station station;
  final RaceProvider provider;
  final Color stationColor;

  @override
  Widget build(BuildContext context) {
    final isRunning = provider.isRunning;
    final hasPending = provider.hasFinishedCurrentStation;
    final isLast = provider.isLastStation;
    final canGoBack = provider.canGoBack;
    final totalTime = provider.totalMs > 0 ? provider.formattedTotalTime : null;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(40),
            border: const Border(
              top: BorderSide(color: Colors.white30, width: 1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Nombre + descripción de la estación
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ESTACIÓN ${station.orden}: ${station.nombre}',
                          style: GoogleFonts.rajdhani(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          station.descripcion,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (totalTime != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'TOTAL',
                          style: GoogleFonts.inter(
                              fontSize: 10, color: Colors.white54),
                        ),
                        Text(
                          totalTime,
                          style: GoogleFonts.rajdhani(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                ],
              ),

              // Pesos si aplica
              if (station.pesoAmateur != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (station.pesoAmateur != null)
                      _WeightChip('Amateur: ${station.pesoAmateur}'),
                    if (station.pesoPro != null) ...[
                      const SizedBox(width: 8),
                      _WeightChip('Pro: ${station.pesoPro}', isPro: true),
                    ],
                  ],
                ),
              ],

              const SizedBox(height: 16),

              // Botón principal: INICIO / FIN / SIGUIENTE / FINALIZAR
              SizedBox(
                width: double.infinity,
                height: 70,
                child: _MainButton(
                  isRunning: isRunning,
                  hasPending: hasPending,
                  isLast: isLast,
                  provider: provider,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _confirmGoBack(BuildContext context) {
    final hasPendingTime = provider.hasFinishedCurrentStation;
    final prevStation = provider.stations[provider.currentStationIndex - 1];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Text(
          '¿Volver a ${prevStation.nombre}?',
          style: GoogleFonts.rajdhani(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppTheme.bgDark,
          ),
        ),
        content: Text(
          hasPendingTime
              ? 'El tiempo provisional de esta estación se descartará.\n¿Fue un error al presionar FIN?'
              : 'Volverás a la estación anterior para cronometrar de nuevo.',
          style: GoogleFonts.inter(fontSize: 14, color: Colors.black54),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar',
                style: GoogleFonts.inter(color: Colors.black38)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: stationColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pop(context);
              provider.goBack();
            },
            child: Text('Sí, volver',
                style: GoogleFonts.rajdhani(
                    fontSize: 16, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Chip de peso (Amateur / Pro)
// ─────────────────────────────────────────────────────────────────────────────

class _WeightChip extends StatelessWidget {
  const _WeightChip(this.label, {this.isPro = false});
  final String label;
  final bool isPro;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(isPro ? 35 : 20),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withAlpha(isPro ? 100 : 60),
          width: isPro ? 1.5 : 1,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          color: Colors.white,
          fontWeight: isPro ? FontWeight.w700 : FontWeight.w400,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Botón principal de acción (INICIO / FIN / SIGUIENTE / FINALIZAR)
// ─────────────────────────────────────────────────────────────────────────────

class _MainButton extends StatelessWidget {
  const _MainButton({
    required this.isRunning,
    required this.hasPending,
    required this.isLast,
    required this.provider,
  });
  final bool isRunning;
  final bool hasPending;
  final bool isLast;
  final RaceProvider provider;

  @override
  Widget build(BuildContext context) {
    if (isRunning) {
      // ── PENALIZACIÓN (25%) + DETENER (75%) ────────────────────────────────
      return Row(
        children: [
          // Botón Penalización
          Flexible(
            flex: 1, // 25%
            child: SizedBox(
              height: 70,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE67E22),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () => _showPenaltyModal(context, provider),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.warning_amber_rounded, size: 22),
                    const SizedBox(height: 2),
                    Text(
                      provider.penaltyCount > 0
                          ? 'PEN. (${provider.penaltyCount})'
                          : 'PEN.',
                      style: GoogleFonts.rajdhani(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // DETENER
          Flexible(
            flex: 3, // 75%
            child: SizedBox(
              height: 70,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                onPressed: provider.stopTimer,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.stop_rounded, size: 22),
                    const SizedBox(width: 10),
                    Text('DETENER',
                        style: GoogleFonts.rajdhani(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2)),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

    } else if (hasPending) {
      // ── CONTINUAR (25%) + SIGUIENTE/FINALIZAR (75%) ────────────────────────
      return Row(
        children: [
          // CONTINUAR — reinicia el timer para la misma estación
          Flexible(
            flex: 1,  // 25%
            child: SizedBox(
              height: 70,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withAlpha(50),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                  padding: EdgeInsets.zero,
                ),
                onPressed: provider.resumeTimer,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.replay_rounded, size: 20),
                    const SizedBox(height: 2),
                    Text('CONT.',
                        style: GoogleFonts.rajdhani(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // SIGUIENTE / FINALIZAR
          Flexible(
            flex: 3,  // 75%
            child: SizedBox(
              height: 70,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                onPressed: () {
                  if (isLast) {
                    provider.finishRace();
                  } else {
                    provider.goToNextStation();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLast ? 'FINALIZAR' : 'SIGUIENTE',
                      style: GoogleFonts.rajdhani(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                          color: Colors.black87),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded,
                        size: 22, color: Colors.black87),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

    } else {
      // ── INICIO ─────────────────────────────────────────────────────────────
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        onPressed: provider.startTimer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.play_arrow_rounded, size: 26, color: Colors.black87),
            const SizedBox(width: 8),
            Text('INICIO',
                style: GoogleFonts.rajdhani(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                    color: Colors.black87)),
          ],
        ),
      );
    }
  }
}


// ─────────────────────────────────────────────────────────────────────────────
// Clases antiguas conservadas para compatibilidad (no se usan en UI)
// ─────────────────────────────────────────────────────────────────────────────

// ignore: unused_element
class _TopBar extends StatelessWidget {
  const _TopBar({required this.station, required this.provider, required this.stationColor});
  final Station station;
  final RaceProvider provider;
  final Color stationColor;
  @override Widget build(BuildContext context) => const SizedBox.shrink();
}

// ignore: unused_element
class _SparkTimer extends StatelessWidget {
  const _SparkTimer({required this.elapsedMs, required this.completedTimes,
    required this.isRunning, required this.stationColor, required this.stations,
    required this.formattedTime});
  final int elapsedMs;
  final List<RaceTime> completedTimes;
  final bool isRunning;
  final Color stationColor;
  final List<Station> stations;
  final String formattedTime;
  @override Widget build(BuildContext context) => const SizedBox.shrink();
}

// ignore: unused_element
class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.provider, required this.stationColor});
  final RaceProvider provider;
  final Color stationColor;
  @override Widget build(BuildContext context) => const SizedBox.shrink();
}

// ─────────────────────────────────────────────────────────────────────────────
// Botón atrás — arriba a la izquierda, habilitado/deshabilitado
// ─────────────────────────────────────────────────────────────────────────────

class _BackIconButton extends StatelessWidget {
  const _BackIconButton({
    required this.canGoBack,
    required this.isRunning,
    required this.onPressed,
    required this.onExit,
  });
  final bool canGoBack;
  final bool isRunning;
  final VoidCallback onPressed; // volver a estación anterior
  final VoidCallback onExit;   // salir al menú (primera estación)

  @override
  Widget build(BuildContext context) {
    final isFirstStation = !canGoBack;
    final enabled = !isRunning; // siempre habilitado si no está corriendo

    return GestureDetector(
      onTap: enabled ? (isFirstStation ? onExit : onPressed) : null,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(30),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white.withAlpha(40),
            width: 1,
          ),
        ),
        child: Icon(
          isFirstStation
              ? Icons.close_rounded
              : Icons.arrow_back_ios_new_rounded,
          color: enabled ? Colors.white : Colors.white.withAlpha(60),
          size: 18,
        ),
      ),
    );
  }
}

void _showBackDialog({
  required BuildContext context,
  required RaceProvider provider,
  required Color stationColor,
}) {
  final prevStation = provider.stations[provider.currentStationIndex - 1];

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: Text(
        '¿Volver a ${prevStation.nombre}?',
        style: GoogleFonts.rajdhani(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
        ),
      ),
      content: Text(
        'El tiempo provisional de esta estación se descartará.\n¿Fue un error al presionar FIN?',
        style: GoogleFonts.inter(fontSize: 14, color: Colors.black54),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar',
              style: GoogleFonts.inter(color: Colors.black38)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: stationColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            Navigator.pop(context);
            provider.goBack();
          },
          child: Text('Sí, volver',
              style: GoogleFonts.rajdhani(
                  fontSize: 16, fontWeight: FontWeight.w700)),
        ),
      ],
    ),
  );
}

void _showExitDialog({
  required BuildContext context,
  required Color stationColor,
}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: Text(
        '¿Salir al menú principal?',
        style: GoogleFonts.rajdhani(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
        ),
      ),
      content: Text(
        'El tiempo actual de esta estación no se guardará.',
        style: GoogleFonts.inter(fontSize: 14, color: Colors.black54),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar',
              style: GoogleFonts.inter(color: Colors.black38)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: stationColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            );
          },
          child: Text('Ir al inicio',
              style: GoogleFonts.rajdhani(
                  fontSize: 16, fontWeight: FontWeight.w700)),
        ),
      ],
    ),
  );
}


// ─────────────────────────────────────────────────────────────────────────────
// Icono de la estación — Font Awesome
// ─────────────────────────────────────────────────────────────────────────────

class _StationIllustration extends StatelessWidget {
  const _StationIllustration({required this.station});
  final Station station;

  static FaIconData _iconFor(Station s) {
    if (s.tipo == 'run')                      return FontAwesomeIcons.personRunning;
    final n = s.nombre.toLowerCase();
    if (n.contains('ski'))                    return FontAwesomeIcons.personSkiing;
    if (n.contains('farmer') || n.contains('carry')) return FontAwesomeIcons.weightHanging;
    if (n.contains('row'))                    return FontAwesomeIcons.personSwimming; // remo
    if (n.contains('burpee'))                 return FontAwesomeIcons.personFalling;
    if (n.contains('sit') || n.contains('plate')) return FontAwesomeIcons.dumbbell;
    if (n.contains('lunge'))                  return FontAwesomeIcons.personWalking;
    if (n.contains('kettlebell') || n.contains('swing')) return FontAwesomeIcons.weightHanging;
    if (n.contains('wall') || n.contains('ball')) return FontAwesomeIcons.basketball;
    return FontAwesomeIcons.stopwatch;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FaIcon(
        _iconFor(station),
        size: 72,
        color: Colors.white.withAlpha(230),
      ),
    );
  }
}

// ignore: unused_element
class _BackButton extends StatelessWidget {
  const _BackButton({required this.provider});
  final RaceProvider provider;
  @override Widget build(BuildContext context) => const SizedBox.shrink();
}

// ─────────────────────────────────────────────────────────────────────────────
// Modal de penalizaciones Race
// ─────────────────────────────────────────────────────────────────────────────

void _showPenaltyModal(BuildContext context, RaceProvider provider) {
  final station = provider.currentStation;
  final penalties = getPenaltiesForStation(station.tipo, station.nombre);

  showDialog(
    context: context,
    barrierColor: Colors.black.withAlpha(60),
    builder: (ctx) => _PenaltyModal(
      penalties: penalties,
      stationName: station.nombre,
      onPenalty: (p) {
        provider.addPenalty(p);
        Navigator.pop(ctx);
      },
    ),
  );
}

class _PenaltyModal extends StatelessWidget {
  const _PenaltyModal({
    required this.penalties,
    required this.stationName,
    required this.onPenalty,
  });
  final List<PenaltyItem> penalties;
  final String stationName;
  final void Function(PenaltyItem) onPenalty;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 48),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(130),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.black.withAlpha(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded,
                          color: Color(0xFFE67E22), size: 24),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PENALIZACIÓN',
                              style: GoogleFonts.rajdhani(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF1A1A2E),
                                letterSpacing: 2,
                                height: 1,
                              ),
                            ),
                            Text(
                              stationName.toUpperCase(),
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                color: Colors.black38,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.close_rounded,
                            color: Colors.black38, size: 22),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // Lista de penalizaciones — scrollable sin scrollbar visible
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.55,
                    ),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        scrollbars: false,
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: penalties
                              .map((p) => _PenaltyButton(
                                    penalty: p,
                                    onTap: () => onPenalty(p),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PenaltyButton extends StatelessWidget {
  const _PenaltyButton({required this.penalty, required this.onTap});
  final PenaltyItem penalty;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(110),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black.withAlpha(12)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      penalty.label,
                      style: GoogleFonts.rajdhani(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                    Text(
                      penalty.description,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: Colors.black54,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: const Color(0xFFE67E22),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  penalty.formattedPenalty,
                  style: GoogleFonts.rajdhani(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
