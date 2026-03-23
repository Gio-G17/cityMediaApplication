import 'package:flutter/material.dart';
import 'package:cityMedia/features/widgets/wave_form/waveform_widget.dart';

class MusicVisualizer extends StatelessWidget {
  final double width;
  final double height;

  final List<Color> colors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  final List<int> durations = [
    900, 700, 600, 800, 500,
  ];

    MusicVisualizer({
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
         width: 0.10*width,
      height: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<Widget>.generate(
          5,
          (index) => VisualComponent(
            duration: durations[index % 5],
            color: colors[index % 4],
          ),
        ),
      ),
    );
  }
}
