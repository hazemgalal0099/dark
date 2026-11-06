import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/crest_header.dart';
import '../widgets/noir_theme.dart';
import '../widgets/british_flag.dart';

class DarkApplePage extends StatefulWidget {
  final VoidCallback? onLogout;

  const DarkApplePage({super.key, this.onLogout});

  @override
  State<DarkApplePage> createState() => _DarkApplePageState();
}

class _DarkApplePageState extends State<DarkApplePage>
    with TickerProviderStateMixin {
  late final AnimationController _enterController;
  late final AnimationController _spinController;

  // 10 أرقام عشوائية من 0 لـ 4 (خانة واحدة فائزة لكل صف من الـ 10)
  late List<int> _winners;
  int _revealedRows = 0; // من 0 لـ 10

  bool _loggedIn = false;

  @override
  void initState() {
    super.initState();
    _generateWinners();
    _loadUserData();

    _enterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4600),
    );

    if (isWidgetTest) {
      _enterController.value = 1.0;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          if (motionAllowed(context)) {
            _enterController.forward();
            _spinController.repeat();
          } else {
            _enterController.value = 1.0;
          }
        }
      });
    }
  }

  void _generateWinners() {
    final rand = math.Random();
    _winners = List.generate(10, (_) => rand.nextInt(5));
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _loggedIn = prefs.getBool('is_logged_in') ?? false;
    });
  }

  @override
  void dispose() {
    _enterController.dispose();
    _spinController.dispose();
    super.dispose();
  }

  void _revealNextRow() {
    if (!_loggedIn) {
      _showLoginRequiredDialog();
      return;
    }

    if (_revealedRows >= 10) return;

    HapticFeedback.lightImpact();
    setState(() {
      _revealedRows = (_revealedRows + 1).clamp(0, 10);
    });
  }

  void _resetBoard() {
    HapticFeedback.selectionClick();
    setState(() {
      _revealedRows = 0;
      _generateWinners();
    });
  }

  void _showLoginRequiredDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: kSteel,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
              side: const BorderSide(color: Colors.white, width: 1.2),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: kSilverGradient,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.lock_outline_rounded,
                      color: kOnSilver,
                      size: 26,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'تسجيل الدخول',
                  style: arabic(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: kChalk,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'يرجى تسجيل الدخول أولاً لتشغيل أداة التفاحة',
                  textAlign: TextAlign.center,
                  style: arabic(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: kAsh,
                  ),
                ),
                const SizedBox(height: 16),
                WineButton(
                  text: 'حسناً',
                  compact: true,
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCoal,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: NoirCanvas(
          child: Stack(
            children: [
              // القائمة الرئيسية مع الترويسة والبطاقة الرئيسية والصفوف (بدون معرف الحساب تماماً)
              ListView(
                padding: const EdgeInsets.only(bottom: 110),
                children: [
                  const CrestHeader(ringSize: 62),
                  const SizedBox(height: 14),
                  _buildMainTicketCard(),
                ],
              ),

              // شريط تحكم عائم سفلي
              Positioned(
                bottom: 18,
                left: 18,
                right: 18,
                child: _buildFloatingControls(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainTicketCard() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: TicketCard(
            notchAt: 106,
            header: Stack(
              children: [
                Positioned.fill(
                  child: Center(
                    child: Opacity(
                      opacity: 0.045,
                      child: Text(
                        'BRITAIN APPLE',
                        style: brand(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 4.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Text(
                                  '🍎',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 6),
                                const BritishFlagInline(size: 15),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'سر التفاحة 🔥',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: arabic(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'اللوحة السينمائية التفاعلية — الإصدار الناري',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: arabic(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                          color: kOrangeLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          // الشارة [ 4 / 10 ]
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: kSilverPit,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: kSilver.withValues(alpha: 0.50),
                                width: 1,
                              ),
                            ),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                '$_revealedRows / 10',
                                style: latin(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: kChalk,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      StepMeter(total: 10, current: _revealedRows),
                    ],
                  ),
                ),
              ],
            ),
            body: Column(
              children: List.generate(10, (row) {
                final number = 10 - row;
                final revealed = _revealedRows >= number;
                final current = _revealedRows > 0 && _revealedRows == number;
                final winnerCell = _winners[row];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: _buildRowTrack(
                    number: number,
                    revealed: revealed,
                    current: current,
                    winnerCell: winnerCell,
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRowTrack({
    required int number,
    required bool revealed,
    required bool current,
    required int winnerCell,
  }) {
    final Color capBg = current
        ? Colors.transparent
        : (revealed ? kSilverPit : kGraphite);
    final Gradient? capGrad = current ? kSilverGradient : null;
    final Color capBorder = current
        ? Colors.white
        : (revealed ? kSilver.withValues(alpha: 0.60) : kEdge);
    final Color capTextColor = current
        ? kOnSilver
        : (revealed ? kSilverLight : kAsh);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double trackWidth = constraints.maxWidth - 54.0;
        final double cellSize = (trackWidth / 5.0 - 6.0).clamp(24.0, 48.0);

        return Row(
          children: [
            // 1. كبسولة رقم الصف
            Container(
              width: 46,
              height: cellSize + 8,
              decoration: BoxDecoration(
                color: capBg,
                gradient: capGrad,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: capBorder, width: 1.2),
                boxShadow: current
                    ? [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.30),
                          blurRadius: 10,
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'الصف',
                      style: arabic(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: capTextColor,
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        '$number',
                        style: latin(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: capTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),

            // 2. مضمار الخانات الخمس
            Expanded(
              child: Container(
                height: cellSize + 8,
                padding: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: current
                      ? kSteelHi
                      : (revealed ? const Color(0xFF24103A) : kGraphite),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: current
                        ? kSilver.withValues(alpha: 0.70)
                        : (revealed ? kSilver.withValues(alpha: 0.35) : kEdge),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: List.generate(5, (col) {
                    final bool isWinning = revealed && col == winnerCell;

                    return Expanded(
                      child: Center(
                        child: AppleOrb(
                          key: ValueKey('orb_${number}_$col'),
                          isWinning: isWinning,
                          isActiveRow: current,
                          size: cellSize,
                          spin: _spinController,
                          phase: (col * 0.2) + (number * 0.1),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFloatingControls() {
    final bool canReveal = _revealedRows < 10;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: kSteel.withValues(alpha: 0.96),
            borderRadius: BorderRadius.circular(34),
            border: Border.all(color: kEdgeHi, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.70),
                blurRadius: 26,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              // زر ابدأ الناري الفاخر
              Expanded(
                child: WineButton(
                  text: 'ابدأ',
                  icon: Icons.local_fire_department_rounded,
                  onPressed: canReveal ? _revealNextRow : null,
                ),
              ),
              const SizedBox(width: 12),

              // زر إعادة تعيين
              Tooltip(
                message: 'إعادة تعيين',
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kGraphite,
                    border: Border.all(color: kEdgeHi, width: 1.2),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: kAsh,
                      size: 22,
                    ),
                    onPressed: _resetBoard,
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

// ==========================================
// AppleOrb — خانة التفاحة المعدنية الفاخرة
// ==========================================
class AppleOrb extends StatefulWidget {
  final bool isWinning;
  final bool isActiveRow;
  final double size;
  final Animation<double> spin;
  final double phase;

  const AppleOrb({
    super.key,
    required this.isWinning,
    required this.isActiveRow,
    required this.size,
    required this.spin,
    this.phase = 0.0,
  });

  @override
  State<AppleOrb> createState() => _AppleOrbState();
}

class _AppleOrbState extends State<AppleOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _burnController;

  @override
  void initState() {
    super.initState();
    _burnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    if (widget.isWinning) {
      if (isWidgetTest) {
        _burnController.value = 1.0;
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            if (motionAllowed(context)) {
              _burnController.forward();
            } else {
              _burnController.value = 1.0;
            }
          }
        });
      }
    }
  }

  @override
  void didUpdateWidget(covariant AppleOrb oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isWinning && widget.isWinning) {
      if (motionAllowed(context)) {
        _burnController.forward(from: 0.0);
      } else {
        _burnController.value = 1.0;
      }
    } else if (oldWidget.isWinning && !widget.isWinning) {
      _burnController.reset();
    }
  }

  @override
  void dispose() {
    _burnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double s = widget.size;

    return SizedBox(
      width: s,
      height: s,
      child: AnimatedBuilder(
        animation: Listenable.merge([widget.spin, _burnController]),
        builder: (context, _) {
          final double t = _burnController.value;

          return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // الصورتين فقط بدون أي شكل تحتيهم
              _buildImages(s, t),

              // الاشتعال عند الفوز
              if (widget.isWinning && t > 0.0)
                Positioned.fill(
                  child: CustomPaint(painter: BlazePainter(t: t)),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildImages(double s, double t) {
    if (!widget.isWinning) {
      return Image.asset(
        'assets/cell_default.png',
        width: s,
        height: s,
        fit: BoxFit.contain,
        errorBuilder: (_, _, _) =>
            Icon(Icons.circle, color: kSteelHi, size: s * 0.7),
      );
    }

    final double oldOpacity = (1.0 - (t / 0.34)).clamp(0.0, 1.0);

    final double appleSubT = ((t - 0.42) / 0.45).clamp(0.0, 1.0);
    final double appleProgress = Curves.easeOutBack.transform(appleSubT);
    final double appleScale = 0.45 + (0.55 * appleProgress);
    final double appleRotation = -0.3 * (1.0 - appleSubT);
    final double appleOpacity = appleSubT.clamp(0.0, 1.0);

    return Stack(
      alignment: Alignment.center,
      children: [
        if (oldOpacity > 0.0)
          Opacity(
            opacity: oldOpacity,
            child: Image.asset(
              'assets/cell_default.png',
              width: s,
              height: s,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => const SizedBox.shrink(),
            ),
          ),
        if (t >= 0.42)
          Opacity(
            opacity: appleOpacity,
            child: Transform.rotate(
              angle: appleRotation,
              child: Transform.scale(
                scale: appleScale,
                child: Image.asset(
                  'assets/cell_apple.png',
                  width: s,
                  height: s,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.apple_rounded,
                    color: kSilverLight,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ==========================================
// BlazePainter — أنيميشن الاشتعال الناري
// ==========================================
class BlazePainter extends CustomPainter {
  final double t; // 0.0 -> 1.0

  static const Color _core = Color(0xFFFFFFFF);
  static const Color _flame = Color(0xFFB39DDB); // Soft lavender
  static const Color _ember = Color(0xFF7C4DC8); // Purple

  const BlazePainter({required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    if (t <= 0.0 || t >= 1.0) return;

    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;

    // 1. شرارة تلف الحافة
    if (t < 0.46) {
      final lap = (t / 0.38).clamp(0.0, 1.0);
      final headAngle = (-math.pi / 2) + (lap * 2 * math.pi);

      for (int k = 1; k <= 16; k++) {
        final back = k / 16.0;
        final tailAngle = headAngle - (back * 0.85);
        final alpha = math.pow(1.0 - back, 2) * 0.85;
        final tailPos = Offset(
          c.dx + r * math.cos(tailAngle),
          c.dy + r * math.sin(tailAngle),
        );

        final tailPaint = Paint()
          ..color = _flame.withValues(alpha: alpha.clamp(0.0, 1.0))
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
        canvas.drawCircle(tailPos, 3.0 * (1.0 - back), tailPaint);
      }

      final headPos = Offset(
        c.dx + r * math.cos(headAngle),
        c.dy + r * math.sin(headAngle),
      );
      final headHalo = Paint()
        ..color = Colors.white.withValues(alpha: 0.90)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
      canvas.drawCircle(headPos, 6, headHalo);

      final headCore = Paint()..color = _core;
      canvas.drawCircle(headPos, 2.5, headCore);
    }

    // 2. ألسنة وهج بلاتيني
    if (t >= 0.26 && t <= 0.78) {
      final kNorm = ((t - 0.26) / 0.52).clamp(0.0, 1.0);
      final double env = kNorm < 0.32
          ? (kNorm / 0.32)
          : (1.0 - ((kNorm - 0.32) / 0.68));

      final warmGlow = Paint()
        ..shader = RadialGradient(
          colors: [
            _flame.withValues(alpha: 0.35 * env),
            _ember.withValues(alpha: 0.18 * env),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: c, radius: r));
      canvas.drawCircle(c, r, warmGlow);

      final baseY = c.dy + (r * 0.52);

      for (int i = 0; i < 7; i++) {
        final xNorm = (i - 3) / 3.0;
        final baseX = c.dx + (xNorm * r * 0.65);

        for (int layer = 0; layer < 3; layer++) {
          final j = layer;
          final flick =
              0.62 + 0.38 * math.sin((t * 22.0) + (i * 1.7) + (j * 6.0));
          final maxAllowedH = r * 1.02;
          final layerScale = (3 - layer) / 3.0;
          final flameH = (r * 0.85 * flick * env * layerScale).clamp(
            0.0,
            maxAllowedH,
          );

          final Color layerColor = layer == 0
              ? _ember
              : (layer == 1 ? _flame : _core);

          final tipX = baseX + (math.sin(t * 14 + i) * 4.0);
          final tipY = baseY - flameH;

          final flamePath = Path();
          flamePath.moveTo(baseX - (7.0 * layerScale), baseY);
          flamePath.quadraticBezierTo(
            baseX - (4.0 * layerScale),
            baseY - (flameH * 0.5),
            tipX,
            tipY,
          );
          flamePath.quadraticBezierTo(
            baseX + (4.0 * layerScale),
            baseY - (flameH * 0.5),
            baseX + (7.0 * layerScale),
            baseY,
          );
          flamePath.close();

          final flamePaint = Paint()
            ..color = layerColor.withValues(alpha: env.clamp(0.0, 1.0))
            ..maskFilter = MaskFilter.blur(
              BlurStyle.normal,
              layer == 0 ? 3 : 1.5,
            );
          canvas.drawPath(flamePath, flamePaint);
        }
      }
    }

    // 3. موجة صدم
    if (t >= 0.44 && t <= 0.92) {
      final waveT = ((t - 0.44) / 0.48).clamp(0.0, 1.0);
      final waveProgress = Curves.easeOutCubic.transform(waveT);

      final waveRadius = (r * 0.34) + ((r * 1.29 - r * 0.34) * waveProgress);
      final waveWidth = (3.0 * (1.0 - waveProgress)).clamp(0.1, 3.0);
      final waveOpacity = (1.0 - waveProgress).clamp(0.0, 1.0) * 0.75;

      final wavePaint = Paint()
        ..color = _flame.withValues(alpha: waveOpacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = waveWidth;
      canvas.drawCircle(c, waveRadius, wavePaint);
    }
  }

  @override
  bool shouldRepaint(covariant BlazePainter oldDelegate) => oldDelegate.t != t;
}
