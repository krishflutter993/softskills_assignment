import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rto_assmant/providers/app_state_provider.dart';
import 'package:rto_assmant/widgets/glass_widgets.dart';
import 'package:rto_assmant/widgets/character_showcase.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Handled by MainLayout
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                _buildHeader(),
                const SizedBox(height: 24),
                _buildBanner(),
                const SizedBox(height: 16),
                _buildProfileInfo(context),
                const SizedBox(height: 24),
                _buildLevelCard(context),
                const SizedBox(height: 16),
                _buildCurrencyRow(context),
                const SizedBox(height: 24),
                _buildStatistics(context),
                const SizedBox(height: 24),
                _buildAchievements(context),
                const SizedBox(height: 100), // padding for bottom nav
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color(0xFF1A1629),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
        ),
        const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color(0xFF1A1629),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.settings_outlined, color: Colors.white, size: 20),
        ),
      ],
    );
  }

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF3B2F5B), Color(0xFF13111C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    final state = context.watch<AppStateProvider>();
    return Column(
      children: [
        CharacterShowcase(
          imagePath: state.equippedSkinImagePath,
          width: 80,
          height: 80,
          border: Border.all(color: const Color(0xFF6A4C93), width: 3),
        ),
        const SizedBox(height: 16),
        const Text(
          'Player', // Using a default since we don't prompt for name yet
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.military_tech, color: Color(0xFFE594A5), size: 16),
            const SizedBox(width: 4),
            Text(
              state.rankTitle,
              style: const TextStyle(
                color: Color(0xFFE594A5),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLevelCard(BuildContext context) {
    final state = context.watch<AppStateProvider>();
    final int requiredXp = state.level * 100;
    final double progress = (state.xp / requiredXp).clamp(0.0, 1.0);

    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LEVEL ${state.level}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 12,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                state.rankTitle,
                style: const TextStyle(
                  color: Color(0xFFD1C4E9),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${state.xp} / $requiredXp XP',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
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
        ],
      ),
    );
  }

  Widget _buildCurrencyRow(BuildContext context) {
    final state = context.watch<AppStateProvider>();
    return Row(
      children: [
        Expanded(
          child: _buildCurrencyCard(Icons.monetization_on, Colors.amber, 'Coins', '${state.coins}'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildCurrencyCard(Icons.diamond, Colors.cyanAccent, 'Gems', '${state.gems}'),
        ),
      ],
    );
  }

  Widget _buildCurrencyCard(IconData icon, Color iconColor, String title, String amount) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFF2A2346),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                amount,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics(BuildContext context) {
    final state = context.watch<AppStateProvider>();
    int quizzesPlayed = state.quizHistory.length;
    int correctAnswers = state.quizHistory.fold(0, (sum, quiz) => sum + quiz.correctCount);
    int totalQuestions = state.quizHistory.fold(0, (sum, quiz) => sum + quiz.totalQuestions);
    
    int bestScore = state.quizHistory.isEmpty ? 0 : state.quizHistory.map((q) => q.score).reduce((a, b) => a > b ? a : b);
    
    String accuracyStr = totalQuestions > 0 ? '${((correctAnswers / totalQuestions) * 100).toInt()}%' : '0%';

    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STATISTICS',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildStatRow(Icons.menu_book_outlined, 'Quizzes Played', '$quizzesPlayed'),
          const SizedBox(height: 20),
          _buildStatRow(Icons.check_circle_outline, 'Correct Answers', '$correctAnswers'),
          const SizedBox(height: 20),
          _buildStatRow(Icons.emoji_events_outlined, 'Best Score', '$bestScore'),
          const SizedBox(height: 20),
          _buildStatRow(Icons.auto_graph, 'Accuracy', accuracyStr),
        ],
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.6), size: 20),
        const SizedBox(width: 16),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 16,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAchievements(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ACHIEVEMENTS',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'View All',
              style: TextStyle(
                color: Color(0xFFD1C4E9),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildAchievementBadge(context, isLocked: false),
            _buildAchievementBadge(context, isLocked: false),
            _buildAchievementBadge(context, isLocked: false),
            _buildAchievementBadge(context, isLocked: true),
            _buildAchievementBadge(context, isLocked: true),
          ],
        ),
      ],
    );
  }

  Widget _buildAchievementBadge(BuildContext context, {required bool isLocked}) {
    final state = Provider.of<AppStateProvider>(context);
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1A31),
        shape: BoxShape.circle,
        border: Border.all(
          color: isLocked ? Colors.transparent : Colors.cyan.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: isLocked
            ? []
            : [
                BoxShadow(
                  color: Colors.cyan.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ],
      ),
      alignment: Alignment.center,
      child: isLocked
          ? Icon(Icons.lock_outline, color: Colors.white.withOpacity(0.2), size: 24)
          : Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(state.equippedSkinImagePath), // Using the dynamic avatar
                  fit: BoxFit.contain,
                ),
                shape: BoxShape.circle,
              ),
            ),
    );
  }
}
