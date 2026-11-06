import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:darktools/screens/apple_screen.dart';
import 'package:darktools/screens/login_screen.dart';
import 'package:darktools/screens/splash_screen.dart';
import 'package:darktools/widgets/crest_header.dart';
import 'package:darktools/widgets/noir_theme.dart';

Widget _wrap(Widget child, [ThemeData? theme]) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    locale: const Locale('ar'),
    theme: theme ??
        ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: kOrangePrimary,
            brightness: Brightness.dark,
            primary: kOrangePrimary,
            secondary: kWhitePure,
            surface: kSteel,
            error: kAlert,
          ),
          scaffoldBackgroundColor: kCoal,
          useMaterial3: true,
        ),
    home: Directionality(
      textDirection: TextDirection.rtl,
      child: Material(child: child),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const List<Size> testSizes = [
    Size(320, 568),
    Size(390, 844),
    Size(430, 932),
    Size(768, 1024),
  ];

  group('1. الشاشات التلاتة بتترسم من غير أي exception على المقاسات', () {
    for (final size in testSizes) {
      testWidgets('SplashScreen على المقاس ${size.width}x${size.height}',
          (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(_wrap(SplashScreen(onComplete: () {})));
        await tester.pump();
        expect(tester.takeException(), isNull);
      });

      testWidgets('LoginScreen على المقاس ${size.width}x${size.height}',
          (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(_wrap(LoginScreen(onLoginComplete: () {})));
        await tester.pump();
        expect(tester.takeException(), isNull);
      });

      testWidgets('DarkApplePage على المقاس ${size.width}x${size.height}',
          (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        SharedPreferences.setMockInitialValues(
            {'is_logged_in': true, 'user_id': '1234567'});
        await tester.pumpWidget(_wrap(const DarkApplePage()));
        await tester.pump();
        expect(tester.takeException(), isNull);
      });
    }
  });

  group('2. صفحة الاسكربت فيها 50 خانة بالظبط، و الصف 10 و الصف 1 موجودين',
      () {
    testWidgets('فحص عدد الخانات والصفوف', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      SharedPreferences.setMockInitialValues(
          {'is_logged_in': true, 'user_id': '1234567'});
      await tester.pumpWidget(_wrap(const DarkApplePage()));
      await tester.pump();

      // 50 خانة AppleOrb بالظبط
      final orbs = find.byType(AppleOrb);
      expect(orbs, findsNWidgets(50));

      // التحقق من وجود 10 و 1 وتكرار كلمة الصف 10 مرات
      expect(find.text('10'), findsWidgets);
      expect(find.text('1'), findsWidgets);
      expect(find.text('الصف'), findsNWidgets(10));
    });
  });

  group('3. ترويسة البنر LogoRing', () {
    testWidgets('فحص بنر CrestHeader واللوجو', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(_wrap(
        const Align(
          alignment: Alignment.topLeft,
          child: CrestHeader(ringSize: 64),
        ),
      ));
      await tester.pump();

      final headerFinder = find.byType(CrestHeader);
      expect(headerFinder, findsOneWidget);

      final logoFinder = find.byType(LogoRing);
      expect(logoFinder, findsOneWidget);
    });
  });

  group('4. أزرار التحكم في صفحة DarkApplePage', () {
    testWidgets('فحص وجود زر التوقع وأزرار التحكم', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      SharedPreferences.setMockInitialValues(
          {'is_logged_in': true, 'user_id': '1234567'});
      await tester.pumpWidget(_wrap(const DarkApplePage()));
      await tester.pump();

      final startBtnFinder = find.widgetWithText(WineButton, 'ابدأ');
      expect(startBtnFinder, findsOneWidget);
    });
  });
}
