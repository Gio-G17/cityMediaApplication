import 'dart:async';
// import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:cityMedia/features/data/data_repository.dart';

final audioProvider =
    ChangeNotifierProvider<AudioManager>((ref) => AudioManager(ref));

class AudioManager extends ChangeNotifier {
  final AudioPlayer player = AudioPlayer();
  Timer? timer;
  double currentVolume = 0;
  double currentValue = 0;
  final Ref ref;
  AudioManager(this.ref) {
    initAudio();
  }
  bool isPlaying = false;
  bool isAnimating = false;
  bool isTimerActive = false;

  void initAudio() async {
    currentVolume = await PerfectVolumeControl.getVolume();
    currentValue = currentVolume;

    try {
      await player.setAudioSource(
        AudioSource.uri(
          Uri.parse(ref.read(getStationProv).value!.urlAudio),
          tag: const MediaItem(
            id: '1',
            album: "cityMedia of gospel",
            title: "cityMedia of gospel",
          ),
        ),
        preload: true, // Preload to improve buffering
        initialPosition: Duration.zero, // Start at the beginning
      );
      notifyListeners();
    } catch (e) {
      // Handle the error, show a dialog or message
      print("Error loading audio source: $e");
    }
  }

  void playAudio() async {
    isPlaying = true;
    isAnimating = true;
    notifyListeners();
    await player.play();
    // startTimer();
  }

  void refresh() async {
   // isPlaying = true;
    isAnimating = true;
    notifyListeners();
    await player.stop();
    await player.play();
  }

  void reLoad() async {
    // await player.stop();|
    isAnimating = true;
  //  isPlaying = true;
    notifyListeners();
    await player.load();
    await player.play();
  }

  void stopAudio() async {
    isPlaying = false;
    isAnimating = false;
    notifyListeners();
    await player.pause();
    // cancelTimer();
  }

  void startTimer(int duration) {
    timer?.cancel();
    timer = Timer(Duration(seconds: duration), () {
      stopAudio();
    });
    isTimerActive = true;
    // notifyListeners();
  }

  void cancelTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
      isTimerActive = false; // Set timer state to inactive
      // notifyListeners();
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
