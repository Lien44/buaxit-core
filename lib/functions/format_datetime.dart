import 'package:intl/intl.dart';

class FormatDateTime {
  FormatDateTime({required this.dateTime});
  final String? dateTime;

  @override
  String toString() {
    var f = DateFormat('dd/MM/yyyy HH:mm:ss');
    if (dateTime == null) {
      return '';
    }
    return f.format(DateTime.parse(dateTime!));
  }
}
