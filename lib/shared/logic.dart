
import 'package:intl/intl.dart';

String formatDate(DateTime _date) {
  return DateFormat("MMMM d, yyyy").format(_date);
}