import 'package:occam/occam.dart';
import '../../widgets/widgets.dart';
import '../../../domain/domains.dart';

class HomeController extends StateController {
  final list = <Product>[].rx;
  final length = 0.rx;
  final isSearching = false.rx;
  final isLoading = false.rx;
  late TextEditingController controller;

  final domain = getIt.get<ProductDomain>();
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void readyState() {
    init();
  }

  void init() async {
    isLoading.value = true;
    final result = await domain.getList();
    list.asignAll(result);
    length.value = list.length;
    isLoading.value = false;
  }

  @override
  void dispose() {
    controller.dispose();
    length.dispose();
    isLoading.dispose();
    isSearching.dispose();
    list.dispose();
    super.dispose();
    // list[0];
  }

  void toSearch() {
    isSearching.value = !isSearching.value;
  }

  void onFilter() {}

  void onChanged(String value) {}

  void onTap(Product e) {}
}
