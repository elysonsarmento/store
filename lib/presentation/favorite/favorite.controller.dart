import 'package:flutter/material.dart';
import 'package:store/domain/usecase/product.usecase.dart';

import 'favorite.state.dart';

class FavoriteController extends ValueNotifier<FavoriteState> {
  final ProductUseCase _favoriteUsecase;
  FavoriteController(super.value, this._favoriteUsecase) {
    _onInit();
  }

  void _onInit() async {
    getFavoriteProducts();
  }

  void getFavoriteProducts() async {
    value = FavoriteStateLoading();
    final result = await _favoriteUsecase.fetchProductsLike();
    result.fold(
      (success) {
        success = success.map((e) => e..isFavorite = true).toList();
        return value = FavoriteStateSuccess(products: success);
      },
      (failure) => value = FavoriteStateError(message: failure.toString()),
    );
  }
}
