import '../presentation/widgets/widgets.dart';
import 'calendar_overlay/calendar_overlay.dart';
import 'calendar_overlay/calendar_overlay_controller.dart';
import 'filter_picker/filter_picker.dart';
import 'modal_picker_overlay/modal_picker_overlay.dart';
import 'time_overlay/time_overlay.dart';

mixin ModalPicker {
  static bool _isModalOpen = false;

  static Future<List<FilterItem>> filter({
    required List<FilterItem> items,
    required BuildContext context,
  }) async {
    final result = await showCupertinoModalPopup(
      context: context,
      builder: (ctx) => FilterPicker(items: items),
    ) as List<FilterItem>?;
    if (result == null) return items;
    return result;
  }

  static Future<T?> modalPick<T>({
    required BuildContext context,
    required String label,
    required List<T> list,
    required T? item,
    required String Function(T value) toText,
  }) async {
    if (_isModalOpen) return null;
    _isModalOpen = true;

    // final result = await showModalBottomSheet(

    final result = await showCupertinoModalPopup(
      context: context,
      builder: (ctx) => ModalPickerOverlay(
        label: label,
        list: list,
        item: item,
        toText: toText,
      ),
      // isScrollControlled: true,
    );
    _isModalOpen = false;
    return result;
  }

  static Future<DateTime?> datePicker({
    required BuildContext context,
    required DateTime? date,
    CalendarMode mode = CalendarMode.day,
  }) async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (
        ctx,
      ) =>
          CalendarOverlay(
        date: date,
        mode: mode,
      ),
      isScrollControlled: true,
      useRootNavigator: true,
    );
    // final result = await Get.bottomSheet(
    //   isScrollControlled: true,
    //   useRootNavigator: true,
    // );
    return result ?? date;
  }

  static Future<DateTime?> timePicker({
    required BuildContext context,
    required DateTime? date,
  }) async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (ctx) => TimeOverlay(
        time: date,
      ),
      isScrollControlled: true,
      useRootNavigator: true,
    );
    return result ?? date;
  }
}
