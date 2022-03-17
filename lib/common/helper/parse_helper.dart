import 'package:intl/intl.dart';

class ParseHelper {
  static String parseDate(String val) {
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(val);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd MMMM yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String parseTime(String val) {
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(val);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
