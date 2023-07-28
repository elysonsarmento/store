import 'package:flutter/foundation.dart';

import '../../domain/entity/product.entity.dart';

abstract class FavoriteState {
  FavoriteState();
}

class FavoriteStateLoading extends FavoriteState {
  FavoriteStateLoading();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteStateLoading;
  }

  @override
  int get hashCode => 0;
}

class FavoriteStateSuccess extends FavoriteState {
  final List<Product> products;

  FavoriteStateSuccess({this.products = const []});

  @override
  int get hashCode => products.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteStateSuccess &&
        listEquals(other.products, products);
  }
}

class FavoriteStateError extends FavoriteState {
  final String? message;
  FavoriteStateError({this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteStateError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
