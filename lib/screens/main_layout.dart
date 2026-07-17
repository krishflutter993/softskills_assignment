import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rto_assmant/providers/app_state_provider.dart';
import 'package:rto_assmant/widgets/glass_widgets.dart';
import 'package:rto_assmant/screens/home_screen.dart';
import 'package:rto_assmant/screens/leaderboard_screen.dart';
import 'package:rto_assmant/screens/profile_screen.dart';
import 'package:rto_assmant/screens/shop_screen.dart';

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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(), // Placeholder for FAB
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
        ],
      ),
    );
  }
}
