import 'package:intl/intl.dart';

class Utils {
  static formatDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
}