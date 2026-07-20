import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_state_provider.dart';
import 'providers/theme_manager.dart';
import 'providers/countdown_provider.dart';
import 'database/database_helper.dart';
import 'repositories/character_repository.dart';
import 'services/character_service.dart';
import 'providers/shop_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/main_layout.dart';
import 'screens/quiz_categories_screen.dart';
import 'screens/quiz_playing_screen.dart';
import 'screens/quiz_completed_screen.dart';
import 'screens/level_up_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const FocusBuddyApp());
}

class FocusBuddyApp extends StatelessWidget {
  const FocusBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(
          create: (context) => CountdownProvider(
            onWeekEndedCallback: () async {
              final appState = Provider.of<AppStateProvider>(context, listen: false);
              await appState.loadState();
            },
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ShopProvider(
            characterService: CharacterService(
              repository: CharacterRepository(
                dbHelper: DatabaseHelper.instance,
              ),
            ),
            appStateProvider: Provider.of<AppStateProvider>(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Lumina Quiz',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6A4C93),
            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: Colors.transparent,
          useMaterial3: true,
          fontFamily: 'Inter',
        ),
        builder: (context, child) {
          return Consumer<ThemeManager>(
            builder: (context, themeManager, _) {
              final theme = themeManager.equippedTheme;
              return Stack(
                children: [
                  // Full-screen background image with smooth animated switcher (Fade + Scale interpolation)
                  Positioned.fill(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: Tween<double>(begin: 1.05, end: 1.0).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOutCubic,
                              ),
                            ),
                            child: child,
                          ),
                        );
                      },
                      child: Image.asset(
                        theme.backgroundImage,
                        key: ValueKey<String>(theme.backgroundImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Ambient scrim customized dynamically to theme specifications
                  Positioned.fill(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      color: Colors.black.withOpacity(theme.overlayOpacity + 0.4),
                    ),
                  ),
                  if (child != null) child,
                ],
              );
            },
          );
        },
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/home': (context) => const MainLayout(),
          '/categories': (context) => const QuizCategoriesScreen(),
          '/settings': (context) => const SettingsScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/quiz') {
            final args = settings.arguments as String?; // category ID
            return MaterialPageRoute(
              builder: (context) => QuizPlayingScreen(category: args ?? 'Science'),
            );
          } else if (settings.name == '/result') {
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (context) => QuizCompletedScreen(
                score: args?['score'] ?? 0,
                correctCount: args?['correctCount'] ?? 0,
                totalQuestions: args?['totalQuestions'] ?? 10,
                xpEarned: args?['xpEarned'] ?? 0,
                coinsEarned: args?['coinsEarned'] ?? 0,
              ),
            );
          } else if (settings.name == '/level_up') {
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (context) => LevelUpScreen(
                oldLevel: args?['oldLevel'] ?? 1,
                newLevel: args?['newLevel'] ?? 2,
                oldRank: args?['oldRank'] ?? 'Beginner',
                newRank: args?['newRank'] ?? 'Focus Warrior',
              ),
            );
          }
          return null; // Let the system handle unknown routes, or add a default
        },
      ),
    );
  }
}
