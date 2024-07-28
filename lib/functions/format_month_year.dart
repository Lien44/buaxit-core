import 'package:intl/intl.dart';

class FormatMonthYear {
  FormatMonthYear({required this.dateTime});
  final String? dateTime;

  @override
  String toString() {
    var f = DateFormat('MM/yyyy');
    if (dateTime == null) {
      return '';
    }
    return f.format(DateTime.parse(dateTime!));
  }
}
