import 'package:cached_network_image/cached_network_image.dart';
import 'package:ff_annotation_route_core/ff_annotation_route_core.dart';
import 'package:occam/occam.dart';
import '../../widgets/widgets.dart';

import '../../../models/models.dart';
import 'product_controller.dart';

@FFRoute(name: '/product')
class ProductPage extends StateWidget<ProductController> {
  const ProductPage({Key? key}) : super(key: key);

  @override
  ProductController createState() => ProductController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Product'),
        actions: [
          CupertinoButton(
            child: const Icon(Majes.link_line),
            onPressed: state.onUrl,
          ),
          RxWidget<bool>(
            notifier: state.favorite,
            builder: (ctx, value) {
              return CupertinoButton(
                onPressed: state.onFavorite,
                child: Icon(
                  value ? Majes.heart : Majes.heart_line,
                ),
              );
            },
          )
        ],
      ),
      body: RxWidget<bool>(
        notifier: state.isLoading,
        builder: (ctx, isLoading) {
          if (isLoading) return loadingIndicator;
          return RxWidget<Product>(
            notifier: state.product,
            builder: (ctx, product) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Palette.blue,
                      height: 256,
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: PageView.builder(
                          controller: PageController(viewportFraction: .8),
                          itemCount: product.images.length,
                          itemBuilder: (ctx, idx) {
                            final image = product.images[idx];
                            return CachedNetworkImage(
                              cacheKey: image,
                              imageUrl: image,
                              placeholder: (ctx, url) => loadingIndicator,
                              imageBuilder: (ctx, image) => AspectRatio(
                                aspectRatio: 16.9,
                                child: Container(
                                  padding: const EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    // border: Border.all(),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6.0),
                                    image: DecorationImage(
                                      image: image,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                ),
                              ),
                            ).paddingOnly(right: 16.0);
                          },
                        ),
                      ),
                    ),
                    gap16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 70,
                          child: Text(
                            product.title,
                            style: context.s2?.copyWith(
                              fontSize: 26.0,
                              color: Palette.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 30,
                          child: Text(
                            "${product.price.format} \$",
                            style: context.s1?.copyWith(fontSize: 20.0),
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 16.0),
                    gap8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Category: ${product.category.capitalize.replaceAll('-', ' ')}',
                            style: context.s1,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${product.stock} in Stock',
                            style: context.s1,
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 16.0),
                    gap16,
                    Text(
                      product.description,
                    ).paddingSymmetric(horizontal: 16.0)
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
