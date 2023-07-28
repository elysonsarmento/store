import 'package:store/domain/entity/product.entity.dart';

import '../../provider/result.dart';

abstract interface class IProductRepository {
  Future<Result<List<Product>, Exception>> getProducts();
  Future<Result<Product, Exception>> getProductById(int id);
  Future<Result<List<Product>, Exception>> getProductsLike();
  Future<Result<void, Exception>> likeProduct(Product product);
}
