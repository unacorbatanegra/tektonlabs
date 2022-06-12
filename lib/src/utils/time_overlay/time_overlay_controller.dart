import 'package:occam/occam.dart';

import 'time_overlay.dart';

class TimeOverlayController extends StateController<TimeOverlay> {
  final currentTime = DateTime.now().rx;

  @override
  void initState() {
    final time = widget.time ?? DateTime.now();
    final actual = time.minute;
    final min = 5 * (actual / 5).round();

    currentTime.value = DateTime(
      time.year,
      time.month,
      time.day,
      time.hour,
      min,
    );
    super.initState();
  }

  void onDateTime(DateTime value) {
    currentTime.value = value;
  }

  void accept() => navigator.pop(currentTime.value);

  void onClose() {
    navigator.pop();
  }
}
