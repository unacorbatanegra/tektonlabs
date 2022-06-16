import 'package:occam/occam.dart';
import 'package:tektonlabs/src/routes/routes.dart';

import '../../../domain/domains.dart';
import '../../widgets/widgets.dart';

class HomeController extends StateController {
  final list = <Product>[].rx;
  final full = <Product>[];
  final length = 0.rx;
  final isSearching = false.rx;
  final isLoadingMore = false.rx;
  final isLoading = false.rx;
  late TextEditingController controller;
  late ScrollController scroll;

  final domain = getIt.get<ProductDomain>();
  final map = <String, List<Lookup>>{};
  @override
  void initState() {
    controller = TextEditingController();
    scroll = ScrollController();
    scroll.addListener(onScroll);
    map['selectedFilterBrand'] ??= [];
    map['selectedFilterCategory'] ??= [];
    super.initState();
  }

  @override
  void readyState() {
    init();
  }

  Future<void> init() async {
    isLoading.value = true;
    final result = await domain.getList(length.value, 5);
    list.assignAll(result);
    full.assignAll(list);
    filter();
    isLoading.value = false;
  }

  var preventCall = false;

  Future<void> loadMore() async {
    isLoadingMore.value = true;
    final result = await domain.getList(length.value);
    await Future.delayed(const Duration(milliseconds: 500));
    isLoadingMore.value = false;
    list.addAll(result);
    full.assignAll(list);
    length.value = full.length;
  }

  @override
  void dispose() {
    controller.dispose();
    scroll.removeListener(onScroll);
    scroll.dispose();
    length.dispose();
    isLoading.dispose();
    isSearching.dispose();
    list.dispose();
    super.dispose();
    // list[0];
  }

  void toSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      controller.clear();
      filter();
    }
  }

  void onFilter() async {
    if (isLoading()) return;
    map['filterBrand'] = full.toListLookup(
      (e) => Lookup(id: e.brand, name: e.brand),
    );
    map['filterCategory'] = full.toListLookup(
      (e) => Lookup(id: e.category, name: e.category),
    );

    final r = await ModalPicker.filter(
      context: context,
      items: [
        FilterItem(
          items: map['filterBrand']!,
          label: 'Brand',
          selected: map['selectedFilterBrand']!,
          toText: (a) => a.name,
        ),
        FilterItem(
          items: map['filterCategory']!,
          label: 'Category',
          selected: map['selectedFilterCategory']!,
          toText: (a) => (a.name).toString().capitalize.replaceAll('-', ' '),
        ),
      ],
    );
    final brand = r[0];
    final category = r[1];

    map['selectedFilterBrand']!.assignAll(
      List<Lookup>.from(brand.selected),
    );
    map['selectedFilterCategory']!.assignAll(
      List<Lookup>.from(category.selected),
    );

    filter();
  }

  void filter([String? value]) {
    list.assignAll(
      full.where(
        (e) =>
            e.title.toLowerCase().contains(controller.text.toLowerCase()) &&
            map['selectedFilterBrand']!.filter(
              (id) => id == e.brand,
            ) &&
            map['selectedFilterCategory']!.filter(
              (id) => id == e.category,
            ),
      ),
    );
    length.value = list.length;
  }

  void onChanged(String value) {
    filter(value);
  }

  void onTap(Product e) {
    navigator.pushNamed(RouteName.product, arguments: {'data': e});
  }

  void onScroll() {
    var position = scroll.position.pixels;
    if (position >= scroll.position.maxScrollExtent - 10) {
      if (!preventCall) {
        loadMore().then((_) => preventCall = false);
        preventCall = true;
      }
    }
  }

  Future<void> onRefresh() async {
    isLoading.value = true;
    final result = await domain.getList(0, full.length);
    full.assignAll(result);
    filter();

    isLoading.value = false;
  }

  void toFavorites() {
    navigator.pushNamed(RouteName.favorites);
  }
}
