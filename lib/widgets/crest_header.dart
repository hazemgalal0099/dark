import 'package:flutter/material.dart';
import 'noir_theme.dart';
import 'british_flag.dart';

// ==========================================
// CrestHeader — بنر Britain Apple الفاخر
// ==========================================
class CrestHeader extends StatelessWidget {
  final double ringSize;

  const CrestHeader({
    super.key,
    this.ringSize = 64,
  });

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    final bannerHeight = topInset + 170.0;
    final halfRing = ringSize / 2;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SizedBox(
            width: double.infinity,
            height: bannerHeight + halfRing + 12,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 1. حاوية البنر الصوري مع إطار لافندر فاخر
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: bannerHeight,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      border: Border(
                        bottom: BorderSide(
                          color: kOrangePrimary.withValues(alpha: 0.55),
                          width: 1.5,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.75),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: kOrangePrimary.withValues(alpha: 0.28),
                          blurRadius: 24,
                          spreadRadius: -2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // صورة البنر البريطاني
                          Image.asset(
                            'assets/banner_uk.jpg',
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            errorBuilder: (_, _, _) => Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF1A0A2E),
                                    Color(0xFF2D1550),
                                    Color(0xFF4A1E8A),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // طبقة تظليل لافندر متدرجة
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withValues(alpha: 0.45),
                                  const Color(0xFF1A0A2E).withValues(alpha: 0.15),
                                  Colors.black.withValues(alpha: 0.80),
                                ],
                                stops: const [0.0, 0.45, 1.0],
                              ),
                            ),
                          ),

                          // تعتيم جانبي
                          Container(
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                center: Alignment.center,
                                radius: 1.2,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.50),
                                ],
                                stops: const [0.65, 1.0],
                              ),
                            ),
                          ),

                          // الشارات العلوية
                          SafeArea(
                            bottom: false,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14.0,
                                vertical: 6.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // شارة VIP اليمين
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 9,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.65),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: kOrangeLight.withValues(alpha: 0.70),
                                        width: 1.0,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: kOrangePrimary.withValues(alpha: 0.35),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.workspace_premium_rounded,
                                          size: 13,
                                          color: Colors.amberAccent,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'VIP',
                                          style: latin(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // شارة BRITAIN APPLE مع علم بريطانيا
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.65),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: kOrangePrimary.withValues(alpha: 0.65),
                                        width: 1.0,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: kOrangePrimary.withValues(alpha: 0.25),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const BritishFlagInline(size: 14),
                                        const SizedBox(width: 5),
                                        Text(
                                          'BRITAIN APPLE',
                                          style: latin(
                                            fontSize: 10.5,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                            letterSpacing: 0.6,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // 2. خط نور متدرج لافندر أسفل حافة البنر
                Positioned(
                  top: bannerHeight - 1,
                  left: 20,
                  right: 20,
                  child: Container(
                    height: 1.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          kOrangePrimary.withValues(alpha: 0.7),
                          kOrangeLight,
                          kOrangePrimary.withValues(alpha: 0.7),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
                      ),
                    ),
                  ),
                ),

                // 3. LogoRing في المنتصف
                Positioned(
                  top: bannerHeight - halfRing,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                      width: ringSize,
                      height: ringSize,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          // قاعدة دائرية
                          Container(
                            width: ringSize + 12,
                            height: ringSize + 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kCoal,
                              boxShadow: [
                                BoxShadow(
                                  color: kOrangePrimary.withValues(alpha: 0.60),
                                  blurRadius: 26,
                                  spreadRadius: 3,
                                ),
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.85),
                                  blurRadius: 14,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                          LogoRing(size: ringSize),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
