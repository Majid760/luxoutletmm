import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luxoutlet/bloc/product/product_state.dart';
import 'package:luxoutlet/data/model/product.dart';
import 'package:luxoutlet/data/repository/product_repository.dart';

// BLoC
class ProductCubit extends Cubit<ProductState> {
  ProductRepository? productRepository;
  ProductCubit({@required this.productRepository})
      : super(const ProductState());

  // get the whole products
  Future<void> getProducts() async {
    try {
      emit(state.copyWith(
          status: ProductStatus.loading,
          productList: [],
          subCategoryProducts: []));
      emit(state.copyWith(
          status: ProductStatus.success,
          productList: state.productList!.isEmpty
              ? await productRepository!.getProducts()
              : state.productList));
    } on Exception {
      emit(state.copyWith(status: ProductStatus.failure));
    }
  }

  // get the whole subCategoryproducts
  Future<void> getSubCategoryProducts(int id) async {
    try {
      emit(state.copyWith(status: ProductStatus.loading));
      List<Products>? productsList =
          await productRepository!.getListOfSubCategoryProducts(id);
      emit(state.copyWith(
          status: ProductStatus.success, subCategoryProducts: productsList));
    } on Exception {
      emit(state.copyWith(status: ProductStatus.failure));
    }
  }
}





// if (event is FetchProductsOfSingleSubCategory) {
//       yield ProductLoadingState();
//       try {
//         List<Products>? productsList = await productRepository!
//             .getListOfSubCategoryProducts(event.getSubCatId!);
//         yield SubCategoryProductsLoadedState(productsList);
//       } catch (_) {
//         const ProductErrorState('there is some error to fetch the products!');
//       }
//     }