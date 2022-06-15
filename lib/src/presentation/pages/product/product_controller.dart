import 'package:occam/occam.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../domain/domains.dart';

class ProductController extends StateController {
  final favorite = false.rx;
  final isLoading = true.rx;
  late Rx<Product> product;

  final domain = getIt.get<ProductDomain>();
  @override
  void readyState() {
    product = Rx<Product>((navArgs! as Map)['data']);
    isLoading.value = false;
    favorite.value = domain.isFavorite(product.value.id.toString());
    super.readyState();
  }

  void onFavorite() {
    if (!favorite.value) {
      domain.saveFavorite(product.value);
      domain.showSucces('Product added to favorites');
      favorite.value = true;
    } else {
      domain.deleteFavorite(product.value);
      favorite.value = false;
      domain.showInfo('Product remove from favorites');
    }
  }

  void onUrl() async {
    if (!await DialogHelper.ifDialog(
      context: context,
      message: 'Are you sure do you want to open an external link?',
      title: 'Confirm',
    )) {
      return;
    }
    if (await canLaunchUrlString(
        'https://www.linkedin.com/in/unacorbatanegra/')) {
      launchUrlString('https://www.linkedin.com/in/unacorbatanegra/');
    }
  }

  Future<bool> onWillPop() async {
    navigator.pop(!favorite.value);
    return true;
  }
}
