class InvalidSymptomLevelError extends ArgumentError {
  InvalidSymptomLevelError({required int level})
      : super.value(level, "level", "level must be within 1..5 range");
}
