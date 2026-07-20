class ThemeModel {
  final String id;
  final String name;
  final String image;
  final int price;
  final String currency; // 'coins' or 'diamonds'

  const ThemeModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.currency,
  });

  static const List<ThemeModel> availableThemes = [
    ThemeModel(
      id: 'default',
      name: 'Default',
      image: 'assets/Theme/screen.png',
      price: 0,
      currency: 'coins',
    ),
    // --- COINS THEMES FIRST ---
    ThemeModel(
      id: 'mint_bubbles',
      name: 'Mint Bubbles',
      image: 'assets/Theme/screen copy.png',
      price: 180,
      currency: 'coins',
    ),

    ThemeModel(
      id: 'ocean',
      name: 'Ocean',
      image: 'assets/Theme/screen copy 2.png',
      price: 420,
      currency: 'coins',
    ),

    ThemeModel(
      id: 'crystal_aqua',
      name: 'Crystal Aqua',
      image: 'assets/Theme/screen copy 3.png',
      price: 760,
      currency: 'coins',
    ),
    ThemeModel(
      id: 'lavender_mist',
      name: 'Lavender Mist',
      image: 'assets/Theme/screen copy 4.png',
      price: 30,
      currency: 'diamonds',
    ),

    ThemeModel(
      id: 'cosmic_night',
      name: 'Cosmic Night',
      image: 'assets/Theme/screen copy 5.png',
      price: 46,
      currency: 'diamonds',
    ),

    ThemeModel(
      id: 'emerald',
      name: 'Emerald',
      image: 'assets/Theme/screen copy 6.png',
      price: 980,
      currency: 'coins',
    ),

    ThemeModel(
      id: 'velvet_wave',
      name: 'Velvet Wave',
      image: 'assets/Theme/screen copy 7.png',
      price: 1350,
      currency: 'coins',
    ),

    ThemeModel(
      id: 'amber_glow',
      name: 'Amber Glow',
      image: 'assets/Theme/screen copy 8.png',
      price: 620,
      currency: 'coins',
    ),

    ThemeModel(
      id: 'aurora_crystals',
      name: 'Aurora Crystals',
      image: 'assets/Theme/screen copy 9.png',
      price: 890,
      currency: 'coins',
    ),

    ThemeModel(
      id: 'obsidian_gold',
      name: 'Obsidian Gold',
      image: 'assets/Theme/screen copy 11.png',
      price: 1650,
      currency: 'coins',
    ),
    ThemeModel(
      id: 'pink_satin',
      name: 'Pink Satin',
      image: 'assets/Theme/screen copy 10.png',
      price: 89,
      currency: 'diamonds',
    ),

    // --- DIAMOND THEMES FIRST ---
    ThemeModel(
      id: 'crystal_cave',
      name: 'Crystal Cave',
      image: 'assets/Theme/screen copy 12.png',
      price: 74,
      currency: 'diamonds',
    ),

    ThemeModel(
      id: 'shattered_space',
      name: 'Shattered Space',
      image: 'assets/Theme/screen copy 13.png',
      price: 52,
      currency: 'diamonds',
    ),

    ThemeModel(
      id: 'emerald_palace',
      name: 'Emerald Palace',
      image: 'assets/Theme/screen copy 16.png',
      price: 65,
      currency: 'diamonds',
    ),

    ThemeModel(
      id: 'obsidian_gold',
      name: 'Obsidian Gold',
      image: 'assets/Theme/screen copy 11.png',
      price: 97,
      currency: 'diamonds',
    ),

    ThemeModel(
      id: 'cosmic_crystals',
      name: 'Cosmic Crystals',
      image: 'assets/Theme/screen copy 17.png',
      price: 43,
      currency: 'diamonds',
    ),

    ThemeModel(
      id: 'royal_crown',
      name: 'Royal Crown',
      image: 'assets/Theme/screen copy 19.png',
      price: 108,
      currency: 'diamonds',
    ),

    ThemeModel(
      id: 'cosmic_dragon',
      name: 'Cosmic Dragon',
      image: 'assets/Theme/screen copy 20.png',
      price: 81,
      currency: 'diamonds',
    ),

    ThemeModel(
      id: 'fiery_phoenix',
      name: 'Fiery Phoenix',
      image: 'assets/Theme/screen copy 21.png',
      price: 136,
      currency: 'diamonds',
    ),

    ThemeModel(
      id: 'cyber_city',
      name: 'Cyber City',
      image: 'assets/Theme/screen copy 14.png',
      price: 118,
      currency: 'diamonds',
    ),

    ThemeModel(
      id: 'glacier_prism',
      name: 'Glacier Prism',
      image: 'assets/Theme/screen copy 15.png',
      price: 154,
      currency: 'diamonds',
    ),

    ThemeModel(
      id: 'rune_vortex',
      name: 'Rune Vortex',
      image: 'assets/Theme/screen copy 18.png',
      price: 199,
      currency: 'diamonds',
    ),
  ];
}
