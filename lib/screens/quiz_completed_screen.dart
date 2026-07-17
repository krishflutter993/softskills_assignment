import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rto_assmant/providers/app_state_provider.dart';
import 'package:rto_assmant/widgets/glass_card.dart';
import 'package:rto_assmant/widgets/character_showcase.dart';

class QuizCompletedScreen extends StatelessWidget {
  final int score;
  final int correctCount;
  final int totalQuestions;
  final int xpEarned;
  final int coinsEarned;

  const QuizCompletedScreen({
    super.key,
    required this.score,
    required this.correctCount,
    required this.totalQuestions,
    required this.xpEarned,
    required this.coinsEarned,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                _buildHeader(context),
                const SizedBox(height: 30),
                _buildTrophy(context),
                const SizedBox(height: 20),
                const Text(
                  'Quiz Completed!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Excellent work on your Science Journey!',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 30),
                _buildScoreCard(),
                const SizedBox(height: 20),
                _buildEarnings(),
                const SizedBox(height: 30),
                _buildActionButtons(context),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1629),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1629),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(Icons.help_outline, color: Colors.cyanAccent, size: 16),
              const SizedBox(width: 8),
              const Text(
                'Support',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrophy(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.2),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: CharacterShowcase(
        imagePath: appState.equippedSkinImagePath,
        width: double.infinity,
        height: 180,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _buildScoreCard() {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      borderRadius: BorderRadius.circular(24),
      child: Column(
        children: [
          Text(
            'YOUR SCORE',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '$correctCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ' / $totalQuestions',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Great Performance!',
            style: TextStyle(
              color: Colors.cyanAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Divider(color: Colors.white.withOpacity(0.1)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Correct', '$correctCount', Colors.cyanAccent),
              _buildStatItem('Wrong', '${totalQuestions - correctCount}', Colors.redAccent),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Score', '$score', Colors.amber),
              _buildStatItem('Accuracy', '${(correctCount / totalQuestions * 100).toInt()}%', Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color valueColor) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarnings() {
    return Row(
      children: [
        Expanded(
          child: _buildEarningCard(Icons.monetization_on, Colors.amber, '$coinsEarned', 'Coins'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildEarningCard(Icons.auto_awesome, const Color(0xFFD1C4E9), '$xpEarned', 'XP'),
        ),
      ],
    );
  }

  Widget _buildEarningCard(IconData icon, Color iconColor, String amount, String label) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFF2A2346),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You Earned',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    amount,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [Color(0xFF8A4FFF), Color(0xFFD6285A)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8A4FFF).withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Review Answers',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton.icon(
            onPressed: () => Navigator.of(context).pushReplacementNamed('/home'), // Goes back to Home
            icon: const Icon(Icons.home_outlined, color: Color(0xFFD1C4E9)),
            label: const Text(
              'Back to Home',
              style: TextStyle(
                color: Color(0xFFD1C4E9),
                fontSize: 16,
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFF1E1A31),
              side: const BorderSide(color: Color(0xFF3B2F5B), width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
