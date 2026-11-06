import 'package:flutter/material.dart';

// ==========================================
// BritishFlag — علم بريطانيا (Union Jack)
// يُستخدم في كل صفحات التطبيق
// ==========================================

class BritishFlag extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final bool showShadow;

  const BritishFlag({
    super.key,
    this.width = 48,
    this.height = 32,
    this.borderRadius = 4,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.55),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CustomPaint(
          size: Size(width, height),
          painter: _UnionJackPainter(),
        ),
      ),
    );
  }
}

class _UnionJackPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // خلفية زرقاء
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF012169),
    );

    // الصليب الأحمر (St George) مع حواف بيضاء
    // أفقي أبيض
    canvas.drawRect(
      Rect.fromLTWH(0, h * 0.35, w, h * 0.30),
      Paint()..color = Colors.white,
    );
    // رأسي أبيض
    canvas.drawRect(
      Rect.fromLTWH(w * 0.35, 0, w * 0.30, h),
      Paint()..color = Colors.white,
    );
    // أفقي أحمر
    canvas.drawRect(
      Rect.fromLTWH(0, h * 0.40, w, h * 0.20),
      Paint()..color = const Color(0xFFC8102E),
    );
    // رأسي أحمر
    canvas.drawRect(
      Rect.fromLTWH(w * 0.40, 0, w * 0.20, h),
      Paint()..color = const Color(0xFFC8102E),
    );

    // القطريات البيضاء (St Andrew + St Patrick)
    final whitePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = h * 0.22
      ..strokeCap = StrokeCap.butt;

    canvas.drawLine(Offset(0, 0), Offset(w, h), whitePaint);
    canvas.drawLine(Offset(w, 0), Offset(0, h), whitePaint);

    // القطريات الحمراء
    final redThin = Paint()
      ..color = const Color(0xFFC8102E)
      ..strokeWidth = h * 0.11
      ..strokeCap = StrokeCap.butt;

    // St Patrick — مكسورة (offset)
    final path1 = Path();
    path1.moveTo(0, 0);
    path1.lineTo(w * 0.42, h * 0.38);
    path1.moveTo(w * 0.58, h * 0.62);
    path1.lineTo(w, h);
    canvas.drawPath(path1, redThin);

    final path2 = Path();
    path2.moveTo(w, 0);
    path2.lineTo(w * 0.58, h * 0.38);
    path2.moveTo(w * 0.42, h * 0.62);
    path2.lineTo(0, h);
    canvas.drawPath(path2, redThin);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// نسخة صغيرة مضمّنة بجانب النص
class BritishFlagInline extends StatelessWidget {
  final double size;
  const BritishFlagInline({super.key, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return BritishFlag(
      width: size * 1.5,
      height: size,
      borderRadius: 2,
    );
  }
}

