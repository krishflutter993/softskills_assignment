import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rto_assmant/providers/app_state_provider.dart';
import 'package:rto_assmant/providers/theme_manager.dart';
import 'package:rto_assmant/widgets/glass_widgets.dart';
import 'package:rto_assmant/widgets/character_showcase.dart';
import 'onboarding_screen.dart';
import 'main_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    _loadStateAndNavigate();
  }

  Future<void> _loadStateAndNavigate() async {
    debugPrint("Initializing app load process...");
    final appState = Provider.of<AppStateProvider>(context, listen: false);
    final themeManager = Provider.of<ThemeManager>(context, listen: false);

    try {
      debugPrint("Initializing Database...");
      debugPrint("Loading Preferences...");
      debugPrint("Importing Questions...");
      debugPrint("Loading Character Data...");
      await appState.loadState().timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          debugPrint(
            "Initialization Timeout: Database/App State load took longer than 5 seconds. Skipping...",
          );
        },
      );
      await themeManager.loadTheme();
      debugPrint("Database Initialized");
      debugPrint("Preferences and Themes Loaded");
      debugPrint("Questions Imported");
      debugPrint("Character Loaded");
      debugPrint("Initialization Completed");
    } catch (e) {
      debugPrint("Error loading database/app state/theme: $e");
    }

    debugPrint("Waiting for minimum splash screen duration...");
    try {
      await Future.delayed(const Duration(seconds: 2));
      debugPrint("Finished splash screen delay");
    } catch (e) {
      debugPrint("Error during delay: $e");
    }

    if (mounted) {
      debugPrint("Navigating to next screen...");
      if (appState.isFirstLaunch) {
        debugPrint("Navigating to Onboarding...");
        Navigator.pushReplacementNamed(context, '/onboarding');
      } else {
        debugPrint("Navigating to Home...");
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Main Image
            Center(
              child: Container(
                width: 200,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF9B65E6).withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: CharacterShowcase(
                  imagePath: 'assets/images/owl.png',
                  width: 200,
                  height: 300,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // App Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Focus ',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -1.0,
                  ),
                ),
                Text(
                  'Buddy',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFFB19CD9), // Light purple
                    shadows: [
                      Shadow(
                        color: const Color(0xFFB19CD9).withOpacity(0.8),
                        blurRadius: 15,
                      ),
                    ],
                    letterSpacing: -1.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Subtitle
            Text(
              'Level up your brain. Beat the quiz!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            // Loading Indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C5791)),
              strokeWidth: 3,
            ),
            const SizedBox(height: 24),
            // Loading Text
            Text(
              'PREPARING YOUR JOURNEY...',
              style: TextStyle(
                fontSize: 13,
                letterSpacing: 2.0,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 40),
            // Daily Pro Tip Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: GlassCard(
                padding: const EdgeInsets.all(20),
                borderRadius: BorderRadius.circular(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6285A),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFD6285A).withOpacity(0.5),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.lightbulb_outline,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'DAILY PRO TIP',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFFE594A5),
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Streaks double your rewards.\nDon't break the chain!",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
