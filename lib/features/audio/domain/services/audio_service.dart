import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer? _sfxPlayer;
  bool _isMuted = false;
  double _sfxVolume = 1.0;

  AudioService({AudioPlayer? player}) : _sfxPlayer = player;

  bool get isMuted => _isMuted;
  double get sfxVolume => _sfxVolume;

  void toggleMute() {
    _isMuted = !_isMuted;
    _sfxPlayer?.setVolume(_isMuted ? 0.0 : _sfxVolume);
  }

  void setVolume(double volume) {
    _sfxVolume = volume.clamp(0.0, 1.0);
    if (!_isMuted) {
      _sfxPlayer?.setVolume(_sfxVolume);
    }
  }

  Future<void> playSfx(String soundName) async {
    if (_isMuted || _sfxPlayer == null) return;
    try {
      await _sfxPlayer.play(AssetSource('audio/$soundName.mp3'));
    } catch (_) {
      // Audio optional - fails silently on platforms without audio driver
    }
  }

  Future<void> speakVoiceLine(String text) async {
    // Voice TTS provider contract placeholder
  }

  void dispose() {
    _sfxPlayer?.dispose();
  }
}
