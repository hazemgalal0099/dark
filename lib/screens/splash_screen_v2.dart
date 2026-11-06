import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../widgets/noir_theme.dart';
import '../widgets/british_flag.dart';

// ╔══════════════════════════════════════════════════════════════╗
// ║         SPLASH SCREEN V3 — GREEN FOREST EDITION             ║
// ║   الألوان: أخضر / فاتح / أبيض  |  تصميم غابة سينمائي       ║
// ╚══════════════════════════════════════════════════════════════╝

// ── ألوان V2 ──────────────────────────────────────────────────
const kCyan    = Color(0xFF00E5FF);
const kTeal    = Color(0xFF00BCD4);
const kNeonGold= Color(0xFFFFD600);
const kDarkBg  = Color(0xFF010A12);
const kGlowCyan= Color(0xFF00FFFF);

class SplashScreenV2 extends StatefulWidget {
  final VoidCallback onComplete;
  const SplashScreenV2({super.key, required this.onComplete});

  @override
  State<SplashScreenV2> createState() => _SplashScreenV2State();
}

class _SplashScreenV2State extends State<SplashScreenV2>
    with TickerProviderStateMixin {
  late final AnimationController _ctrl;

  // Phase 1 — Matrix code rain + scanlines appear (0.0→0.20)
  late final Animation<double> _matrixFade;

  // Phase 2 — John Wick materializes from code (0.12→0.35)
  late final Animation<double> _wickReveal;
  late final Animation<double> _wickGlitch;

  // Phase 3 — DARK text slams in from bottom (0.28→0.42)
  late final Animation<double> _darkTextSlide;
  late final Animation<double> _darkTextGlow;

  // Phase 4 — Horizontal cyan slash across screen (0.40→0.52)
  late final Animation<double> _slashProgress;
  late final Animation<double> _slashFade;

  // Phase 5 — Apple materializes from slash center (0.50→0.68)
  late final Animation<double> _appleAppear;
  late final Animation<double> _appleGlow;
  late final Animation<double> _appleSplit;

  // Phase 6 — Victory text (0.68→0.82)
  late final Animation<double> _victoryReveal;

  // Phase 7 — Screen flicker exit (0.88→1.0)
  late final Animation<double> _exitFlicker;

  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();

    // إجمالي: 4 ثوانٍ
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    // Phase 1 — Matrix rain (0.00→0.20)
    _matrixFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.00, 0.18, curve: Curves.easeIn)),
    );

    // Phase 2 — Wick materializes (0.12→0.38)
    _wickReveal = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.12, 0.38, curve: Curves.easeOut)),
    );
    _wickGlitch = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.6), weight: 15),
      TweenSequenceItem(tween: Tween(begin: 0.6, end: 1.0), weight: 15),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.85), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 0.85, end: 1.0), weight: 40),
    ]).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.12, 0.40, curve: Curves.linear)),
    );

    // Phase 3 — DARK text (0.28→0.44)
    _darkTextSlide = Tween<double>(begin: 120.0, end: 0.0).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.28, 0.44, curve: Curves.easeOutBack)),
    );
    _darkTextGlow = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.32, 0.50, curve: Curves.easeOut)),
    );

    // Phase 4 — Cyan slash (0.40→0.54)
    _slashProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.40, 0.54, curve: Curves.easeOutExpo)),
    );
    _slashFade = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 30),
    ]).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.40, 0.62, curve: Curves.linear)),
    );

    // Phase 5 — Apple (0.50→0.78)
    _appleAppear = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.50, 0.63, curve: Curves.easeOutBack)),
    );
    _appleGlow = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.52, 0.68, curve: Curves.easeOut)),
    );
    _appleSplit = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.62, 0.82, curve: Curves.easeInOutCubic)),
    );

    // Phase 6 — Victory text (0.68→0.84)
    _victoryReveal = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.68, 0.84, curve: Curves.easeOut)),
    );

    // Phase 7 — Exit (0.88→1.0)
    _exitFlicker = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 60),
    ]).animate(
      CurvedAnimation(parent: _ctrl, curve: const Interval(0.88, 1.00, curve: Curves.linear)),
    );

    _ctrl.addStatusListener((s) {
      if (s == AnimationStatus.completed) _finish();
    });
    _ctrl.forward();
  }

  void _finish() {
    if (_isNavigating || !mounted) return;
    _isNavigating = true;
    widget.onComplete();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return Opacity(
          opacity: _exitFlicker.value.clamp(0.0, 1.0),
          child: Scaffold(
            backgroundColor: kDarkBg,
            body: Stack(
              fit: StackFit.expand,
              children: [
                // Layer 1: John Wick V2 background (cyberpunk)
                _buildBackground(),

                // Layer 2: Matrix rain overlay
                if (_matrixFade.value > 0.01)
                  Opacity(
                    opacity: (_matrixFade.value * 0.55).clamp(0.0, 0.55),
                    child: CustomPaint(
                      painter: _MatrixRainPainter(progress: _ctrl.value),
                    ),
                  ),

                // Layer 3: Scanlines
                _buildScanlines(),

                // Layer 4: DARK text at bottom
                if (_darkTextSlide.value < 119) _buildDarkText(),

                // Layer 5: Cyan slash
                if (_slashFade.value > 0.01) _buildCyanSlash(),

                // Layer 6: Apple
                if (_appleAppear.value > 0.01) _buildCyberApple(),

                // Layer 7: Victory text
                if (_victoryReveal.value > 0.01) _buildVictoryText(),

                // Layer 8: Cyan corner accents
                _buildCornerAccents(),

                // Layer 8b: Russia Flag top-left
                Positioned(
                  top: MediaQuery.paddingOf(context).top + 14,
                  left: 16,
                  child: Opacity(
                    opacity: (_wickReveal.value).clamp(0.0, 1.0),
                    child: const BritishFlag(width: 54, height: 36, borderRadius: 5),
                  ),
                ),

                // Layer 9: Skip
                _buildSkip(),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── 1. Background ───────────────────────────────────────────
  Widget _buildBackground() {
    return Opacity(
      opacity: _wickReveal.value * _wickGlitch.value,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/wick_dark_v2.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            errorBuilder: (_, _, _) => Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF011821), kDarkBg],
                ),
              ),
            ),
          ),
          // Teal/cyan tint overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  kCyan.withValues(alpha: 0.08),
                  Colors.transparent,
                  kDarkBg.withValues(alpha: 0.75),
                ],
                stops: const [0.0, 0.50, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── 2. Scanlines overlay ────────────────────────────────────
  Widget _buildScanlines() {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(
          painter: _ScanlinesPainter(opacity: (_wickReveal.value * 0.18).clamp(0.0, 0.18)),
        ),
      ),
    );
  }

  // ── 3. DARK text ────────────────────────────────────────────
  Widget _buildDarkText() {
    return Positioned(
      bottom: 110 + _darkTextSlide.value,
      left: 0,
      right: 0,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Glow layer
            if (_darkTextGlow.value > 0.01)
              Text(
                'BRITAIN APPLE',
                style: TextStyle(
                  fontFamily: 'Rajdhani',
                  fontSize: 52,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 10,
                  color: kCyan.withValues(alpha: 0.0),
                  shadows: [
                    Shadow(
                      color: kGlowCyan.withValues(alpha: 0.9 * _darkTextGlow.value),
                      blurRadius: 40,
                    ),
                    Shadow(
                      color: kCyan.withValues(alpha: 0.7 * _darkTextGlow.value),
                      blurRadius: 80,
                    ),
                  ],
                ),
              ),
            // Main text
            ShaderMask(
              shaderCallback: (rect) => const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [kGlowCyan, kCyan, kNeonGold, kCyan],
                stops: [0.0, 0.4, 0.6, 1.0],
              ).createShader(rect),
              child: const Text(
                'BRITAIN APPLE',
                style: TextStyle(
                  fontFamily: 'Rajdhani',
                  fontSize: 52,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── 4. Cyan horizontal slash ────────────────────────────────
  Widget _buildCyanSlash() {
    return LayoutBuilder(builder: (context, c) {
      final w = c.maxWidth;
      final h = c.maxHeight;
      return Positioned(
        top: h * 0.42,
        left: 0,
        child: Opacity(
          opacity: _slashFade.value.clamp(0.0, 1.0),
          child: Container(
            width: w * _slashProgress.value,
            height: 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  kGlowCyan,
                  Colors.white,
                  kGlowCyan,
                  Colors.transparent,
                ],
                stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
              ),
              boxShadow: [
                BoxShadow(color: kGlowCyan.withValues(alpha: 0.8), blurRadius: 18, spreadRadius: 4),
                BoxShadow(color: kCyan.withValues(alpha: 0.4), blurRadius: 40, spreadRadius: 8),
              ],
            ),
          ),
        ),
      );
    });
  }

  // ── 5. Cyber Apple ──────────────────────────────────────────
  Widget _buildCyberApple() {
    return LayoutBuilder(builder: (context, c) {
      final cx = c.maxWidth * 0.50;
      final cy = c.maxHeight * 0.40;
      const sz = 210.0;

      return Positioned(
        left: cx - sz,
        top: cy - sz,
        child: Opacity(
          opacity: _appleAppear.value.clamp(0.0, 1.0),
          child: SizedBox(
            width: sz * 2,
            height: sz * 2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Teal glow halo
                if (_appleGlow.value > 0.01)
                  Container(
                    width: 200 * _appleAppear.value,
                    height: 200 * _appleAppear.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: kGlowCyan.withValues(alpha: 0.50 * _appleGlow.value),
                          blurRadius: 80,
                          spreadRadius: 20,
                        ),
                        BoxShadow(
                          color: kNeonGold.withValues(alpha: 0.30 * _appleGlow.value),
                          blurRadius: 50,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),

                // Light beam when splitting
                if (_appleSplit.value > 0.05)
                  Opacity(
                    opacity: (_appleSplit.value * 1.2).clamp(0.0, 1.0),
                    child: CustomPaint(
                      size: const Size(sz * 2, sz * 2),
                      painter: _CyberRaysPainter(split: _appleSplit.value),
                    ),
                  ),

                // The cyber apple
                Transform.scale(
                  scale: _appleAppear.value,
                  child: CustomPaint(
                    size: const Size(210, 210),
                    painter: _CyberApplePainter(split: _appleSplit.value),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // ── 6. Victory text ─────────────────────────────────────────
  Widget _buildVictoryText() {
    final t = _victoryReveal.value;
    return Positioned(
      bottom: 30,
      left: 16,
      right: 16,
      child: Opacity(
        opacity: t.clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(0, 30 * (1 - t)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: kGlowCyan.withValues(alpha: 0.7 * t), width: 1.5),
                bottom: BorderSide(color: kGlowCyan.withValues(alpha: 0.7 * t), width: 1.5),
              ),
              gradient: LinearGradient(
                colors: [
                  kDarkBg.withValues(alpha: 0.92),
                  const Color(0xFF011820).withValues(alpha: 0.88),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: kGlowCyan.withValues(alpha: 0.25 * t),
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Cyan line
                Container(
                  width: 80,
                  height: 1.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, kGlowCyan, Colors.transparent],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'أنت الآن في حضرة الفوز',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: arabic(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.5,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 24, height: 1, color: kGlowCyan.withValues(alpha: 0.6)),
                    const SizedBox(width: 8),
                    Text(
                      'BRITAIN APPLE',
                      style: latin(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: kGlowCyan,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(width: 24, height: 1, color: kGlowCyan.withValues(alpha: 0.6)),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: 80,
                  height: 1.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, kGlowCyan, Colors.transparent],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── 7. Corner accents ────────────────────────────────────────
  Widget _buildCornerAccents() {
    final opacity = (_wickReveal.value * 0.9).clamp(0.0, 0.9);
    return Positioned.fill(
      child: IgnorePointer(
        child: Opacity(
          opacity: opacity,
          child: CustomPaint(painter: _CornerAccentsPainter()),
        ),
      ),
    );
  }

  // ── 8. Skip ──────────────────────────────────────────────────
  Widget _buildSkip() {
    return Positioned(
      top: MediaQuery.paddingOf(context).top + 12,
      right: 16,
      child: GestureDetector(
        onTap: _finish,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: kDarkBg.withValues(alpha: 0.70),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: kGlowCyan.withValues(alpha: 0.45), width: 1.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'تخطي',
                style: arabic(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: kGlowCyan.withValues(alpha: 0.90),
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.skip_next_rounded, size: 15, color: kGlowCyan.withValues(alpha: 0.90)),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// PAINTERS
// ════════════════════════════════════════════════════════════════

// ── Matrix Rain ─────────────────────────────────────────────────
class _MatrixRainPainter extends CustomPainter {
  final double progress;
  const _MatrixRainPainter({required this.progress});

  static final _chars = '01ABCDEFGXYZ0110#@!%*';


  @override
  void paint(Canvas canvas, Size size) {
    final rand = math.Random(7);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    const colW = 18.0;
    final cols = (size.width / colW).ceil();

    for (int col = 0; col < cols; col++) {
      final x = col * colW;
      final speed = 0.3 + rand.nextDouble() * 0.5;
      final offset = rand.nextDouble();
      final rows = 18 + rand.nextInt(10);

      for (int row = 0; row < rows; row++) {
        final charRand = math.Random(col * 100 + row + (progress * 20).toInt());
        final ch = _chars[charRand.nextInt(_chars.length)];
        final y = ((offset + progress * speed + row / rows) % 1.0) * size.height;

        final alpha = (1.0 - row / rows) * 0.85;
        final isHead = row == 0;

        textPainter.text = TextSpan(
          text: ch,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isHead ? FontWeight.w900 : FontWeight.w400,
            color: isHead
                ? Colors.white.withValues(alpha: alpha)
                : kGlowCyan.withValues(alpha: alpha * 0.7),
          ),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(x, y));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _MatrixRainPainter o) => o.progress != progress;
}

// ── Scanlines ───────────────────────────────────────────────────
class _ScanlinesPainter extends CustomPainter {
  final double opacity;
  const _ScanlinesPainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: opacity)
      ..strokeWidth = 1.0;
    for (double y = 0; y < size.height; y += 3) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ScanlinesPainter o) => o.opacity != opacity;
}

// ── Cyber Apple (Teal/Cyan styled) ──────────────────────────────
class _CyberApplePainter extends CustomPainter {
  final double split;
  const _CyberApplePainter({required this.split});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2 + 10;
    final sep = split * 52.0;
    final tilt = split * 0.10;

    // ── LEFT HALF ──
    canvas.save();
    canvas.translate(cx - sep, cy);
    canvas.rotate(-tilt);
    canvas.translate(-cx, -cy);

    final lPath = Path()
      ..moveTo(cx, cy - h * 0.40)
      ..cubicTo(cx - w * 0.44, cy - h * 0.40, cx - w * 0.50, cy - h * 0.05, cx - w * 0.47, cy + h * 0.16)
      ..cubicTo(cx - w * 0.44, cy + h * 0.40, cx - w * 0.10, cy + h * 0.47, cx, cy + h * 0.47)
      ..lineTo(cx, cy - h * 0.40)
      ..close();

    // Teal-black gradient skin
    canvas.drawPath(
      lPath,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.30, -0.30),
          radius: 0.90,
          colors: const [Color(0xFF00BCD4), Color(0xFF006064), Color(0xFF002029)],
          stops: [0.0, 0.50, 1.0],
        ).createShader(Rect.fromLTWH(cx - w * 0.5, cy - h * 0.5, w * 0.5, h)),
    );

    // Shine
    canvas.drawPath(
      Path()
        ..moveTo(cx - w * 0.18, cy - h * 0.30)
        ..cubicTo(cx - w * 0.32, cy - h * 0.22, cx - w * 0.35, cy - h * 0.06, cx - w * 0.28, cy + h * 0.08),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.55)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.5
        ..strokeCap = StrokeCap.round,
    );

    // Inner flesh (golden/neon)
    if (split > 0.05) {
      final fo = (split * 2.2).clamp(0.0, 1.0);
      canvas.drawPath(
        Path()
          ..moveTo(cx - 3, cy - h * 0.38)
          ..lineTo(cx, cy - h * 0.38)
          ..lineTo(cx, cy + h * 0.44)
          ..lineTo(cx - 3, cy + h * 0.44)
          ..close(),
        Paint()
          ..shader = LinearGradient(
            colors: [
              kNeonGold.withValues(alpha: 0.95 * fo),
              kGlowCyan.withValues(alpha: 0.80 * fo),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(Rect.fromLTWH(cx - 3, cy - h * 0.38, 3, h * 0.82)),
      );
      // Seed
      canvas.drawOval(
        Rect.fromCenter(center: Offset(cx - 5, cy + 5), width: 6, height: 10),
        Paint()..color = const Color(0xFF001F2E).withValues(alpha: fo),
      );
    }
    canvas.restore();

    // ── RIGHT HALF ──
    canvas.save();
    canvas.translate(cx + sep, cy);
    canvas.rotate(tilt);
    canvas.translate(-cx, -cy);

    final rPath = Path()
      ..moveTo(cx, cy - h * 0.40)
      ..cubicTo(cx + w * 0.44, cy - h * 0.40, cx + w * 0.50, cy - h * 0.05, cx + w * 0.47, cy + h * 0.16)
      ..cubicTo(cx + w * 0.44, cy + h * 0.40, cx + w * 0.10, cy + h * 0.47, cx, cy + h * 0.47)
      ..lineTo(cx, cy - h * 0.40)
      ..close();

    canvas.drawPath(
      rPath,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(0.12, -0.30),
          radius: 0.90,
          colors: const [Color(0xFF00ACC1), Color(0xFF004D5E), Color(0xFF001520)],
          stops: [0.0, 0.50, 1.0],
        ).createShader(Rect.fromLTWH(cx, cy - h * 0.5, w * 0.5, h)),
    );

    // Inner flesh right
    if (split > 0.05) {
      final fo = (split * 2.2).clamp(0.0, 1.0);
      canvas.drawPath(
        Path()
          ..moveTo(cx, cy - h * 0.38)
          ..lineTo(cx + 3, cy - h * 0.38)
          ..lineTo(cx + 3, cy + h * 0.44)
          ..lineTo(cx, cy + h * 0.44)
          ..close(),
        Paint()
          ..shader = LinearGradient(
            colors: [
              kGlowCyan.withValues(alpha: 0.80 * fo),
              kNeonGold.withValues(alpha: 0.95 * fo),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(Rect.fromLTWH(cx, cy - h * 0.38, 3, h * 0.82)),
      );
      // Seed
      canvas.drawOval(
        Rect.fromCenter(center: Offset(cx + 5, cy + 5), width: 6, height: 10),
        Paint()..color = const Color(0xFF001F2E).withValues(alpha: fo),
      );
    }

    // Leaf — teal colored
    canvas.drawPath(
      Path()
        ..moveTo(cx + 2, cy - h * 0.48)
        ..cubicTo(cx + w * 0.20, cy - h * 0.58, cx + w * 0.24, cy - h * 0.40, cx + 6, cy - h * 0.44)
        ..close(),
      Paint()
        ..shader = const LinearGradient(
          colors: [kGlowCyan, Color(0xFF004D5E)],
        ).createShader(Rect.fromLTWH(cx, cy - h * 0.58, w * 0.24, h * 0.18)),
    );

    // Stem
    canvas.drawPath(
      Path()
        ..moveTo(cx - 1, cy - h * 0.38)
        ..cubicTo(cx + 3, cy - h * 0.53, cx + 8, cy - h * 0.55, cx + 10, cy - h * 0.51),
      Paint()
        ..color = const Color(0xFF003444)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CyberApplePainter o) => o.split != split;
}

// ── Cyber Rays ───────────────────────────────────────────────────
class _CyberRaysPainter extends CustomPainter {
  final double split;
  const _CyberRaysPainter({required this.split});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2 + 10;
    final bw = 10.0 + split * 28.0;

    // Central light beam (cyan)
    canvas.drawRect(
      Rect.fromLTWH(cx - bw / 2, cy - 130, bw, 260),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.transparent,
            kGlowCyan.withValues(alpha: 0.85),
            Colors.white,
            kGlowCyan.withValues(alpha: 0.85),
            Colors.transparent,
          ],
          stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
        ).createShader(Rect.fromLTWH(cx - bw / 2, cy - 130, bw, 260)),
    );

    // Rays
    for (int i = 0; i < 12; i++) {
      final angle = (i * math.pi / 6) + (split * 0.5);
      final len = 55.0 + split * 75.0;
      canvas.drawLine(
        Offset(cx, cy),
        Offset(cx + math.cos(angle) * len, cy + math.sin(angle) * len),
        Paint()
          ..color = kGlowCyan.withValues(alpha: 0.35 * split)
          ..strokeWidth = 1.5,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CyberRaysPainter o) => o.split != split;
}

// ── Corner Accents ───────────────────────────────────────────────
class _CornerAccentsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kGlowCyan.withValues(alpha: 0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.square;

    const len = 30.0;

    // Top-left
    canvas.drawLine(const Offset(16, 16), const Offset(16 + len, 16), paint);
    canvas.drawLine(const Offset(16, 16), const Offset(16, 16 + len), paint);

    // Top-right
    canvas.drawLine(Offset(size.width - 16, 16), Offset(size.width - 16 - len, 16), paint);
    canvas.drawLine(Offset(size.width - 16, 16), Offset(size.width - 16, 16 + len), paint);

    // Bottom-left
    canvas.drawLine(Offset(16, size.height - 16), Offset(16 + len, size.height - 16), paint);
    canvas.drawLine(Offset(16, size.height - 16), Offset(16, size.height - 16 - len), paint);

    // Bottom-right
    canvas.drawLine(Offset(size.width - 16, size.height - 16), Offset(size.width - 16 - len, size.height - 16), paint);
    canvas.drawLine(Offset(size.width - 16, size.height - 16), Offset(size.width - 16, size.height - 16 - len), paint);
  }

  @override
  bool shouldRepaint(covariant _CornerAccentsPainter o) => false;
}
