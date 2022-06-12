import 'package:ff_annotation_route_core/ff_annotation_route_core.dart';
import 'package:occam/occam.dart';

import '../../../models/models.dart';
import '../../widgets/widgets.dart';
import '../home/widgets/product_widget.dart';
import 'favorites_controller.dart';

@FFRoute(name: "/favorites")
class FavoritesPage extends StateWidget<FavoritesController> {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  FavoritesController createState() => FavoritesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: RxWidget<bool>(
          notifier: state.isLoading,
          builder: (context, value) {
            if (value) return loadingIndicator;
            return RxWidget<List<Product>>(
              notifier: state.list,
              builder: (ctx, list) {
                if (list.isEmpty) {
                  return const Center(
                    child: Text('Add your first item to favorites'),
                  );
                }
                return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 13 / 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: list
                      .map(
                        (e) => ProductWidget(
                          product: e,
                          onTap: () => state.onTap(e),
                        ),
                      )
                      .toList(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
