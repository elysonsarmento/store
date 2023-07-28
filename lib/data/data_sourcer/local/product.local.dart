import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/data/model/product.model.dart';
import 'package:store/provider/result.dart';

import '../../../domain/entity/product.entity.dart';

class ProductLocal {
  late SharedPreferences prefs;

  Future<void> _setPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<Result<List<Product>, Exception>> getProducts() async {
    try {
      await _setPrefs();
      final productsString = prefs.getString('products');
      if (productsString == null) {
        return const Success([]);
      }

      final products = List<Product>.from(
        (json.decode(productsString) as List).map((product) {
          product as String;
          return ProductModel.fromJson(product);
        }),
      );

      return Success(products);
    } catch (e) {
      return Failure(Exception('Erro ao buscar produtos'));
    }
  }

  Future<Result<void, Exception>> saveProduct(Product product) async {
    try {
      await _setPrefs();

      final productsString = prefs.getString('products');
      List<ProductModel> productsList;

      if (productsString == null) {
        productsList = [(product as ProductModel)];
      } else {
        final products = (json.decode(productsString) as List).map((product) {
          product as String;
          return ProductModel.fromJson(product);
        }).toList();
        if (!products.contains(product)) {
          products.add(product as ProductModel);
        } else {
          products.remove(product);
        }

        productsList = products;
      }

      final updatedProductsString = json.encode(productsList);
      prefs.setString('products', updatedProductsString);
      return const Success(null);
    } catch (e) {
      return Failure(Exception('Erro ao salvar produto'));
    }
  }
}
