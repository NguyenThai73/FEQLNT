import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
String formatCurrencyStringToNumber(String currencyString) {
  // Sử dụng NumberFormat để định dạng số với kiểu tiền tệ
  final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '');

  // Chuyển chuỗi thành số
  try {
    final formattedNumber = currencyFormat.parse(currencyString);
    return formattedNumber.toStringAsFixed(2); // Định dạng thành số với 2 chữ số thập phân
  } catch (e) {
    return "";
  }
}
String formatCurrency(int amount) {
  final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');
  return currencyFormat.format(amount);
}

String formatCurrency2(int amount) {
  final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '');
  return currencyFormat.format(amount);
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final value = int.parse(newValue.text);
    final currency = NumberFormat.simpleCurrency(locale: 'en_US');
    final newText = currency.format(value / 100);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}