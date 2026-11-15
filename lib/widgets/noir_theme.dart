import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ==========================================
// 1. Ø§Ù„Ø£Ø³Ø·Ø­ â€” Burgundy & Black (DARK V5 Edition)
// ==========================================
const Color kCoal = Color(0xFF0A0507); // Ø®Ù„ÙÙŠØ© Ø¨Ø±ØºÙ†Ø¯ÙŠ Ø³ÙˆØ¯Ø§Ø¡ Ø¹Ù…ÙŠÙ‚Ø©
const Color kGraphite = Color(0xFF160810); // Ø®Ù„ÙÙŠØ© ÙƒØ±ÙˆØª Ø¨Ø±ØºÙ†Ø¯ÙŠ Ø¯Ø§ÙƒÙ†Ø©
const Color kSteel = Color(0xFF220D18); // Ø³Ø·Ø­ Ø§Ù„Ø¨Ø·Ø§Ù‚Ø§Øª Ø¨Ø±ØºÙ†Ø¯ÙŠ
const Color kSteelHi = Color(0xFF2E1020); // Ø³Ø·Ø­ Ù…Ø¶Ø§Ø¡ Ø¨Ø±ØºÙ†Ø¯ÙŠ Ø£ØºÙ…Ù‚
const Color kEdge = Color(0xFF6B1A35); // Ø­Ø¯ÙˆØ¯ Ø¨Ø±ØºÙ†Ø¯ÙŠ Ù‡Ø§Ø¯Ø¦Ø©
const Color kEdgeHi = Color(0xFFD4AF80); // Ø­Ø¯ Ø¨Ø§Ø±Ø² Ø°Ù‡Ø¨ÙŠ ÙØ§ØªØ­

// Ø§Ù„Ù†ØµÙˆØµ
const Color kChalk = Color(0xFFFFFFFF); // Ù†Øµ Ø£Ø³Ø§Ø³ÙŠ Ø£Ø¨ÙŠØ¶ Ù†Ø§ØµØ¹ 100%
const Color kAsh = Color(0xFFF5E8D8); // Ù†Øµ Ø«Ø§Ù†ÙˆÙŠ ÙƒØ±ÙŠÙ…ÙŠ Ù†Ø§Ø¹Ù…
const Color kMute = Color(0xFFAA7A6A); // Ù†Øµ Ø®Ø§ÙØª Ø¨Ø±ØºÙ†Ø¯ÙŠ ÙØ§ØªØ­

// Burgundy & Black â€” Ù‡ÙˆÙŠØ© DARK V5
const Color kOrangePrimary = Color(0xFF8B1A3A); // Ø¨Ø±ØºÙ†Ø¯ÙŠ Ø³Ø§Ø·Ø¹ Ø£Ø³Ø§Ø³ÙŠ
const Color kOrangeLight = Color(0xFFD4AF80); // Ø°Ù‡Ø¨ÙŠ ÙØ§ØªØ­ Ø¬Ø¯Ø§Ù‹
const Color kOrangeDeep = Color(0xFF4A0A1E); // Ø¨Ø±ØºÙ†Ø¯ÙŠ Ø¹Ù…ÙŠÙ‚
const Color kOrangeGlow = Color(0xFFB22048); // ÙˆÙ‡Ø¬ Ø¨Ø±ØºÙ†Ø¯ÙŠ
const Color kOrangePit = Color(0xFF050208); // Ø­ÙØ±Ø© Ø³ÙˆØ¯Ø§Ø¡ Ø¹Ù…ÙŠÙ‚Ø©
const Color kWhitePure = Color(0xFFFFFFFF); // Ø£Ø¨ÙŠØ¶ Ù†Ø§ØµØ¹
const Color kWhiteSoft = Color(0xFFF5E8D8); // Ø£Ø¨ÙŠØ¶ ÙƒØ±ÙŠÙ…ÙŠ Ù†Ø§Ø¹Ù…
const Color kFlameAmber = Color(0xFFD4AF80); // Ø°Ù‡Ø¨ÙŠ Ù…ØªÙˆØ³Ø·

// Ø§Ù„ØªÙˆØ§ÙÙ‚ Ø§Ù„ØªØ§Ù… Ù…Ø¹ Ø§Ù„ÙƒÙˆØ¯ Ø§Ù„Ù‚Ø§Ø¦Ù…
const Color kSilverLight = Color(0xFFD4AF80); // Ø°Ù‡Ø¨ÙŠ ÙØ§ØªØ­ Ù†Ø§ØµØ¹
const Color kSilver = Color(0xFFB89060); // Ø°Ù‡Ø¨ÙŠ Ù†Ø§Ø¹Ù… Ø³Ø§Ø·Ø¹
const Color kSilverMid = Color(0xFF8B1A3A); // Ø¨Ø±ØºÙ†Ø¯ÙŠ Ù…ØªÙˆØ³Ø·
const Color kSilverDark = Color(0xFF4A0A1E); // Ø¨Ø±ØºÙ†Ø¯ÙŠ Ø¯Ø§ÙƒÙ†
const Color kSilverPit = Color(0xFF050208); // Ø£Ø¹Ù…Ù‚ Ø£Ø³ÙˆØ¯
const Color kSilverGlow = Color(0xFFB22048); // ÙˆÙ‡Ø¬ Ø¨Ø±ØºÙ†Ø¯ÙŠ
const Color kOnSilver = Color(0xFF0A0507); // Ù†Øµ Ø¯Ø§ÙƒÙ† ÙÙˆÙ‚ Ø§Ù„Ø¨Ø±ØºÙ†Ø¯ÙŠ

const Color kWine = kOrangePrimary;
const Color kWineLt = kWhitePure;
const Color kWineDeep = kOrangeDeep;
const Color kWinePit = kOrangePit;
const Color kWineGlow = kOrangeGlow;
const Color kOnWine = Color(0xFF0A0507);
const Color kPewter = kOrangeLight;
const Color kPewterLt = kWhitePure;

// Ø§Ù„Ø­Ø§Ù„Ø§Øª
const Color kAlert = Color(0xFFFF4444);
const Color kSuccess = Color(0xFF6DBF7E);

// ØªØ¯Ø±Ø¬ Ø¨Ø±ØºÙ†Ø¯ÙŠ ÙˆØ°Ù‡Ø¨ÙŠ ÙØ§Ø®Ø±
const LinearGradient kFlameGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFD4AF80), Color(0xFF8B1A3A), Color(0xFF4A0A1E)],
  stops: [0.0, 0.45, 1.0],
);

// ØªØ¯Ø±Ø¬ Ø¨Ø±ØºÙ†Ø¯ÙŠ ØºØ§Ù…Ù‚
const LinearGradient kOrangeWhiteGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFD4AF80), Color(0xFF8B1A3A), Color(0xFF4A0A1E)],
  stops: [0.0, 0.45, 1.0],
);

const LinearGradient kSilverGradient = kFlameGradient;
const LinearGradient kWineGradient = kFlameGradient;

const LinearGradient kGlassGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xF5160810), Color(0xF2220D18), Color(0xFA0A0507)],
  stops: [0.0, 0.5, 1.0],
);

const LinearGradient kCardHeaderGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFF220D18), Color(0xFF160810)],
);


// ==========================================
// 2. Ø§Ù„Ø®Ø·ÙˆØ· (google_fonts)
// ==========================================
TextStyle arabic({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  double? letterSpacing,
  double? height,
}) {
  return GoogleFonts.almarai(
    fontSize: fontSize,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color ?? kChalk,
    letterSpacing: letterSpacing,
    height: height,
  );
}

TextStyle latin({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  double? letterSpacing,
  double? height,
}) {
  return GoogleFonts.outfit(
    fontSize: fontSize,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color ?? kChalk,
    letterSpacing: letterSpacing,
    height: height,
  );
}

TextStyle brand({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  double? letterSpacing,
  double? height,
}) {
  return GoogleFonts.orbitron(
    fontSize: fontSize,
    fontWeight: fontWeight ?? FontWeight.w700,
    color: color ?? kChalk,
    letterSpacing: letterSpacing,
    height: height,
  );
}

// ==========================================
// 3. Ù…Ø³Ø§Ø¹Ø¯Ø§Øª Ø§Ù„ÙØ­Øµ ÙˆØ§Ù„Ø£Ù†ÙŠÙ…ÙŠØ´Ù†
// ==========================================
bool get isWidgetTest =>
    WidgetsBinding.instance.runtimeType.toString().contains('Test');

bool motionAllowed(BuildContext context) {
  if (isWidgetTest) return false;
  try {
    return !MediaQuery.disableAnimationsOf(context);
  } catch (_) {
    return !WidgetsBinding
        .instance.platformDispatcher.accessibilityFeatures.disableAnimations;
  }
}

// ==========================================
// 4. NoirCanvas â€” Ø®Ù„ÙÙŠØ© ÙƒÙ„ Ø§Ù„ØµÙØ­Ø§Øª (DARK V4 Olive Edition)
// ==========================================
class NoirCanvas extends StatelessWidget {
  final Widget child;

  const NoirCanvas({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Ø£Ø¹Ù…Ù‚ Ø®Ù„ÙÙŠØ©
        const ColoredBox(color: kCoal),
        // 2. Ø®Ù„ÙÙŠØ© Ø¨Ù†ÙØ³Ø¬ÙŠØ© Ù„Ø§ÙÙ†Ø¯Ø±
        Positioned.fill(
          child: Image.asset(
            'assets/wallpaper_dark_v5.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            opacity: const AlwaysStoppedAnimation(0.25),
            errorBuilder: (_, _, _) => Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF080C06), Color(0xFF1A2410), Color(0xFF080C06)],
                ),
              ),
            ),
          ),
        ),
        // 3. CustomPaint ÙˆÙ‡Ø¬ ÙØ¶ÙŠ ÙˆØ´Ø¨ÙƒØ© ØªÙ‚Ù†ÙŠØ© ÙˆØªØ¹ØªÙŠÙ… Ø£Ø·Ø±Ø§Ù
        const Positioned.fill(
          child: CustomPaint(
            painter: _CyberCanvasPainter(),
          ),
        ),
        // 4. Ø§Ù„Ù…Ø­ØªÙˆÙ‰
        child,
      ],
    );
  }
}

class _CyberCanvasPainter extends CustomPainter {
  const _CyberCanvasPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // 1. ÙˆÙ‡Ø¬ ÙƒØ§ÙÙŠÙ‡ ÙØ§ØªØ­ Ø¯Ø§ÙØ¦ radial Ù…Ù† Ø£Ø¹Ù„Ù‰ Ø§Ù„Ø´Ø§Ø´Ø©
    final glowPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, -0.60),
        radius: 1.20,
        colors: [
          kOrangePrimary.withValues(alpha: 0.22),
          kOrangeDeep.withValues(alpha: 0.10),
          Colors.transparent,
        ],
        stops: const [0.0, 0.50, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), glowPaint);

    // 2. Ø®Ø·ÙˆØ· Ø£ÙÙ‚ÙŠØ© ÙƒØ§ÙÙŠÙ‡ Ø°Ù‡Ø¨ÙŠØ© Ø®ÙÙŠØ© ÙƒÙ„ 48px
    final linePaint = Paint()
      ..color = kOrangeLight.withValues(alpha: 0.04)
      ..strokeWidth = 1.0;
    for (double y = 0; y < size.height; y += 48.0) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    // 3. Ø®Ø·ÙˆØ· Ø±Ø£Ø³ÙŠØ© ÙƒØ±ÙŠÙ…ÙŠØ© Ø®ÙÙŠØ© ÙƒÙ„ 80px
    final vLinePaint = Paint()
      ..color = kOrangeLight.withValues(alpha: 0.025)
      ..strokeWidth = 1.0;
    for (double x = 0; x < size.width; x += 80.0) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), vLinePaint);
    }

    // 4. ÙˆÙ‡Ø¬ ÙƒØ§ÙÙŠÙ‡ Ø³ÙÙ„ÙŠ Ø¯Ø§ÙØ¦
    final bottomGlow = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, 1.30),
        radius: 0.85,
        colors: [
          kOrangeDeep.withValues(alpha: 0.15),
          Colors.transparent,
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bottomGlow);

    // 5. ØªØ¹ØªÙŠÙ… Ø£Ø·Ø±Ø§Ù radial
    final vignettePaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.05,
        colors: [
          Colors.transparent,
          kCoal.withValues(alpha: 0.50),
          kCoal.withValues(alpha: 0.88),
        ],
        stops: const [0.35, 0.75, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      vignettePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// 5. NoirCard â€” Ø§Ù„Ø¨Ø·Ø§Ù‚Ø© Ø§Ù„Ø¹Ø§Ø¯ÙŠØ© Ø§Ù„Ø²Ø¬Ø§Ø¬ÙŠØ©
// ==========================================
class NoirCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool accent;
  final double borderRadius;
  final VoidCallback? onTap;

  const NoirCard({
    super.key,
    required this.child,
    this.padding,
    this.accent = false,
    this.borderRadius = 22,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      padding: padding ?? const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: kGlassGradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: accent ? kOrangePrimary : kEdge,
          width: accent ? 1.6 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.70),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
          if (accent)
            BoxShadow(
              color: kOrangePrimary.withValues(alpha: 0.28),
              blurRadius: 22,
              spreadRadius: 1,
            ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      card = GestureDetector(
        onTap: onTap,
        child: card,
      );
    }

    return card;
  }
}

// ==========================================
// 6. TicketCard â€” Ø¨Ø·Ø§Ù‚Ø© Ø§Ù„ØªØ°ÙƒØ±Ø© Ø§Ù„Ù†Ø§Ø±ÙŠØ© Ø§Ù„ÙØ§Ø®Ø±Ø© (Ø¨Ø±ØªÙ‚Ø§Ù„ÙŠ ÙˆØ£Ø¨ÙŠØ¶)
// ==========================================
class TicketCard extends StatelessWidget {
  final double notchAt;
  final Widget header;
  final Widget body;
  final double width;
  final EdgeInsetsGeometry? bodyPadding;

  const TicketCard({
    super.key,
    required this.notchAt,
    required this.header,
    required this.body,
    this.width = double.infinity,
    this.bodyPadding,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TicketCardPainter(notchAt: notchAt),
      child: Container(
        width: width,
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: notchAt,
              child: header,
            ),
            Padding(
              padding: bodyPadding ?? const EdgeInsets.fromLTRB(18, 14, 18, 18),
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}

class _TicketCardPainter extends CustomPainter {
  final double notchAt;

  const _TicketCardPainter({required this.notchAt});

  @override
  void paint(Canvas canvas, Size size) {
    const double radius = 24.0;
    const double notchR = 9.0;
    final w = size.width;
    final h = size.height;

    final path = Path();
    path.moveTo(radius, 0);

    path.lineTo(w - radius, 0);
    path.arcToPoint(
      Offset(w, radius),
      radius: const Radius.circular(radius),
    );

    path.lineTo(w, notchAt - notchR);
    path.arcToPoint(
      Offset(w, notchAt + notchR),
      radius: const Radius.circular(notchR),
      clockwise: false,
    );
    path.lineTo(w, h - radius);
    path.arcToPoint(
      Offset(w - radius, h),
      radius: const Radius.circular(radius),
    );

    path.lineTo(radius, h);
    path.arcToPoint(
      Offset(0, h - radius),
      radius: const Radius.circular(radius),
    );

    path.lineTo(0, notchAt + notchR);
    path.arcToPoint(
      Offset(0, notchAt - notchR),
      radius: const Radius.circular(notchR),
      clockwise: false,
    );
    path.lineTo(0, radius);
    path.arcToPoint(
      const Offset(radius, 0),
      radius: const Radius.circular(radius),
    );
    path.close();

    // 1. Ø¸Ù„ Ø§Ù„Ø¨Ø·Ø§Ù‚Ø©
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.75)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
    canvas.save();
    canvas.translate(0, 8);
    canvas.drawPath(path, shadowPaint);
    canvas.restore();

    // 2. ØªØ¹Ø¨Ø¦Ø© Ø§Ù„Ø¨Ø·Ø§Ù‚Ø© Ø¨Ø§Ù„Ø²Ø¬Ø§Ø¬ Ø§Ù„Ø£Ø³ÙˆØ¯ Ø§Ù„Ø¯Ø§ÙØ¦
    final fillPaint = Paint()
      ..shader = kGlassGradient.createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(path, fillPaint);

    // 3. Ø­Ø¯ÙˆØ¯ Ø§Ù„Ø¨Ø·Ø§Ù‚Ø© Ø§Ù„Ù†Ø§Ø±ÙŠØ© Ø§Ù„Ø¨Ø±ØªÙ‚Ø§Ù„ÙŠØ© Ø§Ù„Ø®Ø§ÙØªØ©
    final borderPaint = Paint()
      ..color = kOrangePrimary.withValues(alpha: 0.38)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawPath(path, borderPaint);

    // 4. Ø®Ø· ØªÙ‚Ø·ÙŠØ¹ Ù…Ù†Ù‚Ù‘Ø· Ø¨Ø±ØªÙ‚Ø§Ù„ÙŠ Ù†Ø§Ø±ÙŠ Ø¹Ù†Ø¯ Ø§Ø±ØªÙØ§Ø¹ notchAt
    final dashPaint = Paint()
      ..color = kOrangeLight.withValues(alpha: 0.70)
      ..strokeWidth = 1.3;
    const double dashWidth = 4.0;
    const double dashSpace = 5.0;
    double startX = notchR + 2.0;
    final double endX = w - notchR - 2.0;

    while (startX < endX) {
      final double segEnd = math.min(startX + dashWidth, endX);
      canvas.drawLine(
        Offset(startX, notchAt),
        Offset(segEnd, notchAt),
        dashPaint,
      );
      startX += dashWidth + dashSpace;
    }

    // 5. Ø®ÙŠØ· Ø¨Ø±ØªÙ‚Ø§Ù„ÙŠ ÙÙŠ Ø£Ø¨ÙŠØ¶ Ø³Ø§Ø·Ø¹ Ø£Ø¹Ù„Ù‰ Ø§Ù„Ø¨Ø·Ø§Ù‚Ø©
    final threadPaint = Paint()
      ..shader = kOrangeWhiteGradient.createShader(
        Rect.fromLTWH(w * 0.18, 0, w * 0.64, 2.5),
      )
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(w * 0.18, 1.2),
      Offset(w * 0.82, 1.2),
      threadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TicketCardPainter oldDelegate) =>
      oldDelegate.notchAt != notchAt;
}

// ==========================================
// 7. LogoRing â€” Ø¥Ø·Ø§Ø± Ø§Ù„Ù„ÙˆØ¬Ùˆ Ø§Ù„Ø¯Ø§Ø¦Ø±ÙŠ Ø§Ù„Ù†Ø§Ø±ÙŠ (Ø¨Ø±ØªÙ‚Ø§Ù„ÙŠ ÙˆØ£Ø¨ÙŠØ¶)
// ==========================================
class LogoRing extends StatelessWidget {
  final double size;
  final double? progress;

  const LogoRing({
    super.key,
    this.size = 64,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final pad = size * 0.055;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ù‡Ø§Ù„Ø© Ø®Ø§Ø±Ø¬ÙŠØ© Ø¨Ø±ØªÙ‚Ø§Ù„ÙŠØ© Ù†Ø§Ø±ÙŠØ©
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  kOrangePrimary.withValues(alpha: 0.35),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Ø¯Ø§ÙŠØ±Ø© Ù…ØªÙ…Ù„ÙŠØ© ØªØ¯Ø±Ø¬ Ø¨Ø±ØªÙ‚Ø§Ù„ÙŠ Ù†Ø§Ø±ÙŠ Ù…Ø¹ Ø¥Ø·Ø§Ø± Ø£Ø¨ÙŠØ¶ Ù†Ø§ØµØ¹
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: kFlameGradient,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.90),
                width: 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: kOrangePrimary.withValues(alpha: 0.40),
                  blurRadius: 12,
                ),
              ],
            ),
          ),
          // Ø¯Ø§ÙŠØ±Ø© Ø¯Ø§Ø®Ù„ÙŠØ© Ù…Ù† kSteel
          Container(
            width: size - (pad * 2),
            height: size - (pad * 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kSteel,
              border: Border.all(
                color: kOrangeLight.withValues(alpha: 0.60),
                width: 1.0,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/logo_dark_v5.png',
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const ColoredBox(
                  color: kCoal,
                  child: Icon(Icons.shield_rounded, color: Color(0xFF8A9A4A)),
                ),
              ),
            ),
          ),
          // Ø¹Ù„Ø§Ù…Ø§Øª ÙˆÙ‚ÙˆØ³ Ø§Ù„ØªÙ‚Ø¯Ù…
          Positioned.fill(
            child: CustomPaint(
              painter: _LogoRingPainter(progress: progress),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoRingPainter extends CustomPainter {
  final double? progress;

  const _LogoRingPainter({this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // 4 Ø¹Ù„Ø§Ù…Ø§Øª Ø¨ÙŠØ¶Ø§Ø¡ Ø¯Ù‚ÙŠÙ‚Ø©
    final tickPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 4; i++) {
      final angle = i * (math.pi / 2);
      final p1 = Offset(
        center.dx + (radius - 4) * math.cos(angle),
        center.dy + (radius - 4) * math.sin(angle),
      );
      final p2 = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(p1, p2, tickPaint);
    }

    // Ù‚ÙˆØ³ ØªÙ‚Ø¯Ù… Ø¨Ø§Ù„Ù„ÙˆÙ† Ø§Ù„Ø£Ø¨ÙŠØ¶ Ø§Ù„Ù†Ø§ØµØ¹ Ù…Ø¹ ÙˆÙ‡Ø¬ Ù†Ø§Ø±ÙŠ
    if (progress != null && progress! > 0) {
      final arcPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.8
        ..strokeCap = StrokeCap.round;

      final p = progress!.clamp(0.0, 1.0);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - 1.4),
        -math.pi / 2,
        2 * math.pi * p,
        false,
        arcPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _LogoRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// ==========================================
// 8. ArcGauge â€” Ø§Ù„Ù…Ù‚ÙŠØ§Ø³ Ø§Ù„Ù‚ÙˆØ³ÙŠ Ø§Ù„ÙØ¶ÙŠ
// ==========================================
class ArcGauge extends StatelessWidget {
  final double progress;
  final Widget centerChild;
  final double size;

  const ArcGauge({
    super.key,
    required this.progress,
    required this.centerChild,
    this.size = 190,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: (size / 2) + 24,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomPaint(
            size: Size(size, size / 2),
            painter: _ArcGaugePainter(progress: progress),
          ),
          Positioned(
            bottom: 4,
            child: centerChild,
          ),
        ],
      ),
    );
  }
}

class _ArcGaugePainter extends CustomPainter {
  final double progress;

  const _ArcGaugePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final radius = (w / 2) - 16;
    final center = Offset(w / 2, size.height);
    final arcRect = Rect.fromCircle(center: center, radius: radius);

    // 1. Ù…Ø³Ø§Ø± Ø®Ù„ÙÙŠ
    final bgPaint = Paint()
      ..color = kSteelHi
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9.0
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(arcRect, math.pi, math.pi, false, bgPaint);

    // 2. 21 Ø¹Ù„Ø§Ù…Ø© ØªØ¯Ø±ÙŠØ¬ ÙØ¶ÙŠØ©
    const int tickCount = 21;
    final clampedP = progress.clamp(0.0, 1.0);
    final passedTicks = (clampedP * (tickCount - 1)).round();

    for (int i = 0; i < tickCount; i++) {
      final t = i / (tickCount - 1);
      final angle = math.pi + (t * math.pi);
      final isPassed = i <= passedTicks && clampedP > 0;

      final tickColor = isPassed ? Colors.white : kEdge;
      final tickPaint = Paint()
        ..color = tickColor
        ..strokeWidth = 1.4
        ..strokeCap = StrokeCap.round;

      final innerR = radius + 9;
      final outerR = radius + (i % 5 == 0 ? 15 : 12);

      final p1 = Offset(
        center.dx + innerR * math.cos(angle),
        center.dy + innerR * math.sin(angle),
      );
      final p2 = Offset(
        center.dx + outerR * math.cos(angle),
        center.dy + outerR * math.sin(angle),
      );
      canvas.drawLine(p1, p2, tickPaint);
    }

    // 3. Ù‚ÙˆØ³ Ø§Ù„ØªÙ‚Ø¯Ù… Ø¨ØªØ¯Ø±Ø¬ Ø¨Ø±ØªÙ‚Ø§Ù„ÙŠ Ù†Ø§Ø±ÙŠ ÙŠÙ†ØªÙ‡ÙŠ Ø¨Ø£Ø¨ÙŠØ¶ Ø³Ø§Ø·Ø¹
    if (clampedP > 0.005) {
      final sweepAngle = math.pi * clampedP;
      final progressPaint = Paint()
        ..shader = const SweepGradient(
          startAngle: math.pi,
          endAngle: 2 * math.pi,
          colors: [
            Color(0xFFFF3700),
            Color(0xFFFF7A00),
            Color(0xFFFFAE33),
            Color(0xFFFFFFFF),
          ],
        ).createShader(arcRect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 9.0
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(arcRect, math.pi, sweepAngle, false, progressPaint);

      // 4. Ø±Ø£Ø³ Ù…Ø¶ÙŠØ¡ Ø£Ø¨ÙŠØ¶ Ù†Ø§ØµØ¹ Ø¹Ù†Ø¯ Ù†Ù‡Ø§ÙŠØ© Ø§Ù„Ù‚ÙˆØ³ Ù…Ø¹ ÙˆÙ‡Ø¬ Ù†Ø§Ø±ÙŠ
      final headAngle = math.pi + sweepAngle;
      final headCenter = Offset(
        center.dx + radius * math.cos(headAngle),
        center.dy + radius * math.sin(headAngle),
      );

      final glowPaint = Paint()
        ..color = kOrangePrimary.withValues(alpha: 0.85)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(headCenter, 8, glowPaint);

      final steelPaint = Paint()..color = Colors.white;
      canvas.drawCircle(headCenter, 6, steelPaint);

      final ringPaint = Paint()
        ..color = kOrangePrimary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawCircle(headCenter, 6, ringPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ArcGaugePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// ==========================================
// 9. WineButton (FireButton) â€” Ø§Ù„Ø²Ø± Ø§Ù„Ø£Ø³Ø§Ø³ÙŠ Ø§Ù„Ù†Ø§Ø±ÙŠ Ø§Ù„ÙØ§Ø®Ø± (Ø¨Ø±ØªÙ‚Ø§Ù„ÙŠ ÙˆØ£Ø¨ÙŠØ¶)
// ==========================================
class WineButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final double height;
  final double? width;
  final bool compact;

  const WineButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
    this.height = 54,
    this.width,
    this.compact = false,
  });

  @override
  State<WineButton> createState() => _WineButtonState();
}

class _WineButtonState extends State<WineButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glowController;
  late final Animation<double> _glowAnimation;
  bool _isDown = false;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    if (!isWidgetTest) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && motionAllowed(context)) {
          _glowController.repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool enabled = widget.onPressed != null;
    final double h = widget.compact ? 44.0 : widget.height;
    final double iconBoxSize = h - 16.0;

    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        final double glowVal = _glowAnimation.value;
        final double blur = 18.0 + (10.0 * glowVal);
        final double opacity = 0.22 + (0.18 * glowVal);

        final decoration = enabled
            ? BoxDecoration(
                gradient: kFlameGradient,
                borderRadius: BorderRadius.circular(h / 2),
                border: Border.all(
                  color: Colors.white,
                  width: 1.6,
                ),
                boxShadow: [
                  BoxShadow(
                    color: kOrangePrimary.withValues(alpha: opacity),
                    blurRadius: blur + 4,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.50),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              )
            : BoxDecoration(
                color: kSteelHi,
                borderRadius: BorderRadius.circular(h / 2),
                border: Border.all(color: kEdge, width: 1.0),
              );

        return GestureDetector(
          onTapDown: enabled ? (_) => setState(() => _isDown = true) : null,
          onTapUp: enabled
              ? (_) {
                  setState(() => _isDown = false);
                  widget.onPressed?.call();
                }
              : null,
          onTapCancel: enabled ? () => setState(() => _isDown = false) : null,
          child: AnimatedScale(
            scale: _isDown ? 0.975 : 1.0,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
            child: Container(
              width: widget.width,
              height: h,
              decoration: decoration,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Ø¯Ø§ÙŠØ±Ø© Ø£ÙŠÙ‚ÙˆÙ†Ø© Ø¨ÙŠØ¶Ø§Ø¡ Ø¹Ù„Ù‰ Ø§Ù„ÙŠÙ…ÙŠÙ† Ø¨Ø£ÙŠÙ‚ÙˆÙ†Ø© Ø¨Ø±ØªÙ‚Ø§Ù„ÙŠØ©
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        width: iconBoxSize,
                        height: iconBoxSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: enabled ? Colors.white : Colors.transparent,
                          border: Border.all(
                            color: enabled ? Colors.white : kEdgeHi,
                            width: 1.0,
                          ),
                          boxShadow: enabled
                              ? [
                                  BoxShadow(
                                    color: kOrangePrimary.withValues(alpha: 0.30),
                                    blurRadius: 6,
                                  ),
                                ]
                              : null,
                        ),
                        child: Icon(
                          widget.icon ?? Icons.arrow_back_rounded,
                          size: iconBoxSize * 0.55,
                          color: enabled ? kOrangePrimary : kMute,
                        ),
                      ),
                    ),
                    // Ø§Ù„Ù†Øµ Ù…ØªÙˆØ³Ù‘Ø· Ø¨Ø§Ù„Ù„ÙˆÙ† Ø§Ù„Ø£Ø¨ÙŠØ¶ Ø§Ù„Ù†Ø§ØµØ¹
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: arabic(
                            fontSize: widget.compact ? 14 : 16,
                            fontWeight: FontWeight.w900,
                            color: enabled ? Colors.white : kMute,
                          ),
                        ),
                      ),
                    ),
                    // Ù…Ø³Ø§ÙØ© Ù…ØªÙ†Ø§Ø³Ù‚Ø© Ø¹Ù„Ù‰ Ø§Ù„Ø´Ù…Ø§Ù„
                    SizedBox(width: iconBoxSize + 8.0),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ==========================================
// 10. Ø¨Ø§Ù‚ÙŠ Ø§Ù„Ø¹Ù†Ø§ØµØ± Ø§Ù„ÙØ§Ø®Ø±Ø©
// ==========================================

// Chip: ÙƒØ¨Ø³ÙˆÙ„Ø© ÙØ¶ÙŠØ© ØµØºÙŠØ±Ø©
class NoirChip extends StatelessWidget {
  final Widget? icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  const NoirChip({
    super.key,
    this.icon,
    required this.label,
    this.active = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: active ? kOrangePrimary : kGraphite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: active ? Colors.white : kEdge,
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: arabic(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: active ? Colors.white : kAsh,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      chip = GestureDetector(onTap: onTap, child: chip);
    }
    return chip;
  }
}

// DashRule: Ø®Ø· Ù…Ù†Ù‚Ù‘Ø· Ø£ÙÙ‚ÙŠ Ø¨Ø±ØªÙ‚Ø§Ù„ÙŠ Ù†Ø§Ø±ÙŠ
class DashRule extends StatelessWidget {
  final Color color;
  final double height;

  const DashRule({
    super.key,
    this.color = kEdgeHi,
    this.height = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _DashRulePainter(color: color, strokeHeight: height),
        size: Size(double.infinity, height),
      ),
    );
  }
}

class _DashRulePainter extends CustomPainter {
  final Color color;
  final double strokeHeight;

  const _DashRulePainter({
    required this.color,
    required this.strokeHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeHeight;
    const double dashWidth = 4.0;
    const double dashSpace = 5.0;
    double startX = 0.0;

    while (startX < size.width) {
      final double endX = math.min(startX + dashWidth, size.width);
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(endX, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _DashRulePainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeHeight != strokeHeight;
}

// RailStep: Ø®Ø·ÙˆØ© Ø¹Ù„Ù‰ Ù…Ø³Ø§Ø± Ø±Ø£Ø³ÙŠ (Ø¨Ø±ØªÙ‚Ø§Ù„ÙŠ ÙˆØ£Ø¨ÙŠØ¶)
class RailStep extends StatelessWidget {
  final int stepNumber;
  final bool isCompleted;
  final bool isLast;
  final String title;
  final Widget content;

  const RailStep({
    super.key,
    required this.stepNumber,
    required this.isCompleted,
    this.isLast = false,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                // Ø¯Ø§ÙŠØ±Ø© Ø§Ù„Ø®Ø·ÙˆØ© 26px Ù…Ø¹ ØªØ¯Ø±Ø¬ Ù†Ø§Ø±ÙŠ Ø£Ùˆ Ø­Ø¯ Ø£Ø¨ÙŠØ¶
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isCompleted ? kFlameGradient : null,
                    color: isCompleted ? null : kSteelHi,
                    border: Border.all(
                      color: isCompleted ? Colors.white : kEdge,
                      width: 1.4,
                    ),
                    boxShadow: isCompleted
                        ? [
                            BoxShadow(
                              color: kOrangePrimary.withValues(alpha: 0.45),
                              blurRadius: 8,
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : Text(
                            '$stepNumber',
                            style: latin(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: kAsh,
                            ),
                          ),
                  ),
                ),
                // Ø§Ù„Ø®Ø· Ø§Ù„Ø±Ø£Ø³ÙŠ Ù„Ù„Ø®Ø·ÙˆØ© Ø§Ù„ØªØ§Ù„ÙŠØ© Ø¨Ø§Ù„Ù„ÙˆÙ† Ø§Ù„Ø¨Ø±ØªÙ‚Ø§Ù„ÙŠ Ø§Ù„Ù†Ø§Ø±ÙŠ
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isCompleted ? kOrangePrimary : kEdge,
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0.0 : 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: arabic(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: kChalk,
                      ),
                    ),
                    const SizedBox(height: 8),
                    content,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// GlowDot: Ù†Ù‚Ø·Ø© Ø¬Ù…Ø± Ù†Ø§Ø¨Ø¶Ø© Ø¨Ø§Ù„Ø¨Ø±ØªÙ‚Ø§Ù„ÙŠ Ø§Ù„Ù†Ø§Ø±ÙŠ
class GlowDot extends StatefulWidget {
  final double size;
  final Color color;

  const GlowDot({
    super.key,
    this.size = 8.0,
    this.color = kOrangePrimary,
  });

  @override
  State<GlowDot> createState() => _GlowDotState();
}

class _GlowDotState extends State<GlowDot> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulse = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (!isWidgetTest) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && motionAllowed(context)) {
          _controller.repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) {
        final opacity = _pulse.value;
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color.withValues(alpha: opacity),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: opacity * 0.6),
                blurRadius: widget.size * 1.2,
                spreadRadius: widget.size * 0.2,
              ),
            ],
          ),
        );
      },
    );
  }
}

// StepMeter: Ø´Ø±ÙŠØ· ØªÙ‚Ø¯Ù… Ù…Ù‚Ø³Ù‘Ù… Ø¨Ø§Ù„Ù†Ø§Ø± ÙˆØ§Ù„Ø¨Ø±ØªÙ‚Ø§Ù„ÙŠ
class StepMeter extends StatelessWidget {
  final int total;
  final int current;

  const StepMeter({
    super.key,
    required this.total,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (i) {
        final isFilled = i < current;
        return Expanded(
          child: Container(
            height: 4.5,
            margin: EdgeInsets.only(left: i == total - 1 ? 0 : 4),
            decoration: BoxDecoration(
              gradient: isFilled ? kFlameGradient : null,
              color: isFilled ? null : kSteelHi,
              borderRadius: BorderRadius.circular(3),
              boxShadow: isFilled
                  ? [
                      BoxShadow(
                        color: kOrangePrimary.withValues(alpha: 0.50),
                        blurRadius: 4,
                      ),
                    ]
                  : null,
            ),
          ),
        );
      }),
    );
  }
}

// LureStrip: Ø´Ø±ÙŠØ· ÙƒØ¨Ø³ÙˆÙ„Ø© Ù†Ø§Ø±ÙŠ Ø¨Ø±ØªÙ‚Ø§Ù„ÙŠ ÙˆØ£Ø¨ÙŠØ¶
class LureStrip extends StatefulWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const LureStrip({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  State<LureStrip> createState() => _LureStripState();
}

class _LureStripState extends State<LureStrip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    if (!isWidgetTest) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && motionAllowed(context)) {
          _controller.repeat();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: kSteel,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: kOrangePrimary.withValues(alpha: 0.65),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: kOrangePrimary.withValues(alpha: 0.20),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.60),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: kFlameGradient,
                ),
                child: const Center(
                  child: Text(
                    'ðŸ”¥',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: arabic(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: kChalk,
                      ),
                    ),
                    if (widget.subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        widget.subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: arabic(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w400,
                          color: kAsh,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final v = _controller.value;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(3, (i) {
                      final phase = ((v * 3.0) - i) % 3.0;
                      final isLit = phase < 1.0;
                      return Icon(
                        Icons.chevron_left_rounded,
                        size: 18,
                        color: isLit ? Colors.white : kOrangePrimary.withValues(alpha: 0.35),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reveal: Ø£Ù†ÙŠÙ…ÙŠØ´Ù† Ø¯Ø®ÙˆÙ„
class Reveal extends StatelessWidget {
  final Animation<double> parent;
  final double begin;
  final double end;
  final double dy;
  final Widget child;

  const Reveal({
    super.key,
    required this.parent,
    required this.begin,
    required this.end,
    this.dy = 24.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!motionAllowed(context)) {
      return child;
    }

    final anim = CurvedAnimation(
      parent: parent,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: anim,
      builder: (context, c) {
        return Opacity(
          opacity: anim.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, dy * (1.0 - anim.value)),
            child: c,
          ),
        );
      },
      child: child,
    );
  }
}
