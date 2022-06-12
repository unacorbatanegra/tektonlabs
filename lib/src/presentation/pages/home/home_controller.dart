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
  @override
  void initState() {
    controller = TextEditingController();
    scroll = ScrollController();
    scroll.addListener(onScroll);
    super.initState();
  }

  @override
  void readyState() {
    init();
  }

  Future<void> init() async {
    isLoading.value = true;
    final result = await domain.getList(length.value, 5);
    list.asignAll(result);
    full.clear();
    full.addAll(list);
    length.value = list.length;
    isLoading.value = false;
  }

  var preventCall = false;

  Future<void> loadMore() async {
    isLoadingMore.value = true;
    final result = await domain.getList(length.value);
    await Future.delayed(const Duration(milliseconds: 500));
    isLoadingMore.value = false;
    list.addAll(result);
    full.clear();
    full.addAll(list);
    length.value = list.length;
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
    }
    onChanged(controller.text);
  }

  void onFilter() {}

  void onChanged(String value) {
    list.asignAll(
      full.where(
        (e) => e.title.toLowerCase().contains(value.toLowerCase()),
      ),
    );
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
    final result = await domain.getList(0, list.length);
    list.asignAll(result);
    length.value = list.length;
    isLoading.value = false;
  }

  void toFavorites() {
    navigator.pushNamed(RouteName.favorites);
  }
}
