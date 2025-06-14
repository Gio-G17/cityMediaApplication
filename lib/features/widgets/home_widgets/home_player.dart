import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import the flutter_svg package
import 'package:cityMedia/features/controller/audio_manager.dart';

class HomePlayer extends ConsumerWidget {
  final double width;
  final double height;

  const HomePlayer({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioManager = ref.watch(audioProvider);
    return Consumer(builder: (context, ref, _) {
      return Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        width: width*0.18,
        child: Center(
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: SvgPicture.asset(
              audioManager.isPlaying
                  ? 'assets/homepage_icons/pauseIcon.svg' // Your pause SVG path
                  : 'assets/homepage_icons/playIcon.svg', // Your play SVG pat     // Optionally color the SVG if needed
            ),
            onPressed: () {
              print('test by themd');
              if (audioManager.isPlaying) {
                audioManager.stopAudio();
              } else {
                audioManager.playAudio();
              }
            },
          ),
        ),
      );
    });
  }
}
