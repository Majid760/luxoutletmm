import 'package:equatable/equatable.dart';
import 'package:luxoutlet/data/model/product.dart';

enum CartStatus { initial, loading, success, failure }

extension CartStatusX on CartStatus {
  bool get isInitial => this == CartStatus.initial;
  bool get isLoading => this == CartStatus.loading;
  bool get isSuccess => this == CartStatus.success;
  bool get isFailure => this == CartStatus.failure;
}

class CartState extends Equatable {
  final CartStatus? status;
  final List<Products>? cartProductList;
  final double? total;
  final List<Products>? favoriteProducts;
  final Products? product;

  const CartState(
      {this.product,
      this.status = CartStatus.initial,
      this.cartProductList = const [],
      this.favoriteProducts = const [],
      this.total = 0.0});

  CartState copyWith(
      {CartStatus? status,
      Products? product,
      List<Products>? cartProductList,
      List<Products>? favoriteProducts,
      double? total}) {
    return CartState(
      status: status ?? this.status,
      product: product ?? this.product,
      cartProductList: cartProductList ?? this.cartProductList,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      total: total ?? this.total,
    );
  }

  @override
  String toString() => 'ProductCartStateEmpty';
  @override
  List<Object?> get props =>
      [status, product, cartProductList, favoriteProducts, total];
}
