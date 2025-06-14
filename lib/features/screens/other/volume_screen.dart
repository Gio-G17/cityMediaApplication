import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:cityMedia/theme/colors.dart';
import 'package:cityMedia/features/controller/audio_manager.dart';

class VolumeScreen extends StatelessWidget {
  const VolumeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.all(0),
      color: AppColors.iconsColorActive,
      shadowColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        height: devHeight * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(0.0),
              child: Text(
                'Volume',
                style:
                    TextStyle(fontSize: 20, color: AppColors.textPrimaryColor),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 10,
                    child: StatefulBuilder(builder: (context, state) {
                      return Consumer(builder: (context, ref, _) {
                        final audioManager = ref.watch(audioProvider);
                        return Slider(
                          activeColor: AppColors.primaryColor,
                          inactiveColor: AppColors.secondaryColor,
                          value: audioManager.currentVolume,
                          onChanged: (newvol) {
                            audioManager.currentVolume = newvol;
                            PerfectVolumeControl.setVolume(newvol);
                            state(() {});
                          },
                          min: 0,
                          max: 1,
                          divisions: 100,
                        );
                      });
                    }),
                  ),
                ),
              ],
            ),
            GestureDetector(
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontSize: 15, color: AppColors.textSecondaryColor),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
