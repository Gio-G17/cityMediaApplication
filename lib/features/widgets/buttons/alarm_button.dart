import 'package:flutter/material.dart';
import 'package:voiceofgospel/features/screens/other/alarm_screen.dart';
import 'package:voiceofgospel/theme/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AlarmButton extends StatelessWidget {
  const AlarmButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    return IconButton(
      padding: EdgeInsets.zero,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      icon: SvgPicture.asset(
        'assets/homepage_icons/timerIcon.svg', // Path to your SVG file
        color: AppColors.iconsColorActive, // Optional: Apply a color
        height: devHeight * 0.035,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            backgroundColor: AppColors.backgroundColor,
            contentPadding: EdgeInsets.all(15),

            content: AlarmScreen(),
          ),
        );
        // showDialog(
        //   context: context,
        //   builder: (context) => const AlertDialog(
        //     elevation: 0,
        //     shape: LinearBorder(),
        //     content: AlarmScreen(),
        //   ),
        // );
      },
    );
  }
}
