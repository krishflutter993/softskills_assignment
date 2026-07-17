import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rto_assmant/providers/app_state_provider.dart';
import 'package:rto_assmant/widgets/glass_card.dart';
import 'package:rto_assmant/widgets/character_showcase.dart';

class LevelUpScreen extends StatelessWidget {
  final int oldLevel;
  final int newLevel;
  final String oldRank;
  final String newRank;

  const LevelUpScreen({
    super.key,
    required this.oldLevel,
    required this.newLevel,
    required this.oldRank,
    required this.newRank,
  });

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                // Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white70, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Title
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFFE594A5), Color(0xFFB19CD9)],
                  ).createShader(bounds),
                  child: const Text(
                    'Level Up!',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Subtitle
                Text(
                  'Your intellectual journey reaches new\nheights.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.7),
                    height: 1.4,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Center Card
                Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 80),
                      width: double.infinity,
                      child: GlassCard(
                        padding: const EdgeInsets.only(top: 80, bottom: 30),
                        borderRadius: BorderRadius.circular(30),
                        child: Column(
                          children: [
                            const Text(
                              'LEVEL',
                              style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 2,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                  colors: [Color(0xFFE594A5), Color(0xFFB19CD9)],
                              ).createShader(bounds),
                              child: Text(
                                '$newLevel',
                                style: const TextStyle(
                                  fontSize: 90,
                                  fontWeight: FontWeight.bold,
                                  height: 1.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                newRank,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Owl Image placeholder (Glowing Box)
                    Positioned(
                      top: 0,
                      child: Container(
                        height: 140,
                        width: 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFB19CD9).withOpacity(0.3),
                              blurRadius: 40,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: CharacterShowcase(
                          imagePath: appState.equippedSkinImagePath,
                          width: 240,
                          height: 140,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                Text(
                  "You've reached a new level!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Rewards Row
                Row(
                  children: [
                    Expanded(
                      child: GlassCard(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        borderRadius: BorderRadius.circular(24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.yellow.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.monetization_on, color: Colors.amber, size: 24),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Coins',
                                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                                ),
                                Text(
                                  '${appState.coins}',
                                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GlassCard(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        borderRadius: BorderRadius.circular(24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.cyan.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.diamond, color: Colors.cyanAccent, size: 24),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'diamond',
                                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                                ),
                                Text(
                                  '${appState.gems}',
                                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              
              const SizedBox(height: 40),
              
              // Awesome Button
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF9D84FF), Color(0xFFFF9CC8)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFB19CD9).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Awesome!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    ),
  );
}
}
