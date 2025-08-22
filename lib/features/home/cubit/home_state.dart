import 'package:equatable/equatable.dart';
import 'package:motels/features/home/domain/entities/motel_entity.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<MotelEntity> motels;
  final List<String> selectedFilters;
  final int selectedIndex;
  final String selectedCity;
  final String selectedInitialDate;
  final String selectedFinalDate;
  final List<String> favoriteTempList;

  const HomeLoaded({
    required this.motels,
    required this.selectedFilters,
    required this.selectedIndex,
    required this.selectedCity,
    required this.selectedInitialDate,
    required this.selectedFinalDate,
    required this.favoriteTempList,
  });

  HomeLoaded copyWith({
    List<MotelEntity>? motels,
    List<String>? selectedFilters,
    int? selectedIndex,
    String? selectedCity,
    String? selectedInitialDate,
    String? selectedFinalDate,
    List<String>? favoriteTempList,
  }) {
    return HomeLoaded(
      motels: motels ?? this.motels,
      selectedFilters: selectedFilters ?? this.selectedFilters,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedInitialDate: selectedInitialDate ?? this.selectedInitialDate,
      selectedFinalDate: selectedFinalDate ?? this.selectedFinalDate,
      favoriteTempList: favoriteTempList ?? this.favoriteTempList,
    );
  }

  @override
  List<Object?> get props => [
        motels,
        selectedFilters,
        selectedIndex,
        selectedCity,
        selectedInitialDate,
        selectedFinalDate,
        favoriteTempList,
      ];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
