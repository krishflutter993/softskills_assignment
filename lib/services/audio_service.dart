import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService instance = AudioService._internal();
  AudioService._internal();

  final AudioPlayer _bgMusicPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer();

  bool _musicEnabled = true;
  bool _soundEnabled = true;

  void updateSettings({required bool musicEnabled, required bool soundEnabled}) {
    _musicEnabled = musicEnabled;
    _soundEnabled = soundEnabled;

    if (!_musicEnabled) {
      stopBackgroundMusic();
    } else {
      startBackgroundMusic();
    }
  }

  Future<void> startBackgroundMusic() async {
    if (!_musicEnabled) return;
    try {
      await _bgMusicPlayer.setReleaseMode(ReleaseMode.loop);
      // Play a looping low-resource royalty-free ambient track
      await _bgMusicPlayer.play(UrlSource('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3'));
    } catch (e) {
      debugPrint('Error playing background music: $e');
    }
  }

  Future<void> stopBackgroundMusic() async {
    try {
      await _bgMusicPlayer.stop();
    } catch (e) {
      debugPrint('Error stopping background music: $e');
    }
  }

  Future<void> pauseBackgroundMusic() async {
    try {
      if (_musicEnabled) {
        await _bgMusicPlayer.pause();
      }
    } catch (e) {
      debugPrint('Error pausing background music: $e');
    }
  }

  Future<void> resumeBackgroundMusic() async {
    try {
      if (_musicEnabled) {
        await _bgMusicPlayer.resume();
      }
    } catch (e) {
      debugPrint('Error resuming background music: $e');
    }
  }

  Future<void> playSoundEffect(String name) async {
    if (!_soundEnabled) return;
    try {
      String url = '';
      if (name == 'click') {
        url = 'https://codesandbox.io/api/v1/sandboxes/wz8qp/assets/click.mp3'; // Fallback link
      } else if (name == 'correct') {
        url = 'https://codesandbox.io/api/v1/sandboxes/wz8qp/assets/correct.mp3';
      } else if (name == 'wrong') {
        url = 'https://codesandbox.io/api/v1/sandboxes/wz8qp/assets/wrong.mp3';
      } else if (name == 'purchase') {
        url = 'https://codesandbox.io/api/v1/sandboxes/wz8qp/assets/purchase.mp3';
      } else if (name == 'levelUp') {
        url = 'https://codesandbox.io/api/v1/sandboxes/wz8qp/assets/levelup.mp3';
      } else if (name == 'reward') {
        url = 'https://codesandbox.io/api/v1/sandboxes/wz8qp/assets/reward.mp3';
      }

      if (url.isNotEmpty) {
        // Reset player and play one-shot sound
        await _sfxPlayer.stop();
        await _sfxPlayer.play(UrlSource(url));
      }
    } catch (e) {
      debugPrint('Error playing sound effect $name: $e');
    }
  }

  void dispose() {
    _bgMusicPlayer.dispose();
    _sfxPlayer.dispose();
  }
}
