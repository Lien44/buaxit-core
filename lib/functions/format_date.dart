import 'package:intl/intl.dart';

class FormatDate {
  FormatDate({required this.dateTime});
  final String? dateTime;

  @override
  String toString() {
    var f = DateFormat('dd/MM/yyyy');
    if (dateTime == null) {
      return '';
    }
    return f.format(DateTime.parse(dateTime!));
  }
}
