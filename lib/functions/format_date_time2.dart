import 'package:intl/intl.dart';

class FormatDateTime2 {
  FormatDateTime2({required this.dateTime});
  final String? dateTime;

  @override
  String toString() {
    var f = DateFormat('dd/MM/yyyy HH:mm');
    if (dateTime == null || dateTime == '') {
      return '';
    }
    return f.format(DateTime.parse(dateTime!));
  }
}

class FormatDateTimeCustom {
  FormatDateTimeCustom({required this.dateTime, required this.format});
  final String? dateTime;
  final String? format;
  @override
  String toString() {
    var f = DateFormat(format);
    if (dateTime == null || dateTime == '') {
      return '';
    }
    return f.format(DateTime.parse(dateTime!));
  }
}
