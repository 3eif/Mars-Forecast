import 'package:date_time_format/date_time_format.dart';

String parseTime(String isoDate) {
  return DateTimeFormat.format(DateTime.parse(isoDate),
      format: DateTimeFormats.american);
}
