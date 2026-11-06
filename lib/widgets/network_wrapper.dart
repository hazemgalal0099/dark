import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'noir_theme.dart';

class NetworkWrapper extends StatefulWidget {
  final Widget child;

  const NetworkWrapper({super.key, required this.child});

  @override
  State<NetworkWrapper> createState() => _NetworkWrapperState();
}

class _NetworkWrapperState extends State<NetworkWrapper>
    with SingleTickerProviderStateMixin {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySub;
  bool _isDisconnected = false;
  bool _isChecking = false;
  bool _canShowDialog = false; // 5 ثواني بعد الفتح قبل ما يعرض أي حاجة
  late AnimationController _pulseController;
  Timer? _startupTimer;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    if (!isWidgetTest) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && motionAllowed(context)) {
          _pulseController.repeat(reverse: true);
        }
      });
    }

    // الانتظار 5 ثواني بعد الفتح
    if (!isWidgetTest) {
      _startupTimer = Timer(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() => _canShowDialog = true);
          _checkConnectivity();
        }
      });

      _connectivitySub = Connectivity().onConnectivityChanged.listen((results) {
        _handleConnectivityChange(results);
      });
    } else {
      // In widget test, don't set up connectivity timer/listener
      _connectivitySub = Stream<List<ConnectivityResult>>.empty().listen((_) {});
    }
  }

  @override
  void dispose() {
    _startupTimer?.cancel();
    _pulseController.dispose();
    _connectivitySub.cancel();
    super.dispose();
  }

  Future<void> _handleConnectivityChange(
      List<ConnectivityResult> results) async {
    if (!_canShowDialog) return;

    final hasNetwork = results.any((r) =>
        r == ConnectivityResult.mobile ||
        r == ConnectivityResult.wifi ||
        r == ConnectivityResult.ethernet ||
        r == ConnectivityResult.vpn);

    if (hasNetwork) {
      if (_isDisconnected && mounted) {
        setState(() => _isDisconnected = false);
      }
      return;
    }

    // تأكيد عدم وجود إنترنت
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted || !_canShowDialog) return;

    final doubleCheck = await Connectivity().checkConnectivity();
    final stillNoNetwork = !doubleCheck.any((r) =>
        r == ConnectivityResult.mobile ||
        r == ConnectivityResult.wifi ||
        r == ConnectivityResult.ethernet ||
        r == ConnectivityResult.vpn);

    if (stillNoNetwork && mounted) {
      setState(() => _isDisconnected = true);
    }
  }

  Future<void> _checkConnectivity() async {
    try {
      final results = await Connectivity().checkConnectivity();
      await _handleConnectivityChange(results);
    } catch (_) {}
  }

  Future<void> _retry() async {
    if (_isChecking) return;
    setState(() => _isChecking = true);

    try {
      final results = await Connectivity().checkConnectivity();
      final hasNetwork = results.any((r) =>
          r == ConnectivityResult.mobile ||
          r == ConnectivityResult.wifi ||
          r == ConnectivityResult.ethernet ||
          r == ConnectivityResult.vpn);

      if (mounted) {
        setState(() {
          _isDisconnected = !hasNetwork;
          _isChecking = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isChecking = false);
      }
    }
  }

  void _exitApp() {
    SystemNavigator.pop();
    try {
      exit(0);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      textDirection: TextDirection.rtl,
      children: [
        widget.child,
        if (_isDisconnected && _canShowDialog)
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: Container(
                color: Colors.black.withValues(alpha: 0.80),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: _buildDialogCard(),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDialogCard() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 380),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: kGlassGradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: kAlert.withValues(alpha: 0.50),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.70),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: kAlert.withValues(alpha: 0.20),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // دايرة نابضة فيها wifi_off بلون kAlert
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, _) {
              final pulse = _pulseController.value;
              return Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kAlert.withValues(alpha: 0.12),
                  border: Border.all(
                    color: kAlert.withValues(alpha: 0.40 + pulse * 0.40),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: kAlert.withValues(alpha: 0.30 * pulse),
                      blurRadius: 18 + (pulse * 8),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.wifi_off_rounded,
                  color: kAlert,
                  size: 34,
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          // 'لا يوجد إنترنت'
          Text(
            'لا يوجد إنترنت',
            textAlign: TextAlign.center,
            style: arabic(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: kChalk,
            ),
          ),
          const SizedBox(height: 10),

          // 'يرجى التحقق من الإنترنت ثم إعادة المحاولة لمتابعة استخدام التطبيق.'
          Text(
            'يرجى التحقق من الإنترنت ثم إعادة المحاولة لمتابعة استخدام التطبيق.',
            textAlign: TextAlign.center,
            style: arabic(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: kAsh,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),

          // زرارين: 'خروج من التطبيق' و 'إعادة المحاولة'
          Row(
            children: [
              // خروج من التطبيق
              Expanded(
                child: GestureDetector(
                  onTap: _exitApp,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: kGraphite,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: kEdgeHi, width: 1.2),
                    ),
                    child: Center(
                      child: Text(
                        'خروج من التطبيق',
                        style: arabic(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: kAsh,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // إعادة المحاولة
              Expanded(
                child: WineButton(
                  text: _isChecking ? 'جاري الفحص...' : 'إعادة المحاولة',
                  icon: Icons.refresh_rounded,
                  compact: true,
                  onPressed: _isChecking ? null : _retry,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
