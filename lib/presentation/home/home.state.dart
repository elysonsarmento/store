import 'package:flutter/foundation.dart';

import '../../domain/entity/product.entity.dart';

abstract class HomeState {
  HomeState();
}

class HomeStateInitial extends HomeState {}

class HomeStateLoading extends HomeState {
  HomeStateLoading();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeStateLoading;
  }

  @override
  int get hashCode => 0;
}

class HomeStateSuccess extends HomeState {
  final List<Product> products;

  HomeStateSuccess({this.products = const []});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeStateSuccess && listEquals(other.products, products);
  }

  @override
  int get hashCode => products.hashCode;
}

class HomeStateError extends HomeState {
  final String? message;
  HomeStateError({this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeStateError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
