import '../../provider/result.dart';
import '../entity/product.entity.dart';
import '../repository/product.repository.dart';

class ProductUseCase {
  final IProductRepository _productRepository;
  ProductUseCase(
    this._productRepository,
  );

  Future<Result<List<Product>, Exception>> fetchProducts() async {
    final product = await _productRepository.getProducts();

    return product;
  }

  Future<Result<Product, Exception>> fetchProductById(int id) async {
    return await _productRepository.getProductById(id);
  }

  Future<Result<List<Product>, Exception>> fetchProductsLike() async {
    return await _productRepository.getProductsLike();
  }

  Future<Result<void, Exception>> likeProduct(Product product) async {
    return await _productRepository.likeProduct(product);
  }
}
