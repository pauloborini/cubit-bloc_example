import 'package:flutter/material.dart';
import 'package:motels/core/ui/styles/colors_app.dart';
import 'package:motels/core/ui/styles/text_styles.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(1),
        backgroundColor: WidgetStatePropertyAll(context.colors.neutralShade100),
      ),
      onPressed: onPressed,
      child: Text(
        'Tentar novamente',
        style: context.textStyles.bodyTextMedium,
      ),
    );
  }
}
