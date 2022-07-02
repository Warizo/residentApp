import 'package:intl/intl.dart';

myDateFormat(date) {
  var myDateFormat = DateFormat('d-MM-yyyy');
  final newDate = myDateFormat.format(DateTime.parse(date));
  return newDate;
}
