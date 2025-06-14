import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cityMedia/theme/colors.dart';

class SidebarHeader extends StatelessWidget {
  final VoidCallback onBack;

  const SidebarHeader({super.key, required this.onBack,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        alignment: Alignment.centerRight,
        child: IconButton(
          icon: SvgPicture.asset(
            'assets/homepage_icons/backIcon.svg',
            height: 25,
            color: AppColors.secondaryColor
          ),
          padding: EdgeInsets.zero,
          onPressed: onBack,
        ),
      ),
    );
  }
}
