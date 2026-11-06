import 'package:flutter/material.dart';
import 'screens/apple_screen.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen_v3.dart';
import 'widgets/network_wrapper.dart';
import 'widgets/noir_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

enum _Screen { splash, login, app }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _Screen _screen = _Screen.splash;

  Future<void> _onSplashComplete() async {
    if (!mounted) return;
    setState(() => _screen = _Screen.login);
  }

  void _onLoginComplete() {
    if (!mounted) return;
    setState(() => _screen = _Screen.app);
  }

  void _onLogout() {
    if (!mounted) return;
    setState(() => _screen = _Screen.login);
  }

  Widget _buildCurrentScreen() {
    switch (_screen) {
      case _Screen.splash:
      return SplashScreenV3(onComplete: _onSplashComplete);
      case _Screen.login:
        return LoginScreen(onLoginComplete: _onLoginComplete);
      case _Screen.app:
        return DarkApplePage(onLogout: _onLogout);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Britain Apple',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kOrangePrimary,
          brightness: Brightness.dark,
          primary: kOrangePrimary,
          secondary: kFlameAmber,
          surface: kSteel,
          error: kAlert,
        ),
        scaffoldBackgroundColor: kCoal,
        useMaterial3: true,
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: NetworkWrapper(child: child ?? const SizedBox.shrink()),
        );
      },
      home: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: KeyedSubtree(
          key: ValueKey(_screen),
          child: _buildCurrentScreen(),
        ),
      ),
    );
  }
}
