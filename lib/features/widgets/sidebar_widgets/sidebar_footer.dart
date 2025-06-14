import 'package:flutter/material.dart';
import 'package:voiceofgospel/theme/colors.dart';

class SidebarFooter extends StatelessWidget {
  const SidebarFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      alignment: Alignment.center,
      child: const Text.rich(
        TextSpan(
          text: "Developed by ",
          style: TextStyle(
            color: AppColors.textSecondaryColor,
            fontWeight: FontWeight.w100,
          ),
          children: [
            TextSpan(
              text: "Lit-Online",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
