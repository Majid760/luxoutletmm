import 'package:equatable/equatable.dart';

enum HomeScreenStatus { initial, loading, success, failure }

extension HomeScreenStatusX on HomeScreenStatus {
  bool get isInitial => this == HomeScreenStatus.initial;
  bool get isLoading => this == HomeScreenStatus.loading;
  bool get isSuccess => this == HomeScreenStatus.success;
  bool get isFailure => this == HomeScreenStatus.failure;
}

class HomeScreenState extends Equatable {
  final HomeScreenStatus? status;
  final List<String>? sliderImages;

  const HomeScreenState({
    this.status = HomeScreenStatus.initial,
    this.sliderImages = const [],
  });

  HomeScreenState copyWith({
    HomeScreenStatus? status,
    List<String>? sliderImages,
  }) {
    return HomeScreenState(
      status: status ?? this.status,
      sliderImages: sliderImages ?? this.sliderImages,
    );
  }

  @override
  String toString() => 'HomeScreenStateEmpty';
  @override
  List<Object?> get props => [
        status,
        sliderImages,
      ];
}
