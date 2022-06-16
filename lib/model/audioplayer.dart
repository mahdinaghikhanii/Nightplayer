class ProgressBarState {
  ProgressBarState(
      {required this.buffered, required this.current, required this.total});

  final Duration current;
  final Duration buffered;
  final Duration total;
}
