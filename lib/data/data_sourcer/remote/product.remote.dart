import 'package:store/data/model/product.model.dart';

import '../../../domain/entity/product.entity.dart';
import '../../../provider/http.dart';
import '../../../provider/result.dart';

class ProductRemote {
  final ApiService _apiService;
  final String _baseUrl = 'http://fakestoreapi.com';

  ProductRemote(this._apiService);
  Future<Result<List<Product>, Exception>> getProducts() async {
    try {
      final response = await _apiService
          .getAll('$_baseUrl/products', queryParameters: {'limit': 100});
      final products = (response).map((e) => ProductModel.fromMap(e)).toList();
      return Success(products);
    } catch (e) {
      return Failure(Exception('Erro ao buscar produtos'));
    }
  }

  Future<Result<Product, Exception>> getProductById(int id) async {
    try {
      final response = await _apiService.getOne('$_baseUrl/products/$id');
      final product = ProductModel.fromMap(response);
      return Success(product);
    } catch (e) {
      return Failure(Exception('Erro ao buscar produto'));
    }
  }
}
