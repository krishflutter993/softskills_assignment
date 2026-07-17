import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rto_assmant/providers/app_state_provider.dart';
import 'package:rto_assmant/widgets/glass_widgets.dart';
import 'package:rto_assmant/widgets/character_showcase.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppStateProvider>();
    
    // Generate mock players and inject the current user
    final List<Map<String, dynamic>> allPlayers = [
      {'name': 'Arjun', 'score': 2150, 'image': 'assets/images/owl.png', 'background': 'assets/Theme/screen.png', 'isCurrentUser': false},
      {'name': 'Priya', 'score': 2100, 'image': 'assets/images/owl.png', 'background': 'assets/Theme/screen.png', 'isCurrentUser': false},
      {'name': 'Rohan', 'score': 1950, 'image': 'assets/images/owl.png', 'background': 'assets/Theme/screen.png', 'isCurrentUser': false},
      {'name': 'Sneha', 'score': 1700, 'image': 'assets/images/owl.png', 'background': 'assets/Theme/screen.png', 'isCurrentUser': false},
      {'name': 'Karan', 'score': 1500, 'image': 'assets/images/owl.png', 'background': 'assets/Theme/screen.png', 'isCurrentUser': false},
      {'name': 'Meera', 'score': 1200, 'image': 'assets/images/owl.png', 'background': 'assets/Theme/screen.png', 'isCurrentUser': false},
      {'name': 'Player (You)', 'score': state.xp, 'image': state.equippedSkinImagePath, 'background': state.equippedCharacterBackground, 'isCurrentUser': true},
    ];
    
    // Sort players by score descending
    allPlayers.sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));
    
    // Assign ranks
    for (int i = 0; i < allPlayers.length; i++) {
      allPlayers[i]['rank'] = i + 1;
    }

    return Scaffold(
      backgroundColor: Colors.transparent, // Hosted in MainLayout
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildTabs(),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildPodium(allPlayers.take(3).toList()),
                    const SizedBox(height: 30),
                    _buildList(allPlayers.skip(3).toList()),
                    const SizedBox(height: 20),
                    _buildBonusCard(),
                    const SizedBox(height: 100), // padding for bottom nav
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final state = context.watch<AppStateProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1629),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
          const Text(
            'Leaderboard',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1629),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.diamond, color: Colors.cyanAccent, size: 16),
                const SizedBox(width: 6),
                Text('${state.gems}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GlassCard(
        height: 50,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8A4FFF), Color(0xFF6A4C93)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Weekly',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Monthly',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPodium(List<Map<String, dynamic>> topPlayers) {
    if (topPlayers.length < 3) return const SizedBox(); // Fallback if not enough players

    final rank1 = topPlayers[0];
    final rank2 = topPlayers[1];
    final rank3 = topPlayers[2];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Rank 2
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: _buildPodiumItem(
            name: rank2['name'],
            score: '${rank2['score']}',
            image: rank2['image'],
            background: rank2['background'],
            rank: 2,
            size: 80,
            borderColor: Colors.blueGrey.shade200,
            badgeColor: Colors.blueGrey.shade300,
            isCenter: rank2['isCurrentUser'],
          ),
        ),
        const SizedBox(width: 16),
        // Rank 1
        _buildPodiumItem(
          name: rank1['name'],
          score: '${rank1['score']}',
          image: rank1['image'],
          background: rank1['background'],
          rank: 1,
          size: 110,
          borderColor: Colors.amber,
          badgeColor: Colors.amber,
          isCenter: rank1['isCurrentUser'],
          isRank1: true,
        ),
        const SizedBox(width: 16),
        // Rank 3
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: _buildPodiumItem(
            name: rank3['name'],
            score: '${rank3['score']}',
            image: rank3['image'],
            background: rank3['background'],
            rank: 3,
            size: 75,
            borderColor: Colors.deepOrange,
            badgeColor: Colors.deepOrangeAccent,
            isCenter: rank3['isCurrentUser'],
          ),
        ),
      ],
    );
  }

  Widget _buildPodiumItem({
    required String name,
    required String score,
    required String image,
    required String background,
    required int rank,
    required double size,
    required Color borderColor,
    required Color badgeColor,
    bool isCenter = false,
    bool isRank1 = false,
  }) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: borderColor, width: isRank1 ? 4 : 3),
                boxShadow: (isRank1 || isCenter)
                    ? [
                        BoxShadow(
                          color: (isRank1 ? Colors.amber : Colors.cyanAccent).withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ]
                    : [],
                image: DecorationImage(
                  image: AssetImage(background),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            if (isRank1)
              const Positioned(
                top: -15,
                child: Icon(Icons.stars, color: Colors.amber, size: 32),
              ),
            Positioned(
              bottom: -10,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: badgeColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF13111C), width: 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  rank.toString(),
                  style: const TextStyle(
                    color: Color(0xFF13111C),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: TextStyle(
            color: isCenter ? const Color(0xFFD1C4E9) : Colors.white,
            fontSize: isCenter ? 18 : 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          score,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildList(List<Map<String, dynamic>> restPlayers) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: restPlayers.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final player = restPlayers[index];
        final bool isCurrentUser = player['isCurrentUser'];

        return GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          borderRadius: BorderRadius.circular(16),
          color: isCurrentUser ? Colors.cyan.withOpacity(0.15) : null,
          border: Border.all(color: isCurrentUser ? Colors.cyanAccent.withOpacity(0.5) : Colors.white.withOpacity(0.15)),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                child: Text(
                  player['rank'].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              CharacterShowcase(
                imagePath: player['image'] as String,
                width: 40,
                height: 40,
                border: Border.all(color: const Color(0xFF6A4C93), width: 1.5),
              ),
              const SizedBox(width: 16),
              Text(
                player['name'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Text(
                '${player['score']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.stars, color: Color(0xFFD1C4E9), size: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBonusCard() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.cyan.withOpacity(0.3)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Top 10 get bonus rewards!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'End of week: 2d 14h',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2346),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.card_giftcard, color: Colors.cyanAccent),
          ),
        ],
      ),
    );
  }
}
