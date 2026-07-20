import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rto_assmant/providers/app_state_provider.dart';
import 'package:rto_assmant/widgets/glass_widgets.dart';
import 'package:rto_assmant/screens/home_screen.dart';
import 'package:rto_assmant/screens/leaderboard_screen.dart';
import 'package:rto_assmant/screens/profile_screen.dart';
import 'package:rto_assmant/screens/shop_screen.dart';
import 'package:rto_assmant/l10n/app_localizations.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const LeaderboardScreen(),
    const SizedBox.shrink(), // Placeholder for FAB

    const ProfileScreen(),
    const ShopScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: IndexedStack(index: appState.currentTabIndex, children: _screens),
      floatingActionButton: GlassFAB(
        onTap: () {
          Navigator.pushNamed(context, '/categories');
        },
        child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 36),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: GlassBottomNavigationBar(
        currentIndex: appState.currentTabIndex,
        onTap: (index) {
          if (index == 2) return;
          appState.setTabIndex(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart_outlined),
            activeIcon: const Icon(Icons.bar_chart),
            label: AppLocalizations.of(context)!.stats,
          ),
          const BottomNavigationBarItem(
            icon: SizedBox.shrink(), // Placeholder for FAB
            label: '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: AppLocalizations.of(context)!.profile,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_bag_outlined),
            activeIcon: const Icon(Icons.shopping_bag),
            label: AppLocalizations.of(context)!.shop,
          ),
        ],
      ),
    );
  }
}
