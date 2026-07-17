import 'package:flutter/material.dart';

class CharacterShowcase extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxShape shape;
  final BorderRadius? borderRadius;
  final BoxBorder? border;

  const CharacterShowcase({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.shape = BoxShape.circle,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: shape,
        borderRadius: shape == BoxShape.circle ? null : (borderRadius ?? BorderRadius.circular(16)),
        border: border,
      ),
      child: shape == BoxShape.circle
          ? ClipOval(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            )
          : ClipRRect(
              borderRadius: shape == BoxShape.circle ? BorderRadius.zero : (borderRadius ?? BorderRadius.circular(16)),
              child: Center(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
    );
  }
}
