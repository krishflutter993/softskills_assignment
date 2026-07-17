import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rto_assmant/providers/app_state_provider.dart';

class ThemesScreen extends StatelessWidget {
  const ThemesScreen({super.key});

  static final List<Map<String, dynamic>> themes = [
    
  ];

  void _showPurchaseDialog(
    BuildContext context,
    AppStateProvider appState,
    Map<String, dynamic> theme,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final isCoins = theme['currency'] == 'coins';
        final currencyIcon = isCoins
            ? const Icon(Icons.monetization_on, color: Colors.amber, size: 18)
            : const Icon(Icons.diamond, color: Colors.cyanAccent, size: 18);

        return AlertDialog(
          backgroundColor: const Color(0xFF1E1A31),
          title: Text(
            'Unlock ${theme['name']}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Cost: ', style: TextStyle(color: Colors.white70)),
              currencyIcon,
              const SizedBox(width: 4),
              Text(
                '${theme['price']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white54),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A4C93),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                final success = await appState.purchaseTheme(
                  theme['path']!,
                  theme['price']!,
                  theme['currency']!,
                );
                if (success && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('🎉 Unlocked & Applied ${theme['name']}!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  await appState.equipBackground(theme['path']!);
                } else if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('❌ Not enough ${theme['currency']}!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text(
                'Unlock',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF13111C),
      appBar: AppBar(
        title: const Text(
          'Select Theme',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1A1629),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.monetization_on,
                      color: Colors.amber,
                      size: 14,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${appState.coins}',
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.diamond,
                      color: Colors.cyanAccent,
                      size: 14,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${appState.gems}',
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(appState.equippedBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: themes.length,
          itemBuilder: (context, index) {
            final theme = themes[index];
            final isEquipped = appState.equippedBackground == theme['path'];
            final isOwned =
                appState.ownedThemes.contains(theme['path']) ||
                theme['price'] == 0;

            return GestureDetector(
              onTap: () async {
                if (isOwned) {
                  await appState.equipBackground(theme['path']!);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('🎉 ${theme['name']} theme applied!'),
                        backgroundColor: Colors.purple,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  }
                } else {
                  _showPurchaseDialog(context, appState, theme);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isEquipped
                        ? const Color(0xFFB19CD9)
                        : (isOwned
                              ? Colors.white.withOpacity(0.2)
                              : Colors.amber.withOpacity(0.4)),
                    width: isEquipped ? 3 : 1.5,
                  ),
                  boxShadow: isEquipped
                      ? [
                          BoxShadow(
                            color: const Color(0xFFB19CD9).withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Preview background image
                      Image.asset(theme['path']!, fit: BoxFit.cover),
                      // Dark Overlay for text legibility
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      // Theme Name
                      Positioned(
                        bottom: 12,
                        left: 12,
                        right: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              theme['name']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (isEquipped)
                              const Text(
                                'Equipped',
                                style: TextStyle(
                                  color: Color(0xFFB19CD9),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            else if (isOwned)
                              const Text(
                                'Owned',
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 12,
                                ),
                              )
                            else
                              Row(
                                children: [
                                  theme['currency'] == 'coins'
                                      ? const Icon(
                                          Icons.monetization_on,
                                          color: Colors.amber,
                                          size: 14,
                                        )
                                      : const Icon(
                                          Icons.diamond,
                                          color: Colors.cyanAccent,
                                          size: 14,
                                        ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${theme['price']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      // Locked Overlay
                      if (!isOwned)
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.lock,
                              color: Colors.amber,
                              size: 16,
                            ),
                          ),
                        ),
                      // Check icon if equipped
                      if (isEquipped)
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFFB19CD9),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
