import 'package:cached_network_image/cached_network_image.dart';
import '../../../../models/models.dart';
import '../../../widgets/widgets.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  const ProductWidget({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      padding: zero,
      child: Container(
        decoration: BoxDecoration(
          color: Palette.blue,
          // border: Border.all(color: Palette.gray5, width: .5),
          borderRadius: BorderRadius.circular(6.0),
        ),
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 70,
              child: CachedNetworkImage(
                cacheKey: product.id.toString(),
                imageUrl: product.thumbnail,
                placeholder: (ctx, url) => loadingIndicator,
                imageBuilder: (ctx, image) => Container(
                  
                  // constraints: const BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    image: DecorationImage(
                      image: image,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${product.price.format} \$",
                  style: context.s1?.copyWith(color: Colors.white),
                ),
              ],
            ),
            Flexible(
              flex: 30,
              child: Text(
                product.title,
                style: context.s2?.copyWith(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
