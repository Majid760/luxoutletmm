import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luxoutlet/bloc/ui/homescreen_cubit/homescreen_state.dart';
import 'package:luxoutlet/data/repository/home_screen_repository.dart';

// Category Cubit
class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(const HomeScreenState());

  // initia state
  HomeScreenState get initialState => const HomeScreenState();

  @override
  void onError(Object error, StackTrace stackTrace) {
    debugPrint('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

  // get slider images
  void getSliderImages() {
    emit(state.copyWith(status: HomeScreenStatus.loading));
    emit(state.copyWith(
        status: HomeScreenStatus.loading,
        sliderImages: HomeScreenRepository().getSlideImages));
  }
}
