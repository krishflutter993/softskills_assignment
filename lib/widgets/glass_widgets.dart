import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rto_assmant/providers/theme_manager.dart';

// 1. GlassContainer
class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final BoxBorder? border;
  final Color? color;
  final double? blur;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.width,
    this.height,
    this.border,
    this.color,
    this.blur,
  });

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    final activeTheme = themeManager.equippedTheme;

    final effectiveRadius = borderRadius ?? BorderRadius.circular(20);
    final effectiveBlur = blur ?? activeTheme.blurStrength;
    final effectiveColor = color ?? activeTheme.glassTint.withOpacity(activeTheme.overlayOpacity);

    return Container(
      margin: margin,
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: effectiveRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: effectiveBlur, sigmaY: effectiveBlur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: effectiveColor,
              borderRadius: effectiveRadius,
              border: border ?? Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 1.0,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

// 2. GlassCard
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final BoxBorder? border;
  final Color? color;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.width,
    this.height,
    this.border,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin,
      borderRadius: borderRadius ?? BorderRadius.circular(24),
      width: width,
      height: height,
      border: border,
      color: color,
      child: child,
    );
  }
}

// 3. GlassButton
class GlassButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final bool isSecondary;

  const GlassButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    final activeTheme = themeManager.equippedTheme;

    final accent = color ?? activeTheme.accentColor;

    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 1.0, end: 1.0),
        duration: const Duration(milliseconds: 150),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: GlassContainer(
          height: 52,
          width: double.infinity,
          borderRadius: BorderRadius.circular(16),
          color: isSecondary
              ? Colors.white.withOpacity(0.05)
              : accent.withOpacity(0.35),
          border: Border.all(
            color: isSecondary
                ? Colors.white.withOpacity(0.12)
                : accent.withOpacity(0.6),
            width: 1.5,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: isSecondary ? FontWeight.w600 : FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 4. GlassIconButton
class GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final double size;

  const GlassIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.size = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.all(10),
        borderRadius: BorderRadius.circular(50),
        child: Icon(
          icon,
          color: iconColor ?? Colors.white,
          size: size,
        ),
      ),
    );
  }
}

// 5. GlassTextField
class GlassTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final ValueChanged<String>? onChanged;
  final bool obscureText;

  const GlassTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: 56,
      borderRadius: BorderRadius.circular(16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 15),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: Colors.white.withOpacity(0.6), size: 20)
                : null,
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: Colors.white.withOpacity(0.6), size: 20)
                : null,
          ),
        ),
      ),
    );
  }
}

// 6. GlassSearchBar
class GlassSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const GlassSearchBar({
    super.key,
    this.controller,
    this.hintText = 'Search...',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GlassTextField(
      controller: controller,
      hintText: hintText,
      prefixIcon: Icons.search_rounded,
      onChanged: onChanged,
    );
  }
}

// 7. GlassDialog
class GlassDialog extends StatelessWidget {
  final String title;
  final String message;
  final List<Widget> actions;

  const GlassDialog({
    super.key,
    required this.title,
    required this.message,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: GlassCard(
        padding: const EdgeInsets.all(24),
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions,
            ),
          ],
        ),
      ),
    );
  }
}

// 8. GlassBottomNavigationBar
class GlassBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;

  const GlassBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      border: Border(
        top: BorderSide(color: Colors.white.withOpacity(0.15), width: 1.0),
      ),
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: const Color(0xFFB19CD9),
          unselectedItemColor: Colors.grey.shade600,
          currentIndex: currentIndex,
          onTap: onTap,
          items: items,
        ),
      ),
    );
  }
}

// 9. GlassNavigationRail
class GlassNavigationRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationRailDestination> destinations;

  const GlassNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      width: 80,
      height: double.infinity,
      child: NavigationRail(
        backgroundColor: Colors.transparent,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        labelType: NavigationRailLabelType.all,
        destinations: destinations,
      ),
    );
  }
}

// 10. GlassAppBar
class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actions;
  final Widget? leading;

  const GlassAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      border: Border(
        bottom: BorderSide(color: Colors.white.withOpacity(0.15), width: 1.0),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: title,
        actions: actions,
        leading: leading,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// 11. GlassFAB
class GlassFAB extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color? color;

  const GlassFAB({
    super.key,
    required this.child,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    final activeTheme = themeManager.equippedTheme;

    final bg = color ?? activeTheme.accentColor;

    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        width: 60,
        height: 60,
        borderRadius: BorderRadius.circular(30),
        color: bg.withOpacity(0.4),
        border: Border.all(color: bg.withOpacity(0.7), width: 2),
        child: Center(child: child),
      ),
    );
  }
}

// 12. GlassChip
class GlassChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback? onTap;

  const GlassChip({
    super.key,
    required this.label,
    this.icon,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    final activeTheme = themeManager.equippedTheme;

    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        borderRadius: BorderRadius.circular(20),
        color: isSelected
            ? activeTheme.accentColor.withOpacity(0.3)
            : Colors.white.withOpacity(0.05),
        border: Border.all(
          color: isSelected
              ? activeTheme.accentColor.withOpacity(0.6)
              : Colors.white.withOpacity(0.12),
          width: 1.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 14),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 13. GlassSwitch
class GlassSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const GlassSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    final activeTheme = themeManager.equippedTheme;

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 52,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: value
                ? activeTheme.accentColor.withOpacity(0.6)
                : Colors.white.withOpacity(0.15),
            width: 1.5,
          ),
          color: value
              ? activeTheme.accentColor.withOpacity(0.3)
              : Colors.white.withOpacity(0.08),
        ),
        padding: const EdgeInsets.all(3.0),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutBack,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 14. GlassListTile
class GlassListTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const GlassListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  title,
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    subtitle!,
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 16),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

// 15. GlassProfileCard
class GlassProfileCard extends StatelessWidget {
  final String name;
  final String rank;
  final Widget avatar;
  final List<Widget> stats;

  const GlassProfileCard({
    super.key,
    required this.name,
    required this.rank,
    required this.avatar,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              avatar,
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.military_tech, color: Color(0xFFE594A5), size: 16),
                        const SizedBox(width: 4),
                        Text(
                          rank,
                          style: const TextStyle(
                            color: Color(0xFFE594A5),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white10),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: stats,
          ),
        ],
      ),
    );
  }
}

// 16. GlassQuizCard
class GlassQuizCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final IconData icon;

  const GlassQuizCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    final activeTheme = themeManager.equippedTheme;

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            GlassContainer(
              padding: const EdgeInsets.all(12),
              borderRadius: BorderRadius.circular(16),
              color: activeTheme.accentColor.withOpacity(0.2),
              border: Border.all(color: activeTheme.accentColor.withOpacity(0.4), width: 1),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 16),
          ],
        ),
      ),
    );
  }
}

// 17. GlassLeaderboardCard
class GlassLeaderboardCard extends StatelessWidget {
  final int rank;
  final String name;
  final String score;
  final Widget avatar;
  final bool isCurrentUser;

  const GlassLeaderboardCard({
    super.key,
    required this.rank,
    required this.name,
    required this.score,
    required this.avatar,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: isCurrentUser ? Colors.cyan.withOpacity(0.15) : null,
      border: Border.all(
        color: isCurrentUser ? Colors.cyanAccent.withOpacity(0.5) : Colors.white.withOpacity(0.15),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text(
              rank.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          avatar,
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Text(
            score,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.stars, color: Color(0xFFD1C4E9), size: 16),
        ],
      ),
    );
  }
}

// 18. GlassAchievementCard
class GlassAchievementCard extends StatelessWidget {
  final String title;
  final String description;
  final String progressText;
  final double progressPercent;
  final Widget icon;

  const GlassAchievementCard({
    super.key,
    required this.title,
    required this.description,
    required this.progressText,
    required this.progressPercent,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progressPercent,
                          backgroundColor: Colors.white10,
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFB19CD9)),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      progressText,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 19. GlassShopCard
class GlassShopCard extends StatelessWidget {
  final String name;
  final String priceText;
  final Widget imageWidget;
  final bool isOwned;
  final bool isEquipped;
  final VoidCallback onTap;

  const GlassShopCard({
    super.key,
    required this.name,
    required this.priceText,
    required this.imageWidget,
    required this.isOwned,
    required this.isEquipped,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        border: Border.all(
          color: isEquipped ? Colors.amber : Colors.white.withOpacity(0.12),
          width: isEquipped ? 2 : 1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  imageWidget,
                  if (!isOwned)
                    const Icon(Icons.lock_outline, color: Colors.white54, size: 28),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              isEquipped
                  ? 'EQUIPPED'
                  : isOwned
                      ? 'USE'
                      : priceText,
              style: TextStyle(
                color: isEquipped ? Colors.amber : Colors.cyanAccent,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 20. GlassThemeCard
class GlassThemeCard extends StatelessWidget {
  final String name;
  final String priceText;
  final String imagePath;
  final bool isOwned;
  final bool isEquipped;
  final VoidCallback onTap;
  final VoidCallback onPreview;

  const GlassThemeCard({
    super.key,
    required this.name,
    required this.priceText,
    required this.imagePath,
    required this.isOwned,
    required this.isEquipped,
    required this.onTap,
    required this.onPreview,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(12),
      border: Border.all(
        color: isEquipped ? Colors.amber : Colors.white.withOpacity(0.12),
        width: isEquipped ? 2 : 1,
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onPreview,
                    child: GlassContainer(
                      padding: const EdgeInsets.all(6),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black38,
                      child: const Icon(Icons.remove_red_eye_outlined, color: Colors.white, size: 18),
                    ),
                  ),
                ),
                if (!isOwned)
                  const Positioned.fill(
                    child: Center(
                      child: Icon(Icons.lock_outline, color: Colors.white60, size: 30),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onTap,
                  child: GlassContainer(
                    height: 32,
                    borderRadius: BorderRadius.circular(8),
                    color: isEquipped
                        ? Colors.amber.withOpacity(0.2)
                        : isOwned
                            ? Colors.white.withOpacity(0.08)
                            : Colors.cyanAccent.withOpacity(0.2),
                    border: Border.all(
                      color: isEquipped
                          ? Colors.amber
                          : isOwned
                              ? Colors.white24
                              : Colors.cyanAccent,
                      width: 1,
                    ),
                    child: Center(
                      child: Text(
                        isEquipped
                            ? 'EQUIPPED'
                            : isOwned
                                ? 'EQUIP'
                                : priceText,
                        style: TextStyle(
                          color: isEquipped
                              ? Colors.amber
                              : isOwned
                                  ? Colors.white
                                  : Colors.cyanAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 21. GlassLoading
class GlassLoading extends StatelessWidget {
  final String message;

  const GlassLoading({
    super.key,
    this.message = 'Loading...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(strokeWidth: 3),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

// 22. GlassEmptyState
class GlassEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const GlassEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlassCard(
        padding: const EdgeInsets.all(32),
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white24, size: 64),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
