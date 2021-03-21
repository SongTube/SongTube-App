class AudioFilters {

  double volume;
  int bassGain;
  int trebleGain;
  bool normalizeAudio;

  AudioFilters({
    this.volume = 1,
    this.bassGain = 0,
    this.trebleGain = 0,
    this.normalizeAudio = false
  });

}