import 'package:tektonlabs/src/infraestructure/api_response.dart';

import '../repository.dart';
import '../../models/models.dart';

abstract class ProductRepository extends Repository {
  Future<ApiResponse<List<Product>>> getList();
}

class ProductRepositoryImpl extends ProductRepository {
  ProductRepositoryImpl() {
    ApiResponse.register<Product>(Product.fromJson);
  }
  @override
  Future<ApiResponse<List<Product>>> getList() async {
    final response = await dio.get('/products');
    final result = ApiResponse.fromList<Product>(response, (a) => a['products']);
    return result;
  }
}
