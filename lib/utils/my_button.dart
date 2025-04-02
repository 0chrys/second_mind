import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_mind/theme_provider.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined
              ? theme.cardColor
              : backgroundColor ?? theme.primaryColor,
          foregroundColor: isOutlined
              ? theme.primaryColor
              : backgroundColor != null
                  ? theme.cardColor
                  : theme.brightness == Brightness.light
                      ? Colors.white
                      : Colors.black,
          side: isOutlined
              ? BorderSide(
                  color: theme.primaryColor,
                  width: 1.5,
                )
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor ??
                (isOutlined
                    ? theme.primaryColor
                    : theme.brightness == Brightness.light
                        ? Colors.white
                        : Colors.black),
          ),
        ),
      ),
    );
  }
}
