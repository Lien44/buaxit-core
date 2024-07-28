import 'package:intl/intl.dart';

class FormatPrice {
  FormatPrice({required this.price});
  final num price;

  @override
  String toString() {
    var f = NumberFormat('###,###.##');
    return f.format(price);
  }
}
