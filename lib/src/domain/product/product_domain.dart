import '../domain.dart';

abstract class ProductDomain extends Domain {
  final ProductRepository repository;
  ProductDomain(this.repository);
  Future<List<Product>> getList();
}

class ProductDomainImpl extends ProductDomain {
  ProductDomainImpl(ProductRepository repository) : super(repository);
  @override
  void init() {}
  @override
  Future<List<Product>> getList() async {
    final response = await repository.getList();
    if (response.isNotError) {
      return response.data!;
    }
    showError(response);
    return [];
  }
}
