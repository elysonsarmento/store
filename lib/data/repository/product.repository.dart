import 'package:store/data/data_sourcer/local/product.local.dart';
import 'package:store/domain/entity/product.entity.dart';

import '../../domain/repository/product.repository.dart';
import '../../provider/result.dart';
import '../data_sourcer/remote/product.remote.dart';

class ProductRepository implements IProductRepository {
  final ProductRemote _productRemote;
  final ProductLocal _productLocal;

  ProductRepository(this._productRemote, this._productLocal);
  @override
  getProductById(int id) async {
    return await _productRemote.getProductById(id);
  }

  @override
  getProducts() async {
    return await _productRemote.getProducts();
  }

  @override
  Future<Result<List<Product>, Exception>> getProductsLike() {
    return _productLocal.getProducts();
  }

  @override
  Future<Result<void, Exception>> likeProduct(Product product) {
    return _productLocal.saveProduct(product);
  }
}
