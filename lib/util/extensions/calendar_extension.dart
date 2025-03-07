import 'package:intl/intl.dart';
import 'package:prime_counter/core/constants/constants.dart';
import 'package:prime_counter/util/data/calendar_detail.dart';

extension CalendarExtension on DateTime {
  String get currentTimeStamp {
    return DateFormat('HH:mm').format(this);
  }

  int get currentCalendarWeek {
    int dayOfYear = int.parse(DateFormat("D").format(this));

    int weekNumber = ((dayOfYear - weekday + 10) / 7).floor();

    return weekNumber;
  }

  String get currentMonthText {
    return DateConstants.germanMonthMap[month] ?? 'Unknown';
  }

  String get currentDateText {
    return DateConstants.germanDateMap[weekday] ?? 'Unknown';
  }

  CalendarDetail get calendarDetails {
    return CalendarDetail(
      calendarWeek: currentCalendarWeek,
      month: currentMonthText,
      date: currentDateText,
    );
  }
}
