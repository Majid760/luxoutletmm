import 'package:equatable/equatable.dart';
import 'package:luxoutlet/data/model/category.dart';

// Category State

enum CategoryStatus { initial, loading, success, failure }

extension CategoryStatusX on CategoryStatus {
  bool get isInitial => this == CategoryStatus.initial;
  bool get isLoading => this == CategoryStatus.loading;
  bool get isSuccess => this == CategoryStatus.success;
  bool get isFailure => this == CategoryStatus.failure;
}

class CategoryState extends Equatable {
  final List<Category>? categoryList;
  final List? subCategoryList;
  final CategoryStatus? status;

  const CategoryState({
    this.status = CategoryStatus.initial,
    this.categoryList = const [],
    this.subCategoryList = const [],
  });

  CategoryState copyWith({
    CategoryStatus? status,
    List<Category>? categoryList,
    List? subCategoryList,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categoryList: categoryList ?? this.categoryList,
      subCategoryList: subCategoryList ?? this.subCategoryList,
    );
  }

  @override
  List<Object?> get props => [categoryList, subCategoryList, status];

  @override
  String toString() =>
      'SearchStateSuccess { Categorys: ${categoryList!.length} }';
}
