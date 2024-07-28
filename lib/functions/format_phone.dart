class FormatPhone {
  FormatPhone({required this.text});
  final String text;

  @override
  String toString() {
    if (text.length == 8) {
      return '020 ${text.substring(0, 2)} ${text.substring(2, 5)} ${text.substring(5, 8)}';
    }
    return text;
  }
}
