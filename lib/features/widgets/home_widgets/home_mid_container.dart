import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voiceofgospel/features/controller/audio_manager.dart';
import 'package:voiceofgospel/features/data/data_repository.dart';
import 'package:voiceofgospel/features/widgets/buttons/alarm_button.dart';
import 'package:voiceofgospel/features/widgets/buttons/volume_button.dart';
import 'package:voiceofgospel/features/widgets/home_widgets/home_player.dart';
import 'package:voiceofgospel/features/widgets/wave_form/waveform_painter.dart';
import 'package:voiceofgospel/theme/colors.dart';

class HomeMidContainer extends ConsumerStatefulWidget {
  const HomeMidContainer({super.key});

  @override
  _HomeMidContainerState createState() => _HomeMidContainerState();
}

class _HomeMidContainerState extends ConsumerState<HomeMidContainer> {
  @override
  Widget build(BuildContext context) {
    final devHeight = MediaQuery.of(context).size.height;
    final devWidth = MediaQuery.of(context).size.width;

    // Access audioManager using ref.watch
    final audioManager = ref.watch(audioProvider);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.03 * devHeight),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0.015 * devHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  audioManager.isAnimating
                      ? MusicVisualizer(
                          height: devHeight,
                          width: devWidth,
                        )
                      : const SizedBox(
                          height: 25,
                          width: 50,
                        ),
                  const SizedBox(height: 5),
                  Text(
                    ref.read(getStationProv).value?.playing ?? 'No station',
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: AppColors.textTertiaryColor,
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   decoration: const BoxDecoration(boxShadow: [
            //     BoxShadow(
            //       color: Color.fromARGB(88, 255, 255, 255),
            //       blurRadius: 75,
            //       spreadRadius: 4,
            //       blurStyle: BlurStyle.normal,
            //     )
            //   ]),
            //   width: devWidth * 0.75,
            //   height: devHeight * 0.35,
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(20),
            //     child: Image.asset(
            //       'assets/background_image/stationImg.png',
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color:
                          ref.read(getStationProv).value?.urlColorMidleLogo ??
                              Colors.transparent,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(88, 255, 255, 255),
                          blurRadius: 50,
                          spreadRadius: 1,
                          blurStyle: BlurStyle.normal,
                        )
                      ]),
                  width: devWidth * 0.65,
                  height: devHeight * 0.30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            ref.read(getStationProv).value?.urlMidleLogo ?? '',
                            
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '94.5 FM',
                    style:
                        TextStyle(color: AppColors.textTertiaryColor, fontSize: 24),
                  ),
                  SvgPicture.asset('assets/homepage_icons/fmSliderIcon.svg',height: 30,),
                ],
              ),
            ),
            //  child: CachedNetworkImage(
            //     imageUrl: ref.read(getStationProv).value?.urlMidleLogo ?? '',
            //   ),

            // child: SvgPicture.asset('assets/background_image/stationImg.svg'),
            // decoration: BoxDecoration(
            //     borderRadius: const BorderRadius.all(Radius.circular(20)),
            //     color: ref.read(getStationProv).value?.urlColorMidleLogo ??
            //         Colors.transparent,
            //     boxShadow: const [
            //       BoxShadow(
            //         color: Color.fromARGB(88, 255, 255, 255),
            //         blurRadius: 50,
            //         spreadRadius: 1,
            //         blurStyle: BlurStyle.normal,
            //       )
            //     ]),
            // width: devWidth * 0.75,
            // height: devHeight * 0.35,
            // child: ClipRRect(
            //   borderRadius: BorderRadius.circular(devWidth),
            //   child: CachedNetworkImage(
            //     imageUrl: ref.read(getStationProv).value?.urlMidleLogo ?? '',
            //   ),
            // ),
            // ),
            Container(
              padding: const EdgeInsets.only(bottom: 30),
              width: devWidth * 0.6,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AlarmButton(),
                  HomePlayer(
                    height: devHeight,
                    width: devWidth,
                  ),
                  const VolumeButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
