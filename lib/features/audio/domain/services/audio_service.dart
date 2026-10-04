class AudioService {
  bool _isMuted = false;
  double _sfxVolume = 1.0;

  bool get isMuted => _isMuted;
  double get sfxVolume => _sfxVolume;

  void toggleMute() {
    _isMuted = !_isMuted;
  }

  void setVolume(double volume) {
    _sfxVolume = volume.clamp(0.0, 1.0);
  }

  Future<void> playSfx(String soundName) async {
    if (_isMuted) return;
    // Audio feedback abstraction
  }

  Future<void> speakVoiceLine(String text) async {
    // Voice TTS provider contract placeholder
  }

  void dispose() {
    // Cleanup resources
  }
}
