import 'package:timeago/timeago.dart' as timeago;

extension HumanTime on DateTime {
  String get inRoughTime {
    timeago.setLocaleMessages('en', CustomHumanTimeMessages());
    return timeago.format(this, allowFromNow: true);
  }
}

class CustomHumanTimeMessages implements timeago.LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => 'remaining';
  @override
  String lessThanOneMinute(int seconds) => 'now';
  @override
  String aboutAMinute(int minutes) => '${minutes}m';
  @override
  String minutes(int minutes) => '${minutes}m';
  @override
  String aboutAnHour(int minutes) => '${minutes}m';
  @override
  String hours(int hours) => '${hours}h';
  @override
  String aDay(int hours) => '${hours}h';
  @override
  String days(int days) => '${days}d';
  @override
  String aboutAMonth(int days) => '${days}d';
  @override
  String months(int months) => '${months}mo';
  @override
  String aboutAYear(int year) => '${year}y';
  @override
  String years(int years) => '${years}y';
  @override
  String wordSeparator() => ' ';
}

String getInitials(String text) {
  if (text.isEmpty) return '';

  List<String> words = text.trim().split(' ');
  if (words.length >= 2) {
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  } else {
    return text.substring(0, text.length >= 2 ? 2 : text.length).toUpperCase();
  }
}
