import 'package:intl/intl.dart';
export 'category.dart';
export 'product.dart';

extension DateTimeFormat on DateTime {
  static final DateFormat _calendar = DateFormat('MMM, y');
  static final DateFormat _yearFormat = DateFormat.y();

  static final _format = DateFormat('dd/MM/yyyy');
  static final _monthformat = DateFormat('MMM, yyyy');
  static final _weekDayformat = DateFormat('E');

  static final _dayformat = DateFormat.yMd().add_Hm();

  static final _hourFormat = DateFormat('Hm');

  String get calendarFormat => _calendar.format(this);
  String get yearFormat => _yearFormat.format(this);

  String get format => _format.format(this);
  String get dayFormat => _dayformat.format(this);
  String get monthFormat => _monthformat.format(this);
  String get hourFormat => _hourFormat.format(this);
  String get weekdayFormat => _weekDayformat.format(this);

  bool isInTheSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  bool get isToday {
    final other = DateTime.now();
    return year == other.year && month == other.month && day == other.day;
  }
}

extension Help on String {
  String get capitalize {
    if (isEmpty) return '';
    return this[0].toUpperCase() + substring(1);
  }
}

extension PriceFormat on num {
  static final f = NumberFormat("###,###,##0.##", "en_US");
  String get format => f.format(this);
}
