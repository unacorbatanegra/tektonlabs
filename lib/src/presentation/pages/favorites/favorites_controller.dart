import 'package:occam/occam.dart';

import '../../../domain/domains.dart';
import '../../../routes/routes.dart';

class FavoritesController extends StateController {
  final isLoading = false.rx;
  final list = <Product>[].rx;
  final domain = getIt.get<ProductDomain>();
  @override
  void readyState() {
    init();
    super.readyState();
  }

  void init() async {
    isLoading.value = true;
    list.asignAll(await domain.getFavorites());
    isLoading.value = false;
  }

  void onTap(Product e) {
    navigator.pushNamed(RouteName.product, arguments: {'data': e});
  }
}
