class FormatMinute {
  FormatMinute({required this.timeInSecond});
  final int timeInSecond;

  @override
  String toString() {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(timeInSecond * 1000,isUtc: true);
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
  }
}
