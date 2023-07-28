import 'package:flutter/material.dart';
import '../../domain/entity/product.entity.dart';
import '../../domain/usecase/product.usecase.dart';

import 'home.state.dart';

class HomeController extends ValueNotifier<HomeState> {
  final ProductUseCase _productRemote;
  List<Product> _product = <Product>[];
  HomeController(super._value, this._productRemote) {
    _onInit();
  }

  void _onInit() async {
    getProducts();
  }

  void getProducts() async {
    value = HomeStateLoading();
    final result = await _productRemote.fetchProducts();
    result.fold(
      (success) async {
        _product = success;
        await getProductFavorite();
        return value = HomeStateSuccess(products: _product);
      },
      (failure) => value = HomeStateError(message: failure.toString()),
    );
  }

  Future<void> getProductFavorite() async {
    final result = await _productRemote.fetchProductsLike();
    result.fold(
      (success) {
        for (var element in _product) {
          final index = success.indexWhere((e) => e.id == element.id);
          if (index != -1) {
            element.isFavorite = true;
          }
        }
        return value = HomeStateSuccess(products: _product);
      },
      (failure) => value = HomeStateError(message: failure.toString()),
    );
  }

  void likeProduct(Product product) async {
    value = HomeStateLoading();
    final result = await _productRemote.likeProduct(product);
    result.fold(
      (success) {
        final index = _product.indexWhere((e) => e.id == product.id);
        _product[index] = product;
        return value = HomeStateSuccess(products: _product);
      },
      (failure) {
        return value = HomeStateError(message: failure.toString());
      },
    );
  }
}
