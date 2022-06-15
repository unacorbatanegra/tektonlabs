import 'package:occam/occam.dart';

import 'filter_picker.dart';

class FilterController extends StateController<FilterPicker> {
  // final _isLoading = false.obs;
  final items = <FilterItem>[].rx;

  @override
  void readyState() {
    init();
    super.readyState();
  }

  void init() {
    items.addAll(widget.items);
  }

  void onSelected(int idx, Object item) {
    final filter = items[idx];
    if (filter.selected.contains(item)) {
      filter.selected.remove(item);
    } else {
      filter.selected.add(item);
    }
    items[idx] = filter;
    items.refresh();
  }

  void save() {
    navigator.pop(items);
  }

  void clear() {
    for (final u in items) {
      u.selected.clear();
    }
    items.refresh();
  }
}
