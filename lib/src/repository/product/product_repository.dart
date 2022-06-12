import 'package:hive/hive.dart';
import 'package:tektonlabs/src/infraestructure/hive_repository.dart';

import '../../infraestructure/api_response.dart';

import '../repository.dart';
import '../../models/models.dart';

abstract class ProductRepository extends Repository {
  ProductRepository(HiveInterface hiveInterface) : super(hiveInterface);

  Future<ApiResponse<List<Product>>> getList([int skip, int limit]);
  List<Product> getFavorites();
  void saveFavorite(Product product);
  void deleteFavorite(Product product);
  bool isFavorite(String id);
}

class ProductRepositoryImpl extends ProductRepository {
  ProductRepositoryImpl(HiveInterface hiveInterface) : super(hiveInterface) {
    ApiResponse.register<Product>(Product.fromJson);
  }

  @override
  Future<ApiResponse<List<Product>>> getList(
      [int skip = 0, int limit = 10]) async {
    final response = await dio.get('/products', queryParameters: {
      if (skip > 0) 'skip': skip,
      'limit': limit,
    });
    final result =
        ApiResponse.fromList<Product>(response, (a) => a['products']);
    return result;
  }

  @override
  List<Product> getFavorites() {
    final hive = HiveRepository(hiveInterface);
    final favorites = hive.getList('favorites');
    return List<Product>.from(favorites);
  }

  @override
  void saveFavorite(Product product) {
    final hive = HiveRepository(hiveInterface);
    hive.put('favorites', product.id.toString(), product);
  }

  @override
  void deleteFavorite(Product product) {
    final hive = HiveRepository(hiveInterface);
    hive.delete('favorites', product.id.toString());
  }

  @override
  bool isFavorite(String id) {
    final hive = HiveRepository(hiveInterface);
    return hive.get('favorites', id) != null;
  }
}
