import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CustomNumberFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat("#,###.##", "en_US");
  bool _isDecimalTyping = false;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (_isDecimalTyping) {
      _isDecimalTyping = false;
      return newValue;
    }

    int numDots = newValue.text.split('.').length - 1;
    if (numDots > 1) {
      return oldValue;
    }
    String formattedValue = "";
    try {
      if (newValue.text[newValue.text.length - 1] == ".") {
        _isDecimalTyping = true;
        formattedValue = newValue.text;
      } else {
        double value = double.tryParse(newValue.text.replaceAll(',', '')) ?? 0;
        formattedValue = _formatter.format(value);
      }
    } catch (e) {
      formattedValue = newValue.text;
    }

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
