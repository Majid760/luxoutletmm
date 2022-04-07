import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luxoutlet/bloc/cart/cart_state.dart';
import 'package:luxoutlet/data/model/product.dart';

// Category Cubit
class CartCubit extends Cubit<CartState> {
  // ProductRepository? productRepository;
  CartCubit() : super(const CartState());

  // initia state
  CartState get initialState => const CartState();

  @override
  void onError(Object error, StackTrace stackTrace) {
    debugPrint('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

  // add product to cart
  void addProductToCart(Products product) {
    emit(state.copyWith(status: CartStatus.loading));
    emit(state.copyWith(
        status: CartStatus.success,
        cartProductList: [...?state.cartProductList, product],
        total: state.total! + product.price!));
  }

  // subt product from cart
  void removeProductFromCart(Products product) {
    emit(state.copyWith(status: CartStatus.loading));
    List<Products>? products = state.cartProductList;
    products!.remove(product);
    double? total = state.total! - product.price!;
    emit(state.copyWith(
        status: CartStatus.success, cartProductList: products, total: total));
  }

  // add the products to liked items
  void addProductToFavorite(Products product) {
    emit(state.copyWith(status: CartStatus.loading));
    emit(state.copyWith(
      status: CartStatus.success,
      favoriteProducts: _getFavoriteProds(product)
          ? [...?state.cartProductList, product]
          : state.favoriteProducts,
    ));
  }

  bool _getFavoriteProds(Products product) {
    if (state.favoriteProducts!.contains(product)) {
      state.favoriteProducts!.remove(product);
      return false;
    } else {
      return true;
    }
  }
}
