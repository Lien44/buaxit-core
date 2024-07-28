import 'package:intl/intl.dart';

class FormatTime {
  FormatTime({required this.dateTime});
  final String? dateTime;

  @override
  String toString() {
    var f = DateFormat('HH:mm:ss');
    if (dateTime == null) {
      return '';
    }
    return f.format(DateTime.parse(dateTime!));
  }
}
