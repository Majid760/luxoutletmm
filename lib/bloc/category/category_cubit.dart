import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luxoutlet/bloc/category/category_state.dart';
import 'package:luxoutlet/data/model/category.dart';
import 'package:luxoutlet/data/repository/category_repository.dart';

// Category Cubit
class CategoryCubit extends Cubit<CategoryState> {
  CategoryRepository? categoryRepository;
  CategoryCubit({@required this.categoryRepository})
      : super(const CategoryState());

  // initia state
  CategoryState get initialState => const CategoryState();

  @override
  void onError(Object error, StackTrace stackTrace) {
    debugPrint('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

  // get the whole categories
  Future<void> getCategories() async {
    addError(Exception('getProducts error!'), StackTrace.current);
    try {
      emit(state.copyWith(status: CategoryStatus.loading));
      List<Category>? categoriesList =
          await categoryRepository!.getCategoriesFromDB();
      emit(state.copyWith(
          status: CategoryStatus.success, categoryList: categoriesList));
    } on Exception {
      emit(state.copyWith(status: CategoryStatus.failure));
    }
  }

  // get the whole products
  Future<void> getSubCategories(int parentCategoryId) async {
    try {
      emit(state.copyWith(status: CategoryStatus.loading));
      final List? categoriesList =
          await categoryRepository!.getSubCategoriesFromDB(parentCategoryId);
      emit(state.copyWith(
          status: CategoryStatus.success, subCategoryList: categoriesList));
    } on Exception {
      emit(state.copyWith(status: CategoryStatus.failure));
    }
  }
}
