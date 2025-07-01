extension StringHelpers on String {
  String ifEmpty(String fallback) {
    return trim().isEmpty ? fallback : this;
  }
}