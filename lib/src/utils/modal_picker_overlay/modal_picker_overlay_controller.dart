// import 'package:get/get.dart' hide navigator;
import 'package:occam/occam.dart';

import 'modal_picker_overlay.dart';

class ModalPickerOverlayController<T>
    extends StateController<ModalPickerOverlay<T>> {
  final listShow = <T>[].rx;

  @override
  void readyState() {
    listShow.clear();
    listShow.addAll(widget.list);
  }

  void onTap(T e) {
    navigator.pop(e);
  }

  void onSearch(String value) {
    listShow.clear();
    listShow.addAll(
      widget.list.where(
        (e) => widget.toText(e).toLowerCase().contains(
              value.toLowerCase(),
            ),
      ),
    );
  }

  void back() {
    navigator.pop();

    // showCupertinoModalPopup(context: context, builder: ))
  }

  @override
  void dispose() {
    listShow.dispose();
    super.dispose();
  }
}
