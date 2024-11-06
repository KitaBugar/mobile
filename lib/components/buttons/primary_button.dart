import 'package:kitabugar/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.onTap,
    this.title,
    this.style,
  });
  final Function()? onTap;
  final String? title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title ?? "-",
        style: style ??
            const TextStyle(
              color: AppPallete.colorPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
