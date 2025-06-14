import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import the flutter_svg package
import 'package:voiceofgospel/features/controller/audio_manager.dart';
import 'package:voiceofgospel/theme/colors.dart';

class HomePlayerReload extends ConsumerWidget {
  const HomePlayerReload({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioManager = ref.watch(audioProvider);
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.transparent,
      ),
      child: Center(
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: SvgPicture.asset(
            'assets/homepage_icons/reloadIcon.svg', // Your reload SVG path
            color: AppColors.iconsColorActive, // Optionally color the SVG if needed
            height: 25 // Adjust height as needed
          ),
          onPressed: () {
            audioManager.reLoad();
            if (audioManager.isPlaying) {
              audioManager.stopAudio();
            } else {
              audioManager.playAudio();
            }
          },
        ),
      ),
    );
  }
}
