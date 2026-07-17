import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final BoxBorder? border;
  final Color? color;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.width,
    this.height,
    this.border,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? BorderRadius.circular(20);
    return ClipRRect(
      borderRadius: effectiveRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: color ?? Colors.white.withOpacity(0.08), // ~8-12% opacity
            borderRadius: effectiveRadius,
            border: border ?? Border.all(
              color: Colors.white.withOpacity(0.15), // ~15-20% opacity
              width: 1.0,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
