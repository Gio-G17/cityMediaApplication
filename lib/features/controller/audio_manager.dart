import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:volume_controller/volume_controller.dart';
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
    currentVolume = await VolumeController().getVolume();
    currentValue = currentVolume;

    try {
      await player.setAudioSource(
        AudioSource.uri(
          Uri.parse(ref.read(getStationProv).value!.urlAudio),
          tag: const MediaItem(
            id: '1',
            album: "City Media Online",
            title: "City Media Online",
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
  }

  void refresh() async {
    isAnimating = true;
    notifyListeners();
    await player.stop();
    await player.play();
  }

  void reLoad() async {
    isAnimating = true;
    notifyListeners();
    await player.load();
    await player.play();
  }

  void stopAudio() async {
    isPlaying = false;
    isAnimating = false;
    notifyListeners();
    await player.pause();
  }

  void startTimer(int duration) {
    timer?.cancel();
    timer = Timer(Duration(seconds: duration), () {
      stopAudio();
    });
    isTimerActive = true;
  }

  void cancelTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
      isTimerActive = false; // Set timer state to inactive
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
