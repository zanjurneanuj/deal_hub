import 'package:intl/intl.dart';
class Formatters {
  Formatters._();
  static String formatCurrency(double amount) {
    if (amount >= 10000000) {
      final crores = amount / 10000000;
      return '${crores.toStringAsFixed(crores % 1 == 0 ? 0 : 1)} Cr';
    } else if (amount >= 100000) {
      final lakhs = amount / 100000;
      return '${lakhs.toStringAsFixed(lakhs % 1 == 0 ? 0 : 1)} L';
    } else {
      return '${NumberFormat('#,##,###').format(amount)}';
    }
  }
  static String formatROI(double roi) {
    return '${roi.toStringAsFixed(1)}%';
  }
  static String formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}