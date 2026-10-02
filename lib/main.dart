import 'dart:async';
import 'package:flutter/material.dart';
import 'Screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Flex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _iconScale;
  late final Animation<double> _iconFade;
  late final Animation<double> _textFade;
  late final Animation<double> _textScale;
  Timer? _routingTimer;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _initAnimationTimelines();
    _animationController.forward();

    _routingTimer = Timer(const Duration(seconds: 3), _navigateToOnboarding);
  }

  void _initAnimationTimelines() {
    _iconFade = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic),
    );

    _iconScale = Tween<double>(begin: 0.93, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.50, curve: Curves.easeOutCubic),
    ));

    _textFade = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.35, 0.85, curve: Curves.easeIn),
    );

    _textScale = Tween<double>(begin: 0.97, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.35, 1.0, curve: Curves.easeOutCubic),
    ));
  }

  void _navigateToOnboarding() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  @override
  void dispose() {
    _routingTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 162, 254),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _iconFade,
              child: ScaleTransition(
                scale: _iconScale,
                child: const _TravelFlexAppIcon(),
              ),
            ),
            const SizedBox(height: 38),
            FadeTransition(
              opacity: _textFade,
              child: ScaleTransition(
                scale: _textScale,
                child: const _ProBrandTitle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TravelFlexAppIcon extends StatelessWidget {
  const _TravelFlexAppIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 114,
      height: 114,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Colors.purple,
            blurRadius: 28,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
            ),
            const Icon(
              Icons.flight_takeoff_rounded,
              size: 42,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProBrandTitle extends StatelessWidget {
  const _ProBrandTitle();

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.purple, Colors.deepPurple],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: const Text(
        'TRAVEL FLEX',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: 3.5,
        ),
      ),
    );
  }
}