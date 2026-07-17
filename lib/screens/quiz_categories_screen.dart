import 'package:flutter/material.dart';
import 'package:rto_assmant/widgets/glass_card.dart';

class QuizCategoriesScreen extends StatelessWidget {
  const QuizCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'id': 'Science',
        'name': 'Science',
        'icon': Icons.science_outlined,
        'colors': [const Color(0xFF00E5FF), const Color(0xFF00897B)],
      },
      {
        'id': 'Math',
        'name': 'Math',
        'icon': Icons.functions,
        'colors': [const Color(0xFF8A4FFF), const Color(0xFF512DA8)],
      },
      {
        'id': 'History',
        'name': 'History',
        'icon': Icons.history_edu,
        'colors': [const Color(0xFFE594A5), const Color(0xFFC2185B)],
      },
      {
        'id': 'Tech',
        'name': 'Tech',
        'icon': Icons.devices,
        'colors': [const Color(0xFFD1C4E9), const Color(0xFF7B1FA2)],
      },
      {
        'id': 'Art',
        'name': 'Art',
        'icon': Icons.color_lens,
        'colors': [const Color(0xFFFF9A9E), const Color(0xFFFECFEF)],
      },
      {
        'id': 'Music',
        'name': 'Music',
        'icon': Icons.music_note,
        'colors': [const Color(0xFF4FACFE), const Color(0xFF00F2FE)],
      },
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final cat = categories[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/quiz', arguments: cat['id']);
                },
                child: GlassCard(
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: cat['colors'] as List<Color>,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Icon(
                          cat['icon'] as IconData,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        cat['name'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
