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
    list.assignAll(await domain.getFavorites());
    isLoading.value = false;
  }

  void onTap(Product e) async {
    final result = await navigator.pushNamed(
      RouteName.product,
      arguments: {'data': e},
    ) as bool?;
    if (result ?? false) list.assignAll(await domain.getFavorites());
  }
}
