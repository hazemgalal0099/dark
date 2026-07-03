import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../widgets/joex_logo.dart';

// ─────────────────────────────────────────────
// CONSTANTS
// ─────────────────────────────────────────────
const _kBlack = Color(0xFF000000);
const _kPurple = Color(0xFF7C3AED);
const _kPurpleMid = Color(0xFF2D1B69);
const _kGlowCenter = Color(0xFF1A0D40);
const _kGreen = Color(0xFF4ADE80);
const _kDimLine = Color(0xFF3D2F6E);
const _kGrayText = Color(0xFF8B8B9E);
const _kCardBg = Color(0xFF0D0B14);

// ─────────────────────────────────────────────
// TERMINAL LINE MODEL
// ─────────────────────────────────────────────
enum _LineType { title, subtitle, system, granted }

class _TLine {
  final String text;
  final _LineType type;
  const _TLine(this.text, this.type);
}

const _kLines = [
  _TLine('JoeX Apple', _LineType.title),
  _TLine('نظام فك التشفير', _LineType.subtitle),
  _TLine('> جاري الاتصال بنقطة آمنة...', _LineType.system),
  _TLine('> جاري إنشاء نفق مشفر...', _LineType.system),
  _TLine('> جاري التحقق من هوية المشغل...', _LineType.system),
  _TLine('> بروتوكول التخطي نشط...', _LineType.system),
  _TLine('> تم السماح بالدخول', _LineType.granted),
];

// ─────────────────────────────────────────────
// SPLASH SCREEN
// ─────────────────────────────────────────────
class SplashScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const SplashScreen({super.key, required this.onComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// Alias so main.dart can keep using JoeXSplashPage
typedef JoeXSplashPage = SplashScreen;

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // ── Controllers ──────────────────────────────
  late final AnimationController _bgCtrl;
  late final AnimationController _logoCtrl;
  late final AnimationController _logoFlashCtrl;
  late final AnimationController _cardsCtrl;
  late final AnimationController _pulseCtrl;

  // ── Terminal state ────────────────────────────
  int _currentLine = -1;
  int _currentChar = 0;
  final List<bool> _done = List.filled(_kLines.length, false);
  bool _cursorVisible = true;
  Timer? _cursorTimer;

  // ── Flash state ───────────────────────────────
  bool _logoFlash = false;
  bool _accessFlash = false;
  bool _showCards = false;

  @override
  void initState() {
    super.initState();

    _bgCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _logoCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _logoFlashCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 180));
    _cardsCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _pulseCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);

    _run();
  }

  Future<void> _run() async {
    // Phase 1 — black screen pause
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    // Phase 2 — background glow fades in
    _bgCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    // Phase 3 — logo flash then settle
    setState(() => _logoFlash = true);
    _logoFlashCtrl.forward().then((_) {
      if (mounted) {
        _logoFlashCtrl.reverse();
        setState(() => _logoFlash = false);
      }
    });
    _logoCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;

    // Phase 4 — terminal typing
    _startCursorBlink();
    for (int i = 0; i < _kLines.length; i++) {
      await _typeLine(i);
      await Future.delayed(const Duration(milliseconds: 90));
      if (!mounted) return;
    }

    // Phase 5 — access granted flash
    setState(() => _accessFlash = true);
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    setState(() => _accessFlash = false);

    // Phase 6 — server cards slide up
    setState(() => _showCards = true);
    _cardsCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 1100));
    if (!mounted) return;

    // Phase 7 — stay then navigate
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    widget.onComplete();
  }

  Future<void> _typeLine(int idx) async {
    setState(() {
      _currentLine = idx;
      _currentChar = 0;
    });

    final text = _kLines[idx].text;
    // Target ~550ms per line; clamp per-char interval
    final msPer = (550 / text.length).clamp(18.0, 70.0).toInt();

    for (int c = 1; c <= text.length; c++) {
      await Future.delayed(Duration(milliseconds: msPer));
      if (!mounted) return;
      setState(() => _currentChar = c);
    }

    if (!mounted) return;
    setState(() => _done[idx] = true);
  }

  void _startCursorBlink() {
    _cursorTimer =
        Timer.periodic(const Duration(milliseconds: 480), (_) {
      if (mounted) setState(() => _cursorVisible = !_cursorVisible);
    });
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    _logoCtrl.dispose();
    _logoFlashCtrl.dispose();
    _cardsCtrl.dispose();
    _pulseCtrl.dispose();
    _cursorTimer?.cancel();
    super.dispose();
  }

  // ─────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBlack,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background ─────────────────────────
          AnimatedBuilder(
            animation: _bgCtrl,
            builder: (context, _) => CustomPaint(
              painter: _BgPainter(_bgCtrl.value),
            ),
          ),

          // ── Logo purple flash ──────────────────
          if (_logoFlash)
            AnimatedBuilder(
              animation: _logoFlashCtrl,
              builder: (context, _) => Container(
                color: _kPurple.withValues(
                    alpha: (1 - _logoFlashCtrl.value) * 0.45),
              ),
            ),

          // ── ACCESS GRANTED full-screen flash ───
          if (_accessFlash)
            Container(color: _kPurple.withValues(alpha: 0.28)),

          // ── Main content ──────────────────────
          SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  // Logo section
                  Expanded(
                    flex: 30,
                    child: AnimatedBuilder(
                      animation: _logoCtrl,
                      builder: (context, _) => Opacity(
                        opacity: _logoCtrl.value,
                        child: Center(child: _buildLogo()),
                      ),
                    ),
                  ),

                  // Terminal section
                  Expanded(
                    flex: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: _buildTerminal(),
                    ),
                  ),

                  // Server cards section
                  Expanded(
                    flex: 20,
                    child: _buildCards(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Logo with diamond clip + scope lines ──────
  Widget _buildLogo() {
    return SizedBox(
      width: 130,
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Diamond clipped logo
          ClipPath(
            clipper: _DiamondClipper(),
            child: const JoeXLogo(
              showText: false,
              drawBackground: false,
              size: 88,
            ),
          ),
          // Scope crosshair lines
          CustomPaint(
            size: const Size(130, 130),
            painter: _ScopePainter(),
          ),
        ],
      ),
    );
  }

  // ── Terminal typing widget ─────────────────────
  Widget _buildTerminal() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i <= _currentLine && i < _kLines.length; i++) ...[
          _TerminalLineWidget(
            line: _kLines[i],
            displayText: i < _currentLine
                ? _kLines[i].text
                : _kLines[i].text.substring(0, _currentChar),
            isTyping: i == _currentLine && !_done[i],
            isCompleted: _done[i],
            showCursor: i == _currentLine && !_done[i] && _cursorVisible,
          ),
          const SizedBox(height: 5),
        ],
      ],
    );
  }

  // ── Server cards ───────────────────────────────
  Widget _buildCards() {
    if (!_showCards) return const SizedBox.shrink();

    const cards = [
      {'name': 'خادم أمريكا', 'uptime': '99.4%'},
      {'name': 'خادم أوروبا', 'uptime': '99.7%'},
      {'name': 'خادم الشرق الأوسط', 'uptime': '99.8%'},
    ];

    return AnimatedBuilder(
      animation: _cardsCtrl,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Row(
            children: List.generate(cards.length, (i) {
              final delay = i * 0.28;
              final raw = (_cardsCtrl.value - delay) / (1.0 - delay);
              final p = raw.clamp(0.0, 1.0);
              final eased = Curves.easeOutBack.transform(p);

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Transform.translate(
                    offset: Offset(0, 36 * (1 - eased)),
                    child: Opacity(
                      opacity: p,
                      child: _ServerCard(
                        name: cards[i]['name']!,
                        uptime: cards[i]['uptime']!,
                        pulse: _pulseCtrl,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// TERMINAL LINE WIDGET
// ─────────────────────────────────────────────
class _TerminalLineWidget extends StatelessWidget {
  final _TLine line;
  final String displayText;
  final bool isTyping;
  final bool isCompleted;
  final bool showCursor;

  const _TerminalLineWidget({
    required this.line,
    required this.displayText,
    required this.isTyping,
    required this.isCompleted,
    required this.showCursor,
  });

  Color get _textColor {
    if (isTyping) return Colors.white;
    if (!isCompleted) return Colors.white;
    switch (line.type) {
      case _LineType.title:
        return isCompleted ? _kDimLine : Colors.white;
      case _LineType.subtitle:
        return isCompleted ? _kDimLine : _kPurple;
      case _LineType.system:
        return isCompleted ? _kDimLine : _kGrayText;
      case _LineType.granted:
        return _kPurple; // stays purple when done
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTitle = line.type == _LineType.title;
    final double fontSize = isTitle ? 27 : 12;
    final String fontFamily = isTitle ? 'sans-serif' : 'monospace';
    final FontWeight fw =
        isTitle ? FontWeight.w900 : FontWeight.normal;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: displayText,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: fontSize,
              fontWeight: fw,
              color: _textColor,
              letterSpacing: isTitle ? 2.5 : 0.6,
              height: 1.3,
            ),
          ),
          if (showCursor)
            TextSpan(
              text: '|',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: fontSize,
                color: _kPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SERVER CARD WIDGET
// ─────────────────────────────────────────────
class _ServerCard extends StatelessWidget {
  final String name;
  final String uptime;
  final AnimationController pulse;

  const _ServerCard({
    required this.name,
    required this.uptime,
    required this.pulse,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulse,
      builder: (context, _) {
        final dotAlpha = 0.50 + pulse.value * 0.50;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
          decoration: BoxDecoration(
            color: _kCardBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kPurpleMid, width: 1),
          ),
          child: Row(
            children: [
              // Pulsing green dot
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _kGreen.withValues(alpha: dotAlpha),
                  boxShadow: [
                    BoxShadow(
                      color: _kGreen.withValues(alpha: dotAlpha * 0.55),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 9,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      uptime,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: _kPurple,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// CUSTOM PAINTERS
// ─────────────────────────────────────────────

/// Background: radial purple glow + horizontal scan lines
class _BgPainter extends CustomPainter {
  final double glowAmt;
  _BgPainter(this.glowAmt);

  @override
  void paint(Canvas canvas, Size size) {
    // Radial glow
    if (glowAmt > 0) {
      final center = Offset(size.width / 2, size.height * 0.40);
      final radius = size.width * 0.85;
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            _kGlowCenter.withValues(alpha: glowAmt * 0.40),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawCircle(center, radius, paint);
    }

    // Horizontal scan lines — very faint
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..strokeWidth = 1;
    for (double y = 0; y < size.height; y += 5) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _BgPainter old) => old.glowAmt != glowAmt;
}

/// Diamond shape clipper for logo
class _DiamondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    return Path()
      ..moveTo(w / 2, 0)
      ..lineTo(w, h / 2)
      ..lineTo(w / 2, h)
      ..lineTo(0, h / 2)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> _) => false;
}

/// Sniper scope crosshair lines — top/bottom/left/right of logo
class _ScopePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kPurple
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final cy = size.height / 2;
    const gap = 50.0; // distance from center to line start
    const len = 20.0; // line length

    // Top
    canvas.drawLine(Offset(cx, cy - gap), Offset(cx, cy - gap - len), paint);
    // Bottom
    canvas.drawLine(Offset(cx, cy + gap), Offset(cx, cy + gap + len), paint);
    // Left
    canvas.drawLine(Offset(cx - gap, cy), Offset(cx - gap - len, cy), paint);
    // Right
    canvas.drawLine(Offset(cx + gap, cy), Offset(cx + gap + len, cy), paint);

    // Corner ticks at 45° (sniper reticle feel)
    final tickPaint = Paint()
      ..color = _kPurple.withValues(alpha: 0.4)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const diagGap = 34.0;
    const diagLen = 10.0;
    final diagAngle = math.pi / 4;

    for (int q = 0; q < 4; q++) {
      final angle = diagAngle + q * (math.pi / 2);
      final sx = cx + diagGap * math.cos(angle);
      final sy = cy + diagGap * math.sin(angle);
      final ex = cx + (diagGap + diagLen) * math.cos(angle);
      final ey = cy + (diagGap + diagLen) * math.sin(angle);
      canvas.drawLine(Offset(sx, sy), Offset(ex, ey), tickPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}
