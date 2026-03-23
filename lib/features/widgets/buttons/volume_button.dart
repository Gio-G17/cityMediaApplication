import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cityMedia/features/screens/other/volume_screen.dart';
import 'package:cityMedia/theme/colors.dart';

class VolumeButton extends StatelessWidget {
  const VolumeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;

    return IconButton(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      padding: EdgeInsets.zero,
      icon: SvgPicture.asset(
        'assets/homepage_icons/volumeIcon.svg', // Path to your SVG file
        color: AppColors.iconsColorActive, // Optional: Apply a color
        height: devHeight * 0.03,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            backgroundColor: AppColors.backgroundColor,
            contentPadding: EdgeInsets.all(15),
            content: VolumeScreen(),
          ),
        );
      },
    );
  }
}
