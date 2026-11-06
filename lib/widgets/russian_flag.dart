import 'package:flutter/material.dart';

// ==========================================
// RussianFlag — علم روسيا ثلاثي الألوان
// يُستخدم في كل صفحات التطبيق
// ==========================================

class RussianFlag extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final bool showShadow;

  const RussianFlag({
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
        child: Column(
          children: [
            // الأبيض — العلوي
            Expanded(child: Container(color: const Color(0xFFFFFFFF))),
            // الأزرق — الأوسط
            Expanded(child: Container(color: const Color(0xFF003DA5))),
            // الأحمر — السفلي
            Expanded(child: Container(color: const Color(0xFFCC0000))),
          ],
        ),
      ),
    );
  }
}

// نسخة صغيرة مضمّنة بجانب النص
class RussianFlagInline extends StatelessWidget {
  final double size;
  const RussianFlagInline({super.key, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return RussianFlag(
      width: size * 1.5,
      height: size,
      borderRadius: 2,
    );
  }
}

