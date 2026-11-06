import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/crest_header.dart';
import '../widgets/noir_theme.dart';
import '../widgets/british_flag.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLoginComplete;

  const LoginScreen({super.key, required this.onLoginComplete});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _enterController;

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  final FocusNode _idFocusNode = FocusNode();
  final FocusNode _codeFocusNode = FocusNode();

  int? _selectedPlatformIndex;
  String? _errorMessage;
  bool _isSubmitting = false;

  static const List<Map<String, dynamic>> _platforms = [
    {
      'name': 'المنصة الأولى',
      'asset': 'assets/platform_1.jpg',
      'badge': 'VIP 1',
      'bgColor': Color(0xFF261042),
    },
    {
      'name': 'المنصة الثانية',
      'asset': 'assets/platform_2.jpg',
      'badge': 'VIP 2',
      'bgColor': Color(0xFF35175C),
    },
  ];

  @override
  void initState() {
    super.initState();
    _enterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    if (isWidgetTest) {
      _enterController.value = 1.0;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          if (motionAllowed(context)) {
            _enterController.forward();
          } else {
            _enterController.value = 1.0;
          }
        }
      });
    }

    _idFocusNode.addListener(() => setState(() {}));
    _codeFocusNode.addListener(() => setState(() {}));
    _idController.addListener(() => setState(() {}));
    _codeController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _enterController.dispose();
    _idController.dispose();
    _codeController.dispose();
    _idFocusNode.dispose();
    _codeFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_isSubmitting) return;

    setState(() => _errorMessage = null);

    final id = _idController.text.trim();
    final code = _codeController.text.trim();

    if (_selectedPlatformIndex == null) {
      setState(() => _errorMessage = 'يرجى اختيار المنصة للمتابعة');
      return;
    }

    if (id.isEmpty) {
      setState(() => _errorMessage = 'يرجى إدخال معرف الحساب');
      return;
    }

    if (code.isEmpty) {
      setState(() => _errorMessage = 'يرجى إدخال كود التفعيل');
      return;
    }

    if (code.toLowerCase() != 'dark58') {
      setState(() => _errorMessage = 'كود التفعيل غير صحيح');
      return;
    }

    setState(() => _isSubmitting = true);

    await Future.delayed(const Duration(milliseconds: 650));
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
    await prefs.setString('user_id', id);
    await prefs.setString('app_code', code);
    await prefs.setString(
      'selected_platform',
      _platforms[_selectedPlatformIndex!]['name'] as String,
    );

    final hasCompletedSubscription =
        prefs.getBool('has_completed_subscription') ?? false;

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (!hasCompletedSubscription) {
      _openMandatorySubscriptionDialog();
    } else {
      widget.onLoginComplete();
    }
  }

  void _openMandatorySubscriptionDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.80),
      transitionDuration: const Duration(milliseconds: 320),
      pageBuilder: (context, anim1, anim2) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: MandatorySubscriptionDialog(
            onCompleted: () {
              Navigator.of(context).pop();
              widget.onLoginComplete();
            },
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        final curve =
            CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curve,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.15),
              end: Offset.zero,
            ).animate(curve),
            child: child,
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
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const CrestHeader(ringSize: 64),
              const SizedBox(height: 18),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // بطاقة تسجيل الدخول
                        Reveal(
                          parent: _enterController,
                          begin: 0.1,
                          end: 0.8,
                          child: _buildTicketCard(),
                        ),
                        const SizedBox(height: 22),

                        // شارة الحماية المشفرة السفلية (بدون أي لينكات كما طُلب)
                        Reveal(
                          parent: _enterController,
                          begin: 0.4,
                          end: 1.0,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: kGraphite,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: kEdge, width: 1),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.local_fire_department_rounded,
                                    size: 14,
                                    color: kOrangePrimary,
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      'جلسة مشفرة — بريطانيا التفاحة 🍎',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: arabic(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketCard() {
    return TicketCard(
      notchAt: 86,
      header: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const BritishFlagInline(size: 22),
              const SizedBox(width: 8),
              Text(
                'بريطانيا التفاحة',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: arabic(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(width: 8),
              const BritishFlagInline(size: 22),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Britain Apple — DARK',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: latin(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: kOrangeLight,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. اختر المنصة التابعة لك
          RailStep(
            stepNumber: 1,
            isCompleted: _selectedPlatformIndex != null,
            title: 'اختر المنصة التابعة لك',
            content: _buildPlatformSelector(),
          ),

          // 2. معرف الحساب
          RailStep(
            stepNumber: 2,
            isCompleted: _idController.text.trim().isNotEmpty,
            title: 'معرف الحساب',
            content: _buildInputField(
              controller: _idController,
              focusNode: _idFocusNode,
              icon: Icons.badge_outlined,
              label: 'معرف الحساب',
              hint: '1234567',
              keyboardType: TextInputType.number,
            ),
          ),

          // 3. كود التفعيل
          RailStep(
            stepNumber: 3,
            isCompleted: _codeController.text.trim().isNotEmpty,
            isLast: true,
            title: 'كود التفعيل',
            content: _buildInputField(
              controller: _codeController,
              focusNode: _codeFocusNode,
              icon: Icons.vpn_key_outlined,
              label: 'كود التفعيل',
              hint: 'dark58',
              keyboardType: TextInputType.text,
            ),
          ),
          const SizedBox(height: 16),

          // رسالة الخطأ إن وجدت
          if (_errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                color: kAlert.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: kAlert.withValues(alpha: 0.40),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 18, color: kAlert),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: arabic(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: kAlert,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
          ],

          // زر الدخول الناري الفاخر
          WineButton(
            text: _isSubmitting ? 'جاري التحقق...' : 'بدء تشغيل بريطانيا التفاحة',
            icon: Icons.bolt_rounded,
            onPressed: _isSubmitting ? null : _handleLogin,
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformSelector() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: kGraphite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kEdge, width: 1),
      ),
      child: Row(
        children: List.generate(_platforms.length, (index) {
          final p = _platforms[index];
          final isSelected = _selectedPlatformIndex == index;
          final Color bgColor = p['bgColor'] as Color;
          final String asset = p['asset'] as String;

          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() {
                _selectedPlatformIndex = index;
                _errorMessage = null;
              }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                decoration: BoxDecoration(
                  color: isSelected ? kSteelHi : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected ? kOrangePrimary : Colors.transparent,
                    width: 1.6,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: kOrangePrimary.withValues(alpha: 0.35),
                            blurRadius: 12,
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        color: bgColor,
                        child: AspectRatio(
                          aspectRatio: 1.45,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                asset,
                                fit: BoxFit.contain,
                                errorBuilder: (_, _, _) => Center(
                                  child: Text(
                                    p['badge'] as String,
                                    style: latin(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              if (!isSelected)
                                ColoredBox(
                                  color: kCoal.withValues(alpha: 0.40),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: isSelected ? kFlameGradient : null,
                        color: isSelected ? null : kGraphite,
                        border: Border.all(
                          color: isSelected ? Colors.white : kEdgeHi,
                          width: 1.2,
                        ),
                      ),
                      child: isSelected
                          ? const Center(
                              child: Icon(
                                Icons.check,
                                size: 12,
                                color: Colors.white,
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required IconData icon,
    required String label,
    required String hint,
    required TextInputType keyboardType,
  }) {
    final bool hasFocus = focusNode.hasFocus;
    final bool isFilled = controller.text.trim().isNotEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: hasFocus ? kSteelHi : kGraphite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: hasFocus ? kOrangePrimary : kEdge,
          width: hasFocus ? 1.6 : 1.0,
        ),
        boxShadow: hasFocus
            ? [
                BoxShadow(
                  color: kOrangePrimary.withValues(alpha: 0.25),
                  blurRadius: 14,
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 14,
                    color: hasFocus ? kOrangePrimary : kMute,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: arabic(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: hasFocus ? Colors.white : kAsh,
                    ),
                  ),
                ],
              ),
              if (isFilled)
                const Icon(
                  Icons.check_circle_rounded,
                  size: 15,
                  color: kOrangePrimary,
                ),
            ],
          ),
          const SizedBox(height: 2),
          Directionality(
            textDirection: TextDirection.ltr,
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: keyboardType,
              cursorColor: kOrangePrimary,
              style: latin(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: kChalk,
                letterSpacing: 1.2,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                border: InputBorder.none,
                hintText: hint,
                hintStyle: latin(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kMute,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// MandatorySubscriptionDialog — نافذة الاشتراك الإجباري
// ==========================================
class MandatorySubscriptionDialog extends StatefulWidget {
  final VoidCallback onCompleted;

  const MandatorySubscriptionDialog({
    super.key,
    required this.onCompleted,
  });

  @override
  State<MandatorySubscriptionDialog> createState() =>
      _MandatorySubscriptionDialogState();
}

class _MandatorySubscriptionDialogState
    extends State<MandatorySubscriptionDialog> {
  bool _clickedYtDark = false;
  bool _clickedTgMatches = false;
  bool _clickedTgDark = false;
  String? _dialogError;

  int get _doneCount {
    int c = 0;
    if (_clickedYtDark) c++;
    if (_clickedTgMatches) c++;
    if (_clickedTgDark) c++;
    return c;
  }

  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }

  void _onYtDarkClick() {
    _launchUrl('https://t.me/drk9_9');
    setState(() {
      _clickedYtDark = true;
      _dialogError = null;
    });
  }

  void _onTgMatchesClick() {
    _launchUrl('https://t.me/stark_Matches');
    setState(() {
      _clickedTgMatches = true;
      _dialogError = null;
    });
  }

  void _onTgDarkClick() {
    _launchUrl('https://t.me/drk9_9');
    setState(() {
      _clickedTgDark = true;
      _dialogError = null;
    });
  }

  Future<void> _onVerifyAndProceed() async {
    if (_doneCount < 3) {
      setState(() {
        _dialogError = 'يرجى إكمال جميع الشروط الـ 3 أولاً للمتابعة';
      });
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_completed_subscription', true);

    widget.onCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final allDone = _doneCount == 3;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 390),
          child: Container(
            margin: const EdgeInsets.all(22),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: kGlassGradient,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(
                color: allDone ? Colors.white : kEdge,
                width: 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.80),
                  blurRadius: 32,
                  offset: const Offset(0, 12),
                ),
                if (allDone)
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.20),
                    blurRadius: 20,
                  ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: allDone ? kSilverGradient : null,
                        color: allDone ? null : kSteelHi,
                        border: Border.all(
                          color: allDone ? Colors.white : kEdgeHi,
                          width: 1.4,
                        ),
                        boxShadow: allDone
                            ? [
                                BoxShadow(
                                  color: Colors.white.withValues(alpha: 0.40),
                                  blurRadius: 16,
                                ),
                              ]
                            : null,
                      ),
                      child: Icon(
                        allDone
                            ? Icons.verified_rounded
                            : Icons.local_fire_department_rounded,
                        color: allDone ? Colors.white : kOrangePrimary,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const BritishFlagInline(size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'صفحاتنا',
                        textAlign: TextAlign.center,
                        style: arabic(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const BritishFlagInline(size: 18),
                    ],
                  ),
                  const SizedBox(height: 6),

                  Text(
                    'انضم إلى صفحاتنا الرسمية للمتابعة وتفعيل الأداة',
                    textAlign: TextAlign.center,
                    style: arabic(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: kAsh,
                    ),
                  ),
                  const SizedBox(height: 14),

                  StepMeter(total: 3, current: _doneCount),
                  const SizedBox(height: 18),

                  // 1. الصفحة الرسمية الأولى (مموهة/بلور بدون إظهار اسم القناة)
                  _buildSubRow(
                    title: 'الصفحة الرسمية الأولى',
                    handle: 'اضغط هنا لفتح الرابط والانضمام',
                    icon: Icons.link_rounded,
                    color: kOrangePrimary,
                    isDone: _clickedYtDark,
                    btnText: _clickedYtDark ? 'تم الانضمام' : 'انضمام',
                    onTap: _onYtDarkClick,
                  ),
                  const SizedBox(height: 10),

                  // 2. صفحة التحديثات والمتابعة (مموهة/بلور بدون إظهار اسم القناة)
                  _buildSubRow(
                    title: 'صفحة التحديثات والمتابعة',
                    handle: 'اضغط هنا لفتح الرابط والانضمام',
                    icon: Icons.notifications_active_rounded,
                    color: kOrangeLight,
                    isDone: _clickedTgMatches,
                    btnText: _clickedTgMatches ? 'تم الانضمام' : 'انضمام',
                    onTap: _onTgMatchesClick,
                  ),
                  const SizedBox(height: 10),

                  // 3. قناة المجتمع والدعم (مموهة/بلور بدون إظهار اسم القناة)
                  _buildSubRow(
                    title: 'قناة المجتمع والدعم',
                    handle: 'اضغط هنا لفتح الرابط والانضمام',
                    icon: Icons.verified_rounded,
                    color: const Color(0xFF9C6FDE),
                    isDone: _clickedTgDark,
                    btnText: _clickedTgDark ? 'تم الانضمام' : 'انضمام',
                    onTap: _onTgDarkClick,
                  ),
                  const SizedBox(height: 16),

                  if (_dialogError != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: kAlert.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: kAlert.withValues(alpha: 0.40),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        _dialogError!,
                        textAlign: TextAlign.center,
                        style: arabic(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: kAlert,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],

                  WineButton(
                    text: 'تحقق ومتابعة',
                    icon: Icons.check_circle_rounded,
                    onPressed: _onVerifyAndProceed,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubRow({
    required String title,
    required String handle,
    required IconData icon,
    required Color color,
    required bool isDone,
    required String btnText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: kGraphite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDone ? Colors.white.withValues(alpha: 0.50) : kEdge,
            width: 1,
          ),
          boxShadow: [
            if (isDone)
              BoxShadow(
                color: kOrangePrimary.withValues(alpha: 0.20),
                blurRadius: 10,
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.20),
                border: Border.all(
                  color: color.withValues(alpha: 0.40),
                  width: 1,
                ),
              ),
              child: Icon(icon, color: color, size: 17),
            ),
            const SizedBox(width: 10),

            // بلور على النصوص بدون إظهار اسم القناة
            Expanded(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 4.5, sigmaY: 4.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: arabic(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: kChalk,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      handle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: arabic(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w500,
                        color: kAsh,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 8),

            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: isDone ? kSilverGradient : null,
                color: isDone ? null : kSteelHi,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDone ? Colors.white : kEdgeHi,
                  width: 1,
                ),
              ),
              child: Text(
                btnText,
                style: arabic(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isDone ? kOnSilver : kChalk,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
