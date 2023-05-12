class AudioFilters {

  double volume;
  int bassGain;
  int trebleGain;
  bool normalizeAudio;

  AudioFilters({
    this.volume = 0,
    this.bassGain = 0,
    this.trebleGain = 0,
    this.normalizeAudio = false
  });

  bool get conversionRequired {
    if (volume > 0 || bassGain > 0 || trebleGain > 0) {
      return true;
    } else {
      return false;
    }
  }

}