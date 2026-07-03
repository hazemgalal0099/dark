import 'dart:math' as math;
import 'package:flutter/material.dart';

class JoeXLogo extends StatelessWidget {
  final bool showText;
  final double size;
  final bool drawBackground;

  const JoeXLogo({
    super.key,
    this.showText = true,
    this.size = 100,
    this.drawBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _JoeXLogoPainter(
          showText: showText,
          drawBackground: drawBackground,
        ),
      ),
    );
  }
}

class _JoeXLogoPainter extends CustomPainter {
  final bool showText;
  final bool drawBackground;

  _JoeXLogoPainter({
    required this.showText,
    required this.drawBackground,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = showText ? size.height * 0.38 : size.height * 0.5;
    final double r = showText ? size.height * 0.28 : size.height * 0.38;

    if (drawBackground) {
      final bgPaint = Paint()
        ..color = const Color(0xFF080808)
        ..style = PaintingStyle.fill;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(16),
        ),
        bgPaint,
      );
    }

    // ── 1. DRAW LEFT ROTATION HALF (Rotten) ─────────────────────────
    final leftPath = Path();
    leftPath.moveTo(cx, cy - 0.45 * r);
    // top-left lobe
    leftPath.cubicTo(
      cx - 0.25 * r, cy - 0.62 * r,
      cx - 0.55 * r, cy - 0.42 * r,
      cx - 0.52 * r, cy - 0.10 * r,
    );
    // bottom-left bump
    leftPath.cubicTo(
      cx - 0.48 * r, cy + 0.20 * r,
      cx - 0.35 * r, cy + 0.48 * r,
      cx - 0.15 * r, cy + 0.45 * r,
    );
    // bottom-middle indentation
    leftPath.cubicTo(
      cx - 0.08 * r, cy + 0.43 * r,
      cx, cy + 0.38 * r,
      cx, cy + 0.38 * r,
    );
    leftPath.lineTo(cx, cy - 0.45 * r);
    leftPath.close();

    final leftGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF2A2421), // Rotten dark brown-gray
        const Color(0xFF141211), // Corrupted deep gray
      ],
    );

    final leftPaint = Paint()
      ..shader = leftGradient.createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r))
      ..style = PaintingStyle.fill;
    canvas.drawPath(leftPath, leftPaint);

    // Draw some glitch/corrupted rectangles on the rotten side
    final glitchPaint = Paint()
      ..color = const Color(0xFF3E3530).withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;
    
    final math.Random random = math.Random(42); // Seeded for consistent look
    for (int i = 0; i < 6; i++) {
      final double gx = cx - (random.nextDouble() * 0.45 * r) - 0.05 * r;
      final double gy = cy - 0.35 * r + (random.nextDouble() * 0.75 * r);
      final double gw = 4 + random.nextDouble() * 8;
      final double gh = 2 + random.nextDouble() * 5;
      canvas.drawRect(Rect.fromLTWH(gx, gy, gw, gh), glitchPaint);
    }

    // ── 2. DRAW RIGHT GOLDEN HALF (Winning) ─────────────────────────
    final rightPath = Path();
    rightPath.moveTo(cx, cy - 0.45 * r);
    // top-right lobe
    rightPath.cubicTo(
      cx + 0.25 * r, cy - 0.62 * r,
      cx + 0.55 * r, cy - 0.42 * r,
      cx + 0.52 * r, cy - 0.10 * r,
    );
    // bottom-right bump
    rightPath.cubicTo(
      cx + 0.48 * r, cy + 0.20 * r,
      cx + 0.35 * r, cy + 0.48 * r,
      cx + 0.15 * r, cy + 0.45 * r,
    );
    // bottom-middle indentation
    rightPath.cubicTo(
      cx + 0.08 * r, cy + 0.43 * r,
      cx, cy + 0.38 * r,
      cx, cy + 0.38 * r,
    );
    rightPath.lineTo(cx, cy - 0.45 * r);
    rightPath.close();

    final goldGradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        const Color(0xFFFFD700), // Rich gold
        const Color(0xFFF5C542), // Winning gold
        const Color(0xFFB8860B), // Deep gold/bronze
      ],
    );

    final rightPaint = Paint()
      ..shader = goldGradient.createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r))
      ..style = PaintingStyle.fill;
    canvas.drawPath(rightPath, rightPaint);

    // Subtle inner golden glow (lighter gold edge)
    final rightGlowPaint = Paint()
      ..color = const Color(0xFFFFF3A8).withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawPath(rightPath, rightGlowPaint);

    // ── 3. STEM & LEAVES (Split Concept) ─────────────────────────────
    // Stem path (curved slightly to the right)
    final stemPath = Path();
    stemPath.moveTo(cx, cy - 0.42 * r);
    stemPath.quadraticBezierTo(cx + 0.05 * r, cy - 0.58 * r, cx + 0.12 * r, cy - 0.65 * r);
    stemPath.quadraticBezierTo(cx + 0.08 * r, cy - 0.56 * r, cx, cy - 0.42 * r);

    // Right leaf (golden)
    final rightLeafPath = Path();
    rightLeafPath.moveTo(cx + 0.06 * r, cy - 0.52 * r);
    rightLeafPath.quadraticBezierTo(cx + 0.22 * r, cy - 0.64 * r, cx + 0.28 * r, cy - 0.56 * r);
    rightLeafPath.quadraticBezierTo(cx + 0.16 * r, cy - 0.48 * r, cx + 0.06 * r, cy - 0.52 * r);

    // Left leaf (withered/broken stem segment)
    final leftLeafPath = Path();
    leftLeafPath.moveTo(cx - 0.02 * r, cy - 0.49 * r);
    leftLeafPath.quadraticBezierTo(cx - 0.12 * r, cy - 0.55 * r, cx - 0.18 * r, cy - 0.50 * r);
    leftLeafPath.quadraticBezierTo(cx - 0.08 * r, cy - 0.46 * r, cx - 0.02 * r, cy - 0.49 * r);

    final stemPaint = Paint()
      ..color = const Color(0xFF7C3AED) // tech purple stem to bind them together
      ..style = PaintingStyle.fill;
    canvas.drawPath(stemPath, stemPaint);

    final rightLeafPaint = Paint()
      ..color = const Color(0xFFF5C542)
      ..style = PaintingStyle.fill;
    canvas.drawPath(rightLeafPath, rightLeafPaint);

    final leftLeafPaint = Paint()
      ..color = const Color(0xFF3E3530)
      ..style = PaintingStyle.fill;
    canvas.drawPath(leftLeafPath, leftLeafPaint);

    // ── 4. VERTICAL SCAN LASER LINE ──────────────────────────────────
    final scanLinePaint = Paint()
      ..color = const Color(0xFF7C3AED)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final glowPaint1 = Paint()
      ..color = const Color(0xFF7C3AED).withValues(alpha: 0.3)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    final glowPaint2 = Paint()
      ..color = const Color(0xFF7C3AED).withValues(alpha: 0.12)
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke;

    // Draw scan laser line right down the middle of the apple
    final double scanTop = cy - 0.72 * r;
    final double scanBottom = cy + 0.55 * r;
    canvas.drawLine(Offset(cx, scanTop), Offset(cx, scanBottom), glowPaint2);
    canvas.drawLine(Offset(cx, scanTop), Offset(cx, scanBottom), glowPaint1);
    canvas.drawLine(Offset(cx, scanTop), Offset(cx, scanBottom), scanLinePaint);

    // ── 5. CODE BRACKETS < > ABOVE THE APPLE ─────────────────────────
    final codePaint = Paint()
      ..color = const Color(0xFF7C3AED)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double bx = cx;
    final double by = cy - 0.78 * r;
    final double bw = 16.0; // bracket width offset
    final double bh = 6.0;  // bracket height offset

    // Left bracket '<'
    final leftBracket = Path()
      ..moveTo(bx - bw + 4, by - bh)
      ..lineTo(bx - bw, by)
      ..lineTo(bx - bw + 4, by + bh);
    canvas.drawPath(leftBracket, codePaint);

    // Right bracket '>'
    final rightBracket = Path()
      ..moveTo(bx + bw - 4, by - bh)
      ..lineTo(bx + bw, by)
      ..lineTo(bx + bw - 4, by + bh);
    canvas.drawPath(rightBracket, codePaint);

    // Tiny status dot in between
    final dotPaint = Paint()
      ..color = const Color(0xFF7C3AED)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(bx, by), 2, dotPaint);

    // ── 6. TEXT AND DECORATIONS BELOW (If showText is true) ──────────
    if (showText) {
      // Draw JOEX text
      final textPainterJoex = TextPainter(
        text: const TextSpan(
          text: 'JOEX',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w900,
            fontFamily: 'monospace',
            letterSpacing: 6,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainterJoex.layout();
      // Center horizontally. Account for letterSpacing offset at the end
      final double tx = cx - (textPainterJoex.width / 2) + 3;
      final double ty = size.height * 0.74;
      textPainterJoex.paint(canvas, Offset(tx, ty));

      // Draw APPLE text
      final textPainterApple = TextPainter(
        text: const TextSpan(
          text: 'APPLE',
          style: TextStyle(
            color: Color(0xFFF5C542),
            fontSize: 9,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            letterSpacing: 4,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainterApple.layout();
      final double ax = cx - (textPainterApple.width / 2) + 2;
      final double ay = ty + 20;
      textPainterApple.paint(canvas, Offset(ax, ay));

      // Draw thin purple separator line
      final linePaint = Paint()
        ..color = const Color(0xFF7C3AED).withValues(alpha: 0.6)
        ..strokeWidth = 1.0;
      canvas.drawLine(
        Offset(cx - 24, ay + 16),
        Offset(cx + 24, ay + 16),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _JoeXLogoPainter oldDelegate) {
    return oldDelegate.showText != showText;
  }
}
