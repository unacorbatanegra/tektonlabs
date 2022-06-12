import '../domain.dart';

abstract class ProductDomain extends Domain {
  final ProductRepository repository;
  ProductDomain(this.repository);
  Future<List<Product>> getList([int skip, int limit]);
  Future<List<Product>> getFavorites();
  void saveFavorite(Product product);
  void deleteFavorite(Product product);
  bool isFavorite(String id);
}

class ProductDomainImpl extends ProductDomain {
  ProductDomainImpl(ProductRepository repository) : super(repository);
  @override
  void init() {}

  @override
  Future<List<Product>> getList([int skip = 0, limit = 10]) async {
    final response = await repository.getList(skip, limit);
    if (response.isNotError) {
      return response.data!;
    }
    showError(response);
    return [];
  }

  @override
  Future<List<Product>> getFavorites() async {
    return repository.getFavorites();
  }

  @override
  void saveFavorite(Product product) => repository.saveFavorite(product);

  @override
  void deleteFavorite(Product product) => repository.deleteFavorite(product);

  @override
  bool isFavorite(String id) => repository.isFavorite(id);
}
