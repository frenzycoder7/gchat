extension StringExt on String {
  bool get isNotFound => this == 'NOT_FOUND';
  bool isNumeric() {
    final regex = RegExp(r'^-?[0-9]+(\.[0-9]+)?$');
    return regex.hasMatch(this);
  }
}

extension IntExt on int {
  String heroViews() {
    if (this < 1000) {
      return '$this';
    } else if (this < 1000000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    } else {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    }
  }
}
