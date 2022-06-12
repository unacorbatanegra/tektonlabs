import 'dart:async';

import 'package:flutter/material.dart';
import 'package:occam/occam.dart';

import '../../../src/models/models.dart';
import 'calendar_overlay.dart';

enum CalendarMode { day, month, year }

class CalendarOverlayController extends StateController<CalendarOverlay> {
  final title = ''.rx;

  final currentDate = DateTime.now().rx;
  final selectedDate = DateTime.now().rx;

  final calendarMode = CalendarMode.day.rx;

  StreamSubscription? sub;
  StreamSubscription? calendarModeSub;

  late CalendarMode returnMode;
  final years = <int>[];

  // CalendarOverlayController({
  //   required DateTime? date,
  //   required CalendarMode mode,
  // }) {
  //   if (date != null) {
  //     selectedDate.value = date;
  //     currentDate.value = date;
  //   }
  //   returnMode = mode;
  //   _calendarMode.value = mode;
  // }

  @override
  void readyState() {
    if (widget.date != null) {
      selectedDate.value = widget.date!;
      currentDate.value = widget.date!;
    }
    returnMode = widget.mode;
    calendarMode.value = widget.mode;

    years.addAll(List.generate(100, (index) => index));
    onDate(currentDate());
    calendarMode.addValueListener(onCalendar);
    currentDate.addValueListener(onDate);
    super.readyState();
  }

  void onDate(DateTime date) {
    if (calendarMode() == CalendarMode.day) {
      title.value = currentDate().calendarFormat;
    } else if (calendarMode() == CalendarMode.month) {
      title.value = currentDate().yearFormat;
    }
  }

  void onCalendar(mode) {
    onDate(currentDate());
  }

  void onTapDay(DateTime day) {
    navigator.pop(
      DateTime(
        day.year,
        day.month,
        day.day,
        selectedDate().hour,
        selectedDate().minute,
      ),
    );
  }

  void next() {
    if (calendarMode() == CalendarMode.month) {
      currentDate.value = DateTime(
        currentDate().year + 1,
        currentDate().month,
        currentDate().day,
      );
    } else {
      currentDate.value = DateUtils.addMonthsToMonthDate(currentDate(), 1);
    }
  }

  void back() {
    if (calendarMode() == CalendarMode.month) {
      currentDate.value = DateTime(
        currentDate().year - 1,
        currentDate().month,
        currentDate().day,
      );
    } else {
      currentDate.value = DateTime(
        currentDate().year,
        currentDate().month - 1,
        currentDate().day,
      );
    }
  }

  @override
  void dispose() {
    calendarModeSub?.cancel();
    sub?.cancel();
    super.dispose();
  }

  void today() => navigator.pop(DateTime.now());

  void onTapMonth(int month) {
    final date = DateTime(currentDate().year, month, currentDate().day);
    if (returnMode == CalendarMode.month) {
      navigator.pop(date);
      return;
    }
    currentDate.value = date;
    currentDate.refresh();
    calendarMode.value = CalendarMode.day;
  }

  void onTapYear(int year) {
    final date = DateTime(year, currentDate().month, currentDate().day);
    if (returnMode == CalendarMode.year) {
      navigator.pop(date);
      return;
    }
    currentDate.value = date;
    currentDate.refresh();

    calendarMode.value = CalendarMode.month;
  }

  void onTapTitle() {
    if (calendarMode() == CalendarMode.day) {
      calendarMode.value = CalendarMode.month;
    } else if (calendarMode() == CalendarMode.month) {
      calendarMode.value = CalendarMode.year;
    }
  }

  void onClose() {
    navigator.pop();
  }
}
