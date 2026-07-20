import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rto_assmant/providers/app_state_provider.dart';
import 'package:rto_assmant/widgets/glass_widgets.dart';
import 'package:rto_assmant/widgets/character_showcase.dart';
import 'package:rto_assmant/l10n/app_localizations.dart';
import 'quiz_completed_screen.dart';
import 'level_up_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Consumer<AppStateProvider>(
              builder: (context, appState, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildHeader(context, appState),
                    const SizedBox(height: 30),
                    _buildLevelCard(context, appState),
                    const SizedBox(height: 30),
                    _buildContinueLearning(context, appState),
                    const SizedBox(height: 30),
                    _buildCategories(context),
                    const SizedBox(height: 30),
                    if (appState.currentStreak > 0) _buildDailyBonus(context, appState),
                    const SizedBox(height: 100), // padding for bottom nav
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppStateProvider appState) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CharacterShowcase(
              imagePath: appState.equippedSkinImagePath,
              width: 50,
              height: 50,
              border: Border.all(color: const Color(0xFF6A4C93), width: 2),
            ),
            Positioned(
              bottom: -4,
              left: 5,
              right: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFC3B1E1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'LV. ${appState.level}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF3B2F5B),
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.helloPlayer,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                l10n.letsPlayAndLearn,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1629),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(Icons.monetization_on, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text('${appState.coins}', style: const TextStyle(color: Colors.white, fontSize: 12)),
              const SizedBox(width: 12),
              const Icon(Icons.diamond, color: Colors.cyanAccent, size: 16),
              const SizedBox(width: 4),
              Text('${appState.gems}', style: const TextStyle(color: Colors.white, fontSize: 12)),
              const SizedBox(width: 12),
              const Icon(Icons.local_fire_department, color: Colors.deepOrange, size: 16),
              const SizedBox(width: 4),
              Text('${appState.currentStreak}', style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLevelCard(BuildContext context, AppStateProvider appState) {
    int maxXP = appState.level * 100;
    double progress = appState.xp / maxXP;
    if (progress > 1.0) progress = 1.0;

    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LevelUpScreen(
                    oldLevel: appState.level - 1 > 0 ? appState.level - 1 : 1,
                    newLevel: appState.level,
                    oldRank: appState.rankTitle,
                    newRank: appState.rankTitle,
                  ),
                ),
              );
            },
            child: CharacterShowcase(
              imagePath: appState.equippedSkinImagePath,
              width: 100,
              height: 60,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Level\n${appState.level}',
                      style: const TextStyle(
                        color: Color(0xFFD1C4E9),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                    Text(
                      appState.rankTitle.replaceAll(' ', '\n'),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        Container(
                          height: 8,
                          width: constraints.maxWidth,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Container(
                          height: 8,
                          width: constraints.maxWidth * progress,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF8A4FFF), Color(0xFFD1C4E9)],
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${appState.xp} / $maxXP XP',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueLearning(BuildContext context, AppStateProvider appState) {
    if (appState.quizHistory.isEmpty) return const SizedBox.shrink();

    final lastQuiz = appState.quizHistory.last;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Activity',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                appState.setTabIndex(3); // Navigate to Profile
              },
              child: const Text(
                'View History',
                style: TextStyle(
                  color: Color(0xFFD1C4E9),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GlassCard(
          padding: const EdgeInsets.all(16),
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00E5FF), Color(0xFF00B0FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyan.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(Icons.science_outlined, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${lastQuiz.category}\nQuiz',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Score: ${lastQuiz.score}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/quiz', arguments: lastQuiz.category);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade400,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text('Play Again'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categories = [
      {'name': 'Science', 'icon': Icons.science_outlined, 'colors': [const Color(0xFF00E5FF), const Color(0xFF00897B)]},
      {'name': 'Math', 'icon': Icons.functions, 'colors': [const Color(0xFF8A4FFF), const Color(0xFF512DA8)]},
      {'name': 'History', 'icon': Icons.history_edu, 'colors': [const Color(0xFFE594A5), const Color(0xFFC2185B)]},
      {'name': 'Tech', 'icon': Icons.devices, 'colors': [const Color(0xFFD1C4E9), const Color(0xFF7B1FA2)]},
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/categories');
              },
              child: const Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFFD1C4E9),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: categories.map((cat) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/quiz', arguments: cat['name']);
              },
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: cat['colors'] as List<Color>,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Icon(cat['icon'] as IconData, color: Colors.white, size: 30),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cat['name'] as String,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDailyBonus(BuildContext context, AppStateProvider appState) {
    final bool claimed = appState.isDailyBonusClaimed;
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF2A2346),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.card_giftcard, color: Color(0xFFD1C4E9), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daily Bonus',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Streak: ${appState.currentStreak} Days',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: claimed
                ? null
                : () async {
                    final success = await appState.claimDailyBonus();
                    if (success && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('🎉 50 Coins Claimed Successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: claimed ? Colors.grey : const Color(0xFFC3B1E1),
              foregroundColor: claimed ? Colors.white60 : const Color(0xFF512DA8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Text(
              claimed ? 'Claimed' : 'Claim 50 🪙',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

