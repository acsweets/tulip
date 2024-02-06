// import 'dart:io';
//
// import 'package:cses_common/cses_common.dart';
//
// ///format milliseconds to time stamp like "06:23", which
// ///means 6 minute 23 seconds
// String getTimeStamp(int? milliseconds) {
//   if (milliseconds == null) return '00:00';
//
//   if (milliseconds > 60 * 60 * 1000) {
//     return DateUtil.getDateStrByMs(milliseconds, isUtc: true, format: DateFormat.HOUR_MINUTE_SECOND)!;
//   } else {
//     return DateUtil.getDateStrByMs(milliseconds, isUtc: true, format: DateFormat.MINUTE_SECOND)!;
//   }
// }
//
// String getDurationStr(int? milliseconds) {
//   if (milliseconds == null) return '';
//   int seconds = (milliseconds / 1000).truncate();
//
//   String timeStr = "";
//
//   if (seconds > 60) {
//     int minuteStr = (milliseconds / 60000).truncate();
//     timeStr += "$minuteStr'";
//   }
//
//   String secondsStr = (seconds % 60).toString();
//
//   timeStr += '$secondsStr"';
//
//   return timeStr;
// }
//
// int currentTimeMillis() {
//   return DateTime.now().millisecondsSinceEpoch;
// }
//
// Future<DateTime> getTimeByFilePath(String path) async {
//   return File(path).lastModifiedSync();
// }
//
// List<int> periodToString(int milliseconds) {
//   if (milliseconds <= 0) return [0, 0, 0, 0, 0];
//   int days = milliseconds ~/ (1000 * 60 * 60 * 24);
//   int hours = DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true).hour;
//   int minutes = DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true).minute;
//   int seconds = DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true).second;
//   int milliseconds0 = (DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true).millisecond / 100).floor();
//
//   return [days, hours, minutes, seconds, milliseconds0];
// }
//
// int get todayBeginMs => DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).millisecondsSinceEpoch;
//
// int get todayEndMs =>
//     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59).millisecondsSinceEpoch;
//
// int getDateBeginMs(DateTime date) {
//   int milliseconds = DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
//   return milliseconds;
// }
//
// int getDateEndMs(DateTime date) {
//   int milliseconds = DateTime(date.year, date.month, date.day, 23, 59, 59).millisecondsSinceEpoch;
//   return milliseconds;
// }
//
// DateTime getDateBegin(DateTime date) {
//   DateTime dateTime = DateTime(date.year, date.month, date.day);
//   return dateTime;
// }
//
// DateTime getDateEnd(DateTime date) {
//   DateTime dateTime = DateTime(date.year, date.month, date.day, 23, 59, 59);
//   return dateTime;
// }
