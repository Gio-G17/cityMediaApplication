import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voiceofgospel/features/controller/audio_manager.dart';
import 'package:voiceofgospel/features/screens/home/home_screen.dart';
import 'package:voiceofgospel/theme/colors.dart';

class AlarmScreen extends ConsumerStatefulWidget {
  const AlarmScreen({super.key});

  @override
  ConsumerState<AlarmScreen> createState() => _AlarmPageState();
}

int currentValue = 0;
Timer? _timer;

class _AlarmPageState extends ConsumerState<AlarmScreen> {
  final HomeScreen home = const HomeScreen();

  void cancel() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
  }

  void startTimer(int _start) {
    const oneSec = Duration(seconds: 1);
    ref.read(audioProvider).startTimer(_start * 60);
    // _timer = Timer.periodic(oneSec, (Timer timer) {
    //   if (mounted) {
    //     setState(() {
    //       currentValue = _start--;
    //       print(_start);
    //       if (_start < 0) {
    //         _timer?.cancel();
    //         isTimerActive = !isTimerActive;
    //       }
    //     });
    //   } else {
    //     currentValue = _start--;
    //     print(_start);
    //     if (_start < 0) {
    //       _timer?.cancel();
    //       isTimerActive = !isTimerActive;
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final audioManager = ref.watch(audioProvider);
    int hrs = (currentValue / 3600).floor();
    int min = (currentValue / 60).floor();
    int sec = currentValue % 60;
    String hours = hrs.toString().length <= 1 ? "0$hrs" : "$hrs";
    String minutes = min.toString().length <= 1 ? "0$min" : "$min";
    String seconds = sec.toString().length <= 1 ? "0$sec" : "$sec";

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.all(0),
      color: AppColors.iconsColorActive,
      elevation: 0,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15,0,15,15),
                    child: Text(
                      "Sleeping Time",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: AppColors.textPrimaryColor),
                    ),
                  ),
                ),
                audioManager.isTimerActive
                    ? Text(
                        "$hours:$minutes:$seconds",
                        style: const TextStyle(fontSize: 35,color: AppColors.textSecondaryColor,fontWeight: FontWeight.bold),
                      )
                    : Slider(
                        value: currentValue.toDouble(),
                        onChanged: (newRating) {
                          setState(
                            () {
                              currentValue = newRating.toInt();
                            },
                          );
                        },
                        max: 180,
                        min: 0,
                        secondaryTrackValue: 1,
                        activeColor: AppColors.primaryColor,
                        inactiveColor: AppColors.secondaryColor),
                audioManager.isTimerActive
                    ? const SizedBox.shrink()
                    : Align(
                        alignment: Alignment.center,
                        child: Text(
                          "$currentValue min",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppColors.textPrimaryColor),
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          alignment: Alignment.bottomRight,
                          padding: MaterialStateProperty.all(EdgeInsets.zero)),
                      onPressed: () {
                        cancel();
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                            color: AppColors.textSecondaryColor,
                            fontWeight: FontWeight.normal,fontSize: 15),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(

                      style: ButtonStyle(
                        alignment: Alignment.bottomRight,
                        padding: WidgetStateProperty.all(EdgeInsets.zero),
                      
                      ),
                      onPressed: () async {
                        audioManager.isTimerActive
                            ? {audioManager.cancelTimer(), cancel()}
                            : {
                                startTimer(currentValue),
                                // await Future.delayed(Duration(milliseconds: 500)),
                                cancel()
                              };

                        // isTimerActive = !isTimerActive;
                      },
                      child: Text(
                        audioManager.isTimerActive ? "Stop" : "Set",
                        style: const TextStyle(
                            color: AppColors.textPrimaryColor,
                            fontWeight: FontWeight.normal,fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
