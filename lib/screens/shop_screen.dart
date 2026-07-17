import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rto_assmant/providers/app_state_provider.dart';
import 'package:rto_assmant/providers/theme_manager.dart';
import 'package:rto_assmant/widgets/glass_widgets.dart';
import 'package:rto_assmant/widgets/glass_theme.dart';
import 'package:rto_assmant/widgets/character_showcase.dart';
import 'package:rto_assmant/database/database_helper.dart';
import 'package:rto_assmant/repositories/character_repository.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  bool _showCharacters = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Background handled by MainLayout
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildTabs(),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _showCharacters ? _buildGrid(context) : _buildThemesGrid(context),
                    const SizedBox(height: 30),
                    _buildFlashSale(),
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
          const Text(
            'Lumina Shop',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          // Coins & Gems count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text('${state.coins}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(width: 12),
                const Icon(Icons.diamond, color: Colors.cyanAccent, size: 16),
                const SizedBox(width: 4),
                Text('${state.gems}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
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
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showCharacters = true;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _showCharacters ? Colors.white.withOpacity(0.12) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Characters',
                    style: TextStyle(
                      color: _showCharacters ? Colors.white : Colors.white60,
                      fontWeight: _showCharacters ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showCharacters = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: !_showCharacters ? Colors.white.withOpacity(0.12) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Themes',
                    style: TextStyle(
                      color: !_showCharacters ? Colors.white : Colors.white60,
                      fontWeight: !_showCharacters ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    final state = context.watch<AppStateProvider>();
    final items = state.characters;

    if (items.isEmpty) {
      return const GlassEmptyState(
        icon: Icons.storefront_outlined,
        title: 'Empty Shop',
        description: 'No character skins are currently available in the shop.',
      );
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.82,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final String id = item['id'] as String;
        final int price = item['price'] as int? ?? 0;
        final String currency = item['currency'] as String? ?? 'coins';
        final bool isOwned = state.ownedOwlSkins.contains(id) || price == 0;
        final bool isEquipped = state.equippedOwlSkin == id;

        return GlassShopCard(
          name: item['name'] as String,
          priceText: '$price ${currency.toUpperCase()}',
          imageWidget: CharacterShowcase(
            imagePath: item['imagePath'] as String,
            width: double.infinity,
            height: 90,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12),
          ),
          isOwned: isOwned,
          isEquipped: isEquipped,
          onTap: () async {
            if (isEquipped) return;
            if (isOwned) {
              final db = await DatabaseHelper.instance.database;
              final repo = CharacterRepository(dbHelper: DatabaseHelper.instance);
              await repo.equipCharacter(id);
              await state.syncWithCharacterService();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Equipped ${item['name']}!")));
              }
            } else {
              // Purchase character logic
              if (currency == 'coins' && state.coins >= price) {
                state.deductCoins(price);
              } else if (currency == 'gems' && state.gems >= price) {
                state.deductGems(price);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Not enough currency.")));
                return;
              }
              final db = await DatabaseHelper.instance.database;
              await db.insert('user_characters', {
                'characterId': id,
                'isPurchased': 1,
                'createdAt': DateTime.now().toIso8601String(),
              });
              await state.syncWithCharacterService();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Purchased and unlocked ${item['name']}!")));
              }
            }
          },
        );
      },
    );
  }

  Widget _buildThemesGrid(BuildContext context) {
    final state = context.watch<AppStateProvider>();
    final themeManager = context.watch<ThemeManager>();

    final availableThemes = GlassThemeData.availableThemes;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.72,
      ),
      itemCount: availableThemes.length,
      itemBuilder: (context, index) {
        final theme = availableThemes[index];
        final isOwned = themeManager.isThemePurchased(theme.id);
        final isEquipped = themeManager.isThemeEquipped(theme.id);

        return GlassThemeCard(
          name: theme.name,
          priceText: '${theme.price} ${theme.currency.toUpperCase()}',
          imagePath: theme.backgroundImage,
          isOwned: isOwned,
          isEquipped: isEquipped,
          onTap: () async {
            if (isEquipped) return;
            if (isOwned) {
              await themeManager.equipTheme(theme.id);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Equipped ${theme.name}!")));
              }
            } else {
              final success = await themeManager.purchaseTheme(
                theme.id,
                state.coins,
                state.gems,
                (deductCoins, deductGems) {
                  if (deductCoins > 0) state.deductCoins(deductCoins);
                  if (deductGems > 0) state.deductGems(deductGems);
                },
              );
              if (success) {
                await themeManager.equipTheme(theme.id);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Purchased and equipped ${theme.name}!")));
                }
              } else {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Not enough currency.")));
                }
              }
            }
          },
          onPreview: () => _showThemePreview(context, theme),
        );
      },
    );
  }

  void _showThemePreview(BuildContext context, GlassThemeData theme) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                theme.backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  theme.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GlassCard(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              theme.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'iOS 26 Liquid Glass Premium Theme Pack. Includes custom blur settings (${theme.blurStrength}px), glass color overlay and accent tones.',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Consumer2<AppStateProvider, ThemeManager>(
                        builder: (context, appState, themeManager, _) {
                          final isOwned = themeManager.isThemePurchased(theme.id);
                          final isEquipped = themeManager.isThemeEquipped(theme.id);

                          return GlassButton(
                            text: isEquipped
                                ? 'EQUIPPED'
                                : isOwned
                                    ? 'EQUIP THEME'
                                    : 'UNLOCK FOR ${theme.price} ${theme.currency.toUpperCase()}',
                            onTap: () async {
                              if (isEquipped) return;
                              if (isOwned) {
                                await themeManager.equipTheme(theme.id);
                                if (mounted) Navigator.pop(context);
                              } else {
                                final success = await themeManager.purchaseTheme(
                                  theme.id,
                                  appState.coins,
                                  appState.gems,
                                  (deductCoins, deductGems) {
                                    if (deductCoins > 0) appState.deductCoins(deductCoins);
                                    if (deductGems > 0) appState.deductGems(deductGems);
                                  },
                                );
                                if (success) {
                                  await themeManager.equipTheme(theme.id);
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Purchased and equipped ${theme.name}!')),
                                    );
                                    Navigator.pop(context);
                                  }
                                } else {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Not enough currency.')),
                                    );
                                  }
                                }
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFlashSale() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFD6285A).withOpacity(0.3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Flash Sale',
              style: TextStyle(
                color: Color(0xFFE594A5),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Unlock Hero Pack',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Get 3 legendary characters and 500\nGems at 40% off!',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD6285A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  elevation: 10,
                  shadowColor: const Color(0xFFD6285A).withOpacity(0.5),
                ),
                child: const Text(
                  'Buy for \$9.99',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 80,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/hero_pack.png'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
