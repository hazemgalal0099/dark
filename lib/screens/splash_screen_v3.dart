import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../widgets/british_flag.dart';

// ╔═══════════════════════════════════════════════════════════════╗
// ║      SPLASH SCREEN — BRITAIN APPLE WINKING APPLE             ║
// ║   تفاحة تغمز بألوان لافندر وبنفسجي — 3 ثواني               ║
// ╚═══════════════════════════════════════════════════════════════╝

class SplashScreenV3 extends StatefulWidget {
  final VoidCallback onComplete;
  const SplashScreenV3({super.key, required this.onComplete});

  @override
  State<SplashScreenV3> createState() => _SplashScreenV3State();
}

class _SplashScreenV3State extends State<SplashScreenV3>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000), // 3 ثواني بالضبط
    );
    _progress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.linear),
    );
    _ctrl.addStatusListener((s) {
      if (s == AnimationStatus.completed) widget.onComplete();
    });
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progress,
      builder: (context, child) => Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: _WinkingAppleSplashPainter(_progress.value),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1A0A2E),
                    Color(0xFF2D1550),
                    Color(0xFF1A0A2E),
                  ],
                ),
              ),
            ),
          ),
          // علم بريطانيا في الزاوية العلوية اليسرى
          Positioned(
            top: MediaQuery.paddingOf(context).top + 14,
            left: 16,
            child: const BritishFlag(width: 54, height: 36, borderRadius: 5),
          ),
          // نص BRITAIN APPLE في المنتصف أسفل الشاشة
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'BRITAIN APPLE',
                    style: const TextStyle(
                      fontFamily: 'Rajdhani',
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 6,
                      color: Color(0xFFE8CEFF),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'بريطانيا التفاحة',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFB39DDB),
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WinkingAppleSplashPainter extends CustomPainter {
  final double t;
  _WinkingAppleSplashPainter(this.t);

  // ألوان لافندر وبنفسجي
  static const Color _lavender = Color(0xFFB39DDB);
  static const Color _purple = Color(0xFF7C4DC8);
  static const Color _lightLav = Color(0xFFE8CEFF);
  static const Color _deepPurple = Color(0xFF4A1E8A);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // مرحلة الغمزة — تحدث 3 مرات في 3 ثواني
    // t من 0 إلى 1
    final winkCycle = (t * 3.0) % 1.0; // دورة كل ثانية
    final isWinking = winkCycle > 0.65 && winkCycle < 0.85;

    // تلاشي في البداية والنهاية
    final fadeIn = (t / 0.1).clamp(0.0, 1.0);
    final fadeOut = t > 0.90 ? (1.0 - (t - 0.90) / 0.10).clamp(0.0, 1.0) : 1.0;
    final alpha = (fadeIn * fadeOut).clamp(0.0, 1.0);

    // نبضة التفاحة
    final pulse = 1.0 + 0.04 * math.sin(t * math.pi * 6);
    final appleSize = math.min(w * 0.38, 160.0) * pulse;

    // وهج لافندر خلفي
    final glowPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 0.7,
        colors: [
          _purple.withValues(alpha: 0.35 * alpha),
          _deepPurple.withValues(alpha: 0.15 * alpha),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), glowPaint);

    // رسم التفاحة في المركز
    final cx = w / 2;
    final cy = h * 0.42;

    canvas.save();
    canvas.translate(cx, cy);
    canvas.scale(appleSize / 100.0, appleSize / 100.0);

    _drawWinkingApple(canvas, isWinking, alpha);

    canvas.restore();

    // نجوم متطايرة حول التفاحة عند الغمزة
    if (isWinking) {
      final starProgress = ((winkCycle - 0.65) / 0.20).clamp(0.0, 1.0);
      _drawSparkles(canvas, cx, cy, appleSize * 0.8, starProgress * alpha);
    }

    // تلاشي في النهاية
    if (fadeOut < 1.0) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, w, h),
        Paint()
          ..color = const Color(0xFF1A0A2E).withValues(alpha: 1.0 - fadeOut),
      );
    }
  }

  void _drawWinkingApple(Canvas canvas, bool winking, double alpha) {
    final bodyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_lightLav, _lavender, _purple],
      ).createShader(const Rect.fromLTWH(-50, -50, 100, 110));

    // جسم التفاحة
    final body = Path()
      ..moveTo(50, 27)
      ..cubicTo(20, 10, 3, 35, 8, 62)
      ..cubicTo(12, 88, 32, 96, 50, 88)
      ..cubicTo(68, 96, 88, 86, 92, 61)
      ..cubicTo(97, 34, 78, 10, 50, 27)
      ..close();
    canvas.drawPath(body, bodyPaint);

    // بريق على التفاحة
    final shinePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.25 * alpha);
    final shine = Path()
      ..moveTo(28, 32)
      ..cubicTo(18, 38, 16, 50, 24, 56)
      ..cubicTo(28, 44, 30, 36, 28, 32)
      ..close();
    canvas.drawPath(shine, shinePaint);

    // ورقة وساق
    final leafPaint = Paint()
      ..color = _purple.withValues(alpha: 0.9 * alpha);
    final leaf = Path()
      ..moveTo(50, 27)
      ..cubicTo(50, 5, 76, 2, 81, 16)
      ..cubicTo(74, 27, 60, 30, 50, 27)
      ..close();
    canvas.drawPath(leaf, leafPaint);

    canvas.drawLine(
      const Offset(50, 27),
      const Offset(53, 12),
      Paint()
        ..color = _deepPurple.withValues(alpha: alpha)
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round,
    );

    // العينان — غمزة أو مفتوحة
    final eyePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.95 * alpha);

    if (winking) {
      // العين اليسرى مغلقة (غمزة) — خط مقوس
      final winkPath = Path()
        ..moveTo(30, 48)
        ..quadraticBezierTo(35, 44, 40, 48);
      canvas.drawPath(
        winkPath,
        Paint()
          ..color = Colors.white.withValues(alpha: alpha)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.5
          ..strokeCap = StrokeCap.round,
      );
      // العين اليمنى مفتوحة
      canvas.drawCircle(const Offset(65, 47), 4.5, eyePaint);
      canvas.drawCircle(
        const Offset(66, 46),
        1.5,
        Paint()..color = _deepPurple.withValues(alpha: alpha),
      );
    } else {
      // كلتا العينين مفتوحتان
      canvas.drawCircle(const Offset(35, 47), 4.5, eyePaint);
      canvas.drawCircle(const Offset(65, 47), 4.5, eyePaint);
      canvas.drawCircle(
        const Offset(36, 46),
        1.8,
        Paint()..color = _deepPurple.withValues(alpha: alpha),
      );
      canvas.drawCircle(
        const Offset(66, 46),
        1.8,
        Paint()..color = _deepPurple.withValues(alpha: alpha),
      );
    }

    // الابتسامة
    final smile = Path()
      ..moveTo(38, 63)
      ..quadraticBezierTo(50, 76, 62, 63);
    canvas.drawPath(
      smile,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.90 * alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round,
    );

    // الذراعان
    final armPaint = Paint()
      ..color = _lavender.withValues(alpha: 0.85 * alpha)
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    if (winking) {
      // ذراع تلوح
      canvas.drawLine(const Offset(12, 57), const Offset(-8, 32), armPaint);
      canvas.drawLine(const Offset(88, 57), const Offset(100, 60), armPaint);
    } else {
      canvas.drawLine(const Offset(12, 57), const Offset(-2, 60), armPaint);
      canvas.drawLine(const Offset(88, 57), const Offset(102, 60), armPaint);
    }

    // الساقان
    final legPaint = Paint()
      ..color = _lavender.withValues(alpha: 0.85 * alpha)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(38, 87), const Offset(32, 106), legPaint);
    canvas.drawLine(const Offset(62, 87), const Offset(68, 106), legPaint);
  }

  void _drawSparkles(Canvas canvas, double cx, double cy, double radius, double alpha) {
    final sparkPaint = Paint()
      ..color = _lightLav.withValues(alpha: alpha * 0.9)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 8; i++) {
      final angle = i * math.pi / 4 + 0.3;
      final dist = radius * (0.8 + 0.4 * alpha);
      final sx = cx + math.cos(angle) * dist;
      final sy = cy + math.sin(angle) * dist;
      final r = 5.0 + 3.0 * alpha;
      canvas.drawLine(Offset(sx - r, sy), Offset(sx + r, sy), sparkPaint);
      canvas.drawLine(Offset(sx, sy - r), Offset(sx, sy + r), sparkPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _WinkingAppleSplashPainter old) => old.t != t;
}
