import 'package:occam/occam.dart';

import '../../presentation/widgets/widgets.dart';
import 'calendar_overlay_controller.dart';
import 'widgets/day_picker.dart';
import 'widgets/month_picker.dart';
import 'widgets/year_picker.dart';

class CalendarOverlay extends StateWidget<CalendarOverlayController> {
  final DateTime? date;
  final CalendarMode mode;

  const CalendarOverlay({
    Key? key,
    required this.date,
    required this.mode,
  }) : super(key: key);

  @override
  CalendarOverlayController createState() => CalendarOverlayController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      constraints: BoxConstraints(maxHeight: context.h * .6),
      child: Column(
        children: [
          AppBar(
            centerTitle: true,
            leading: CupertinoButton(
              child: const Icon(Icons.close),
              onPressed: state.onClose,
            ),
            title: Text(
              'Calendar',
              style: context.h7,
            ),
            actions: [
              CupertinoButton(
                child: const Text('Today'),
                onPressed: state.today,
              )
            ],
          ),
          RxWidget<CalendarMode>(
            notifier: state.calendarMode,
            builder: (ctx, calendarMode) {
              if (calendarMode == CalendarMode.year) {
                return emptyWidget;
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Icon(Icons.arrow_back_ios),
                    onPressed: state.back,
                  ),
                  RxWidget<String>(
                    notifier: state.title,
                    builder: (ctx, title) => InkWell(
                      onTap: state.onTapTitle,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                        style: context.s1,
                      ),
                    ),
                  ),
                  CupertinoButton(
                    child: const Icon(Icons.arrow_forward_ios),
                    onPressed: state.next,
                  ),
                ],
              );
            },
          ),
          gap16,
          Expanded(
            child: RxWidget<CalendarMode>(
              notifier: state.calendarMode,
              builder: (ctx, calendarMode) {
                switch (calendarMode) {
                  case CalendarMode.day:
                    return const DayPicker();
                  case CalendarMode.month:
                    return const MonthPicker();
                  case CalendarMode.year:
                    return const YearPicker();
                  default:
                    return emptyWidget;
                }
              },
            ),
          ),
          gap36,
          gap18,
        ],
      ),
    );
  }
}
