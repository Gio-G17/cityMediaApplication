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

    openDialog() => showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          elevation: 0,
          builder: ((context) {
            return const SizedBox(
                height: 200,
                width: 400,
                child: Wrap(children: [VolumeScreen()]));
          }),
        );

    openDialog2() => showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => const AlertDialog(
            shape: LinearBorder(),
            content: VolumeScreen(),
          ),
        );
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
        // openDialog2();
      },
    );
  }
}
