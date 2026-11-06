import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../widgets/noir_theme.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const SplashScreen({super.key, required this.onComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _masterController;

  // 1. John Wick fade + subtle zoom
  late final Animation<double> _wickFade;
  late final Animation<double> _wickZoom;

  // 2. Muzzle flash + screen shake
  late final Animation<double> _muzzleFlash;
  late final Animation<double> _screenShake;

  // 3. Bullet flight (fast)
  late final Animation<double> _bulletFlight;
  late final Animation<double> _bulletOpacity;

  // 4. Morph burst
  late final Animation<double> _morphBurst;

  // 5. Apple appear + grow
  late final Animation<double> _appleAppear; // 0->1 fade in
  late final Animation<double> _appleGrowth; // scale
  late final Animation<double> _appleSplit;  // 0->1 split open
  late final Animation<double> _coreLightBeam;

  // 6. Text
  late final Animation<double> _textFade;
  late final Animation<double> _textScale;

  // 7. Exit
  late final Animation<double> _exitFade;

  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();

    // Total: 4 seconds
    _masterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    // === 1. John Wick enters (0.0 → 0.20) = 0 - 0.8s ===
    _wickFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.00, 0.18, curve: Curves.easeIn),
      ),
    );
    _wickZoom = Tween<double>(begin: 1.05, end: 1.12).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.00, 0.55, curve: Curves.easeOut),
      ),
    );

    // === 2. Gunshot (0.18 → 0.30) = 0.72s - 1.2s ===
    _muzzleFlash = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 75),
    ]).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.18, 0.28, curve: Curves.fastOutSlowIn),
      ),
    );

    _screenShake = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 8.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -5.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: -5.0, end: 3.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 3.0, end: 0.0), weight: 20),
    ]).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.18, 0.30, curve: Curves.linear),
      ),
    );

    // === 3. Bullet (0.20 → 0.38) = 0.8s - 1.52s ===
    _bulletFlight = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.20, 0.38, curve: Curves.easeOutExpo),
      ),
    );
    _bulletOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 15),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 65),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 20),
    ]).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.20, 0.42, curve: Curves.linear),
      ),
    );

    // === 4. Morph burst (0.36 → 0.46) = 1.44s - 1.84s ===
    _morphBurst = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 35),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 65),
    ]).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.36, 0.50, curve: Curves.easeOut),
      ),
    );

    // === 5. Apple appear + grow (0.40 → 0.62) = 1.6s - 2.48s ===
    _appleAppear = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.40, 0.55, curve: Curves.easeOut),
      ),
    );
    _appleGrowth = Tween<double>(begin: 0.5, end: 1.6).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.40, 0.60, curve: Curves.easeOutBack),
      ),
    );

    // === 6. Apple splits (0.58 → 0.78) = 2.32s - 3.12s ===
    _appleSplit = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.58, 0.80, curve: Curves.easeInOutCubic),
      ),
    );
    _coreLightBeam = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.60, 0.82, curve: Curves.easeOutCubic),
      ),
    );

    // === 7. Text (0.72 → 0.88) = 2.88s - 3.52s ===
    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.72, 0.85, curve: Curves.easeIn),
      ),
    );
    _textScale = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.72, 0.88, curve: Curves.elasticOut),
      ),
    );

    // === 8. Exit fade (0.90 → 1.0) = 3.6s - 4.0s ===
    _exitFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.90, 1.00, curve: Curves.easeOut),
      ),
    );

    _masterController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _finishSplash();
      }
    });

    _masterController.forward();
  }

  void _finishSplash() {
    if (_isNavigating || !mounted) return;
    _isNavigating = true;
    widget.onComplete();
  }

  @override
  void dispose() {
    _masterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _masterController,
      builder: (context, _) {
        final shake = _screenShake.value;

        return Transform.translate(
          offset: Offset(shake, shake * 0.4),
          child: Opacity(
            opacity: _exitFade.value.clamp(0.0, 1.0),
            child: Scaffold(
              backgroundColor: const Color(0xFF040206),
              body: Stack(
                fit: StackFit.expand,
                children: [
                  // 1. John Wick cinematic background
                  _buildWickBackground(),

                  // 2. Muzzle flash
                  if (_muzzleFlash.value > 0.01) _buildMuzzleFlash(),

                  // 3. Bullet in flight
                  if (_bulletOpacity.value > 0.01) _buildBullet(),

                  // 4. Morph burst at impact
                  if (_morphBurst.value > 0.01) _buildMorphBurst(),

                  // 5. The apple (always visible once appear > 0)
                  if (_appleAppear.value > 0.01) _buildApple(),

                  // 6. Victory text
                  if (_textFade.value > 0.01) _buildVictoryText(),

                  // 7. Skip button
                  _buildSkipButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ═══════════════════════════════════════════════════
  // 1. John Wick Background
  // ═══════════════════════════════════════════════════
  Widget _buildWickBackground() {
    return Opacity(
      opacity: _wickFade.value,
      child: Transform.scale(
        scale: _wickZoom.value,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/john_wick_splash.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (_, _, _) => Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [Color(0xFF1E0A28), Color(0xFF050208)],
                  ),
                ),
              ),
            ),
            // Dark cinematic vignette
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.1,
                  colors: [
                    Colors.black.withValues(alpha: 0.10),
                    Colors.black.withValues(alpha: 0.65),
                    const Color(0xFF040206),
                  ],
                  stops: const [0.3, 0.75, 1.0],
                ),
              ),
            ),
            // Top/bottom dark bars
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.60),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.80),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
            // Atmospheric rain
            CustomPaint(
              painter: _AtmosphericRainPainter(
                progress: _masterController.value,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════
  // 2. Muzzle Flash
  // ═══════════════════════════════════════════════════
  Widget _buildMuzzleFlash() {
    final i = _muzzleFlash.value;
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: Colors.white.withValues(alpha: 0.70 * i)),
            Center(
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white,
                      const Color(0xFFFFB300).withValues(alpha: 0.9 * i),
                      const Color(0xFFFF3D00).withValues(alpha: 0.5 * i),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.3, 0.65, 1.0],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════
  // 3. Bullet
  // ═══════════════════════════════════════════════════
  Widget _buildBullet() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenW = constraints.maxWidth;
        final screenH = constraints.maxHeight;

        final startX = screenW * 0.52;
        final startY = screenH * 0.36;
        final targetX = screenW * 0.50;
        final targetY = screenH * 0.44;

        final t = _bulletFlight.value;
        final currentX = startX + (targetX - startX) * t;
        final currentY = startY + (targetY - startY) * t;
        // Fast rotation - 2 full spins
        final angle = t * math.pi * 4.0;

        return Positioned(
          left: currentX - 50,
          top: currentY - 50,
          child: Opacity(
            opacity: _bulletOpacity.value.clamp(0.0, 1.0),
            child: Transform.rotate(
              angle: angle,
              child: const SizedBox(
                width: 100,
                height: 100,
                child: CustomPaint(painter: _BulletPainter(glowIntensity: 1.0)),
              ),
            ),
          ),
        );
      },
    );
  }

  // ═══════════════════════════════════════════════════
  // 4. Morph Burst
  // ═══════════════════════════════════════════════════
  Widget _buildMorphBurst() {
    final i = _morphBurst.value;
    return Center(
      child: Container(
        width: 380,
        height: 380,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Colors.white.withValues(alpha: 0.95 * i),
              const Color(0xFFFF5722).withValues(alpha: 0.80 * i),
              const Color(0xFFD50000).withValues(alpha: 0.45 * i),
              Colors.transparent,
            ],
            stops: const [0.0, 0.3, 0.65, 1.0],
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════
  // 5. Apple — LARGE, centered, always visible once triggered
  // ═══════════════════════════════════════════════════
  Widget _buildApple() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenW = constraints.maxWidth;
        final screenH = constraints.maxHeight;

        // Apple centered at 42% height
        final centerX = screenW * 0.50;
        final centerY = screenH * 0.40;

        final scale = _appleGrowth.value;
        final opacity = _appleAppear.value.clamp(0.0, 1.0);
        final split = _appleSplit.value;
        final beam = _coreLightBeam.value;

        // Base size of the apple canvas
        const baseSize = 220.0;

        return Positioned(
          left: centerX - baseSize,
          top: centerY - baseSize,
          child: Opacity(
            opacity: opacity,
            child: SizedBox(
              width: baseSize * 2,
              height: baseSize * 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Glow behind apple
                  Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF1744)
                                .withValues(alpha: (0.55 * opacity).clamp(0.0, 0.7)),
                            blurRadius: 70,
                            spreadRadius: 15,
                          ),
                          BoxShadow(
                            color: kOrangePrimary
                                .withValues(alpha: (0.40 * opacity).clamp(0.0, 0.6)),
                            blurRadius: 90,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Divine light rays when splitting
                  if (beam > 0.05)
                    Opacity(
                      opacity: beam.clamp(0.0, 1.0),
                      child: Transform.scale(
                        scale: scale * 1.15,
                        child: CustomPaint(
                          size: const Size(baseSize * 2, baseSize * 2),
                          painter: _CoreRaysPainter(splitProgress: split),
                        ),
                      ),
                    ),

                  // The split apple itself — big and clear
                  Transform.scale(
                    scale: scale,
                    child: CustomPaint(
                      size: const Size(200, 200),
                      painter: _SplitApplePainter(
                        splitProgress: split,
                        morphProgress: 1.0, // always fully morphed
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ═══════════════════════════════════════════════════
  // 6. Victory Text
  // ═══════════════════════════════════════════════════
  Widget _buildVictoryText() {
    return Positioned(
      bottom: 80,
      left: 20,
      right: 20,
      child: Opacity(
        opacity: _textFade.value.clamp(0.0, 1.0),
        child: Transform.scale(
          scale: _textScale.value,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 140,
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.amberAccent,
                      kOrangeLight,
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.4, 0.6, 1.0],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black.withValues(alpha: 0.88),
                      const Color(0xFF140410).withValues(alpha: 0.92),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: Colors.amberAccent.withValues(alpha: 0.70),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amberAccent.withValues(alpha: 0.30),
                      blurRadius: 28,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: kOrangePrimary.withValues(alpha: 0.40),
                      blurRadius: 44,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'أنت الآن في حضرة الفوز',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: arabic(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.5,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.amberAccent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amberAccent,
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'DARK TOOLS VIP • وصول معتمد',
                          style: latin(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: kOrangeLight,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.amberAccent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amberAccent,
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: 140,
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      kOrangeLight,
                      Colors.amberAccent,
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.4, 0.6, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════
  // 7. Skip Button
  // ═══════════════════════════════════════════════════
  Widget _buildSkipButton() {
    return Positioned(
      top: MediaQuery.paddingOf(context).top + 12,
      left: 16,
      child: GestureDetector(
        onTap: _finishSplash,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.35),
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'تخطي',
                style: arabic(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withValues(alpha: 0.90),
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.skip_next_rounded,
                size: 16,
                color: Colors.white.withValues(alpha: 0.90),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Bullet Painter
// ═══════════════════════════════════════════════════════════
class _BulletPainter extends CustomPainter {
  final double glowIntensity;

  const _BulletPainter({required this.glowIntensity});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Glow
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFD54F).withValues(alpha: 0.85 * glowIntensity),
          const Color(0xFFFF6D00).withValues(alpha: 0.4 * glowIntensity),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: 42));
    canvas.drawCircle(Offset(cx, cy), 42, glowPaint);

    // Bullet body
    final bulletPath = Path();
    bulletPath.moveTo(cx, cy - 28);
    bulletPath.cubicTo(cx + 10, cy - 20, cx + 11, cy - 8, cx + 11, cy);
    bulletPath.lineTo(cx + 11, cy + 22);
    bulletPath.lineTo(cx - 11, cy + 22);
    bulletPath.lineTo(cx - 11, cy);
    bulletPath.cubicTo(cx - 11, cy - 8, cx - 10, cy - 20, cx, cy - 28);
    bulletPath.close();

    final bulletShader = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: const [
        Color(0xFFB7791F),
        Color(0xFFECC94B),
        Color(0xFFFFFBEB),
        Color(0xFFD69E2E),
        Color(0xFF744210),
      ],
      stops: const [0.0, 0.35, 0.55, 0.75, 1.0],
    ).createShader(Rect.fromLTWH(cx - 11, cy - 28, 22, 52));

    canvas.drawPath(bulletPath, Paint()..shader = bulletShader);

    // Groove
    canvas.drawLine(
      Offset(cx - 10, cy + 17),
      Offset(cx + 10, cy + 17),
      Paint()
        ..color = const Color(0xFF5B3008)
        ..strokeWidth = 2.0,
    );

    // Tip sparkle
    canvas.drawCircle(
      Offset(cx, cy - 27),
      3.0,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant _BulletPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════
// Split Apple Painter — large clear halves
// ═══════════════════════════════════════════════════════════
class _SplitApplePainter extends CustomPainter {
  final double splitProgress;
  final double morphProgress;

  const _SplitApplePainter({
    required this.splitProgress,
    required this.morphProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2 + 8;

    // Max separation at full split
    final separation = splitProgress * 55.0;
    final tilt = splitProgress * 0.12;

    // ── LEFT HALF ──
    canvas.save();
    canvas.translate(cx - separation, cy);
    canvas.rotate(-tilt);
    canvas.translate(-cx, -cy);

    final leftPath = Path();
    leftPath.moveTo(cx, cy - h * 0.40);
    leftPath.cubicTo(
      cx - w * 0.44, cy - h * 0.40,
      cx - w * 0.50, cy - h * 0.05,
      cx - w * 0.47, cy + h * 0.16,
    );
    leftPath.cubicTo(
      cx - w * 0.44, cy + h * 0.40,
      cx - w * 0.10, cy + h * 0.47,
      cx, cy + h * 0.47,
    );
    leftPath.lineTo(cx, cy - h * 0.40);
    leftPath.close();

    // Red skin gradient
    canvas.drawPath(
      leftPath,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.30, -0.35),
          radius: 0.92,
          colors: const [
            Color(0xFFFF4444),
            Color(0xFFCC0000),
            Color(0xFF6E0000),
          ],
          stops: [0.0, 0.55, 1.0],
        ).createShader(Rect.fromLTWH(cx - w * 0.5, cy - h * 0.5, w * 0.5, h)),
    );

    // Shine on left
    canvas.drawPath(
      Path()
        ..moveTo(cx - w * 0.20, cy - h * 0.30)
        ..cubicTo(
          cx - w * 0.33, cy - h * 0.23,
          cx - w * 0.37, cy - h * 0.06,
          cx - w * 0.29, cy + h * 0.09,
        ),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.50)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5.0
        ..strokeCap = StrokeCap.round,
    );

    // Inner flesh + seed
    if (splitProgress > 0.04) {
      final fleshOpacity = (splitProgress * 2.0).clamp(0.0, 1.0);
      final fleshShader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          const Color(0xFFFFF8DC).withValues(alpha: 0.95 * fleshOpacity),
          const Color(0xFFFFE4B5).withValues(alpha: fleshOpacity),
        ],
      ).createShader(Rect.fromLTWH(cx - 18, cy - h * 0.38, 18, h * 0.75));

      canvas.drawPath(
        Path()
          ..moveTo(cx - 3, cy - h * 0.38)
          ..lineTo(cx, cy - h * 0.38)
          ..lineTo(cx, cy + h * 0.44)
          ..lineTo(cx - 3, cy + h * 0.44)
          ..close(),
        Paint()..shader = fleshShader,
      );

      // Seed
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(cx - 5, cy + 5),
          width: 6,
          height: 11,
        ),
        Paint()
          ..color =
              const Color(0xFF3E1F00).withValues(alpha: fleshOpacity),
      );
    }

    canvas.restore();

    // ── RIGHT HALF ──
    canvas.save();
    canvas.translate(cx + separation, cy);
    canvas.rotate(tilt);
    canvas.translate(-cx, -cy);

    final rightPath = Path();
    rightPath.moveTo(cx, cy - h * 0.40);
    rightPath.cubicTo(
      cx + w * 0.44, cy - h * 0.40,
      cx + w * 0.50, cy - h * 0.05,
      cx + w * 0.47, cy + h * 0.16,
    );
    rightPath.cubicTo(
      cx + w * 0.44, cy + h * 0.40,
      cx + w * 0.10, cy + h * 0.47,
      cx, cy + h * 0.47,
    );
    rightPath.lineTo(cx, cy - h * 0.40);
    rightPath.close();

    canvas.drawPath(
      rightPath,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(0.12, -0.35),
          radius: 0.92,
          colors: const [
            Color(0xFFFF3333),
            Color(0xFFBB0000),
            Color(0xFF5A0000),
          ],
          stops: [0.0, 0.55, 1.0],
        ).createShader(Rect.fromLTWH(cx, cy - h * 0.5, w * 0.5, h)),
    );

    // Inner flesh right + seed
    if (splitProgress > 0.04) {
      final fleshOpacity = (splitProgress * 2.0).clamp(0.0, 1.0);
      final fleshShader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          const Color(0xFFFFE4B5).withValues(alpha: fleshOpacity),
          const Color(0xFFFFF8DC).withValues(alpha: 0.95 * fleshOpacity),
        ],
      ).createShader(Rect.fromLTWH(cx, cy - h * 0.38, 18, h * 0.75));

      canvas.drawPath(
        Path()
          ..moveTo(cx, cy - h * 0.38)
          ..lineTo(cx + 3, cy - h * 0.38)
          ..lineTo(cx + 3, cy + h * 0.44)
          ..lineTo(cx, cy + h * 0.44)
          ..close(),
        Paint()..shader = fleshShader,
      );

      // Seed right
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(cx + 5, cy + 5),
          width: 6,
          height: 11,
        ),
        Paint()
          ..color =
              const Color(0xFF3E1F00).withValues(alpha: fleshOpacity),
      );
    }

    // Leaf on right half
    final leafPath = Path();
    leafPath.moveTo(cx + 2, cy - h * 0.48);
    leafPath.cubicTo(
      cx + w * 0.20, cy - h * 0.57,
      cx + w * 0.24, cy - h * 0.40,
      cx + 6, cy - h * 0.44,
    );
    leafPath.close();
    canvas.drawPath(
      leafPath,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFF4CAF50), Color(0xFF1B5E20)],
        ).createShader(Rect.fromLTWH(cx, cy - h * 0.57, w * 0.24, h * 0.17)),
    );

    // Stem
    canvas.drawPath(
      Path()
        ..moveTo(cx - 1, cy - h * 0.38)
        ..cubicTo(
          cx + 3, cy - h * 0.53,
          cx + 8, cy - h * 0.55,
          cx + 10, cy - h * 0.51,
        ),
      Paint()
        ..color = const Color(0xFF4E2606)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _SplitApplePainter oldDelegate) =>
      oldDelegate.splitProgress != splitProgress ||
      oldDelegate.morphProgress != morphProgress;
}

// ═══════════════════════════════════════════════════════════
// Core Rays Painter
// ═══════════════════════════════════════════════════════════
class _CoreRaysPainter extends CustomPainter {
  final double splitProgress;

  const _CoreRaysPainter({required this.splitProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2 + 8;

    // Central beam
    final beamWidth = 12.0 + (splitProgress * 30.0);
    final beamShader = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Colors.transparent,
        Colors.amberAccent.withValues(alpha: 0.80),
        Colors.white,
        Colors.amberAccent.withValues(alpha: 0.80),
        Colors.transparent,
      ],
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
    ).createShader(Rect.fromLTWH(cx - beamWidth / 2, cy - 120, beamWidth, 240));

    canvas.drawRect(
      Rect.fromLTWH(cx - beamWidth / 2, cy - 120, beamWidth, 240),
      Paint()..shader = beamShader,
    );

    // Radial rays
    final rayPaint = Paint()
      ..color = Colors.amberAccent.withValues(alpha: 0.40 * splitProgress)
      ..strokeWidth = 1.5;

    for (int i = 0; i < 14; i++) {
      final angle = (i * math.pi / 7) + (splitProgress * 0.3);
      final len = 60.0 + (splitProgress * 70.0);
      final x2 = cx + math.cos(angle) * len;
      final y2 = cy + math.sin(angle) * len;
      canvas.drawLine(Offset(cx, cy), Offset(x2, y2), rayPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CoreRaysPainter oldDelegate) =>
      oldDelegate.splitProgress != splitProgress;
}

// ═══════════════════════════════════════════════════════════
// Atmospheric Rain Painter
// ═══════════════════════════════════════════════════════════
class _AtmosphericRainPainter extends CustomPainter {
  final double progress;

  const _AtmosphericRainPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rainPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.10)
      ..strokeWidth = 1.0;

    final rand = math.Random(42);

    for (int i = 0; i < 40; i++) {
      final x = rand.nextDouble() * size.width;
      final yBase = rand.nextDouble() * size.height;
      final speed = 200.0 + rand.nextDouble() * 250.0;
      final y = (yBase + progress * speed) % size.height;
      final length = 10.0 + rand.nextDouble() * 18.0;

      canvas.drawLine(
        Offset(x, y),
        Offset(x - 2, y + length),
        rainPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _AtmosphericRainPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
