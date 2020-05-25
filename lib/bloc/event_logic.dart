import 'package:intl/intl.dart';

class EventLogic {
  List<int> getCountdown(String date) {
    DateFormat format = DateFormat('mm:ss');
    DateTime _date = DateTime.parse(date);

    int from = _date.millisecondsSinceEpoch;
    int now = DateTime.now().millisecondsSinceEpoch;
    Duration remaining = Duration(milliseconds: from - now);

    int _days = remaining.inDays;
    int _hours = remaining.inHours - (_days * 24);

    String minSec = format.format(DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds));
    List<String> minSecList = minSec.split(':');
    int _minutes = int.parse(minSecList[0]);
    int _seconds = int.parse(minSecList[1]);

    return [_days, _hours, _minutes, _seconds];
  }

  String formatDate(String date) {
    return DateFormat("MMM d, yyyy").format(DateTime.parse(date));
  }

  bool isComplete(String date) {
    DateTime _date = DateTime.parse(date);
    if(_date.isBefore(DateTime.now())) {
      return false;
    } else return true;
  }

}