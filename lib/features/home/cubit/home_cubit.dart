import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motels/core/database/filter_data.dart';
import 'package:motels/features/home/cubit/home_state.dart';
import 'package:motels/features/home/repository/home_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final IHomeRepository _repository;
  final PageController pageController = PageController();

  HomeCubit({required IHomeRepository repository})
      : _repository = repository,
        super(const HomeInitial());

  final List<String> itemsFilter = FilterDatabase.itemsFilter;

  Future<void> setupConfigs() async {
    await loadMotels();
  }

  Future<void> loadMotels() async {
    emit(const HomeLoading());

    final result = await _repository.getMotels(
      page: 1,
      latitude: -23.5505,
      longitude: -46.6333,
    );

    result.when(
      (error) => emit(HomeError(message: error.message)),
      (motels) => emit(
        HomeLoaded(
          motels: motels,
          selectedFilters: const [],
          selectedIndex: 0,
          selectedCity: 'são paulo',
          selectedInitialDate: '10 fev',
          selectedFinalDate: '11 fev',
          favoriteTempList: const [],
        ),
      ),
    );
  }

  void toggleTempFavorite(String motelName) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      final updatedFavorites = List<String>.from(currentState.favoriteTempList);

      if (updatedFavorites.contains(motelName)) {
        updatedFavorites.remove(motelName);
      } else {
        updatedFavorites.add(motelName);
      }

      emit(currentState.copyWith(favoriteTempList: updatedFavorites));
    }
  }

  void setSelectedIndex(int index) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(currentState.copyWith(selectedIndex: index));
    }
  }

  void toggleFilter(String filter) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      final updatedFilters = List<String>.from(currentState.selectedFilters);

      if (updatedFilters.contains(filter)) {
        updatedFilters.remove(filter);
      } else {
        updatedFilters.add(filter);
      }

      emit(currentState.copyWith(selectedFilters: updatedFilters));
    }
  }

  void clearFilters() {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(currentState.copyWith(selectedFilters: const []));
    }
  }

  void setSelectedCity(String city) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(currentState.copyWith(selectedCity: city));
    }
  }

  void setSelectedInitialDate(String date) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(currentState.copyWith(selectedInitialDate: date));
    }
  }

  void setSelectedFinalDate(String date) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(currentState.copyWith(selectedFinalDate: date));
    }
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
