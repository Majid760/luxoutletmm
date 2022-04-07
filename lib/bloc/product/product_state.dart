import 'package:equatable/equatable.dart';
import 'package:luxoutlet/data/model/product.dart';

enum ProductStatus { initial, loading, success, failure }

extension ProductStatusX on ProductStatus {
  bool get isInitial => this == ProductStatus.initial;
  bool get isLoading => this == ProductStatus.loading;
  bool get isSuccess => this == ProductStatus.success;
  bool get isFailure => this == ProductStatus.failure;
}

class ProductState extends Equatable {
  final ProductStatus? status;
  final List<Products>? productList;
  final List<Products>? subCategoryProducts;

  const ProductState(
      {this.status = ProductStatus.initial,
      this.productList = const [],
      this.subCategoryProducts = const []});

  ProductState copyWith(
      {ProductStatus? status,
      List<Products>? productList,
      List<Products>? subCategoryProducts}) {
    return ProductState(
      status: status ?? this.status,
      productList: productList ?? this.productList,
      subCategoryProducts: subCategoryProducts ?? this.subCategoryProducts,
    );
  }

  @override
  String toString() => 'ProductStateEmpty';
  @override
  List<Object?> get props => [status, productList, subCategoryProducts];
}
