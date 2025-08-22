import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motels/core/helpers/extensions/responsive_extension.dart';
import 'package:motels/core/helpers/ui/modal_helper.dart';
import 'package:motels/core/ui/styles/colors_app.dart';
import 'package:motels/core/ui/styles/text_styles.dart';
import 'package:motels/features/home/cubit/home_cubit.dart';
import 'package:motels/features/home/cubit/home_state.dart';
import 'package:motels/features/home/view/components/filter_item.dart';
import 'package:motels/features/home/view/modals/filter_bottom_sheet.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final selectedFilters = state is HomeLoaded ? state.selectedFilters : <String>[];
        final isLoaded = state is HomeLoaded;
        final cubit = context.read<HomeCubit>();
        
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: 48.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(width: 16.width),
                    Stack(
                      children: [
                        Badge(
                          alignment: Alignment.topLeft,
                          offset: const Offset(2, -3),
                          isLabelVisible: selectedFilters.isNotEmpty,
                          label: Text(
                            selectedFilters.length.toString(),
                            style: context.textStyles.caption.copyWith(color: context.colors.neutralWhite),
                          ),
                          child: FilterItem(
                            label: 'filtros',
                            showIcon: true,
                            isSelected: false,
                            onPressed: () => _showFilterSelectionModal(context),
                            isDisabled: !isLoaded,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 8.width),
                    SizedBox(
                      height: 40.height,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cubit.itemsFilter.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 8.width);
                        },
                        itemBuilder: (context, index) {
                          final filter = cubit.itemsFilter[index];
                          return FilterItem(
                            label: filter,
                            isSelected: selectedFilters.contains(filter),
                            isDisabled: !isLoaded,
                            onPressed: () => _setSelectedFilter(context, filter),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 16.width),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _setSelectedFilter(BuildContext context, String filter) {
    context.read<HomeCubit>().toggleFilter(filter);
  }

  void _showFilterSelectionModal(BuildContext context) {
    ModalHelper.showCustomModal(
      context: context,
      child: BlocProvider.value(
        value: context.read<HomeCubit>(),
        child: const FilterBottomSheet(),
      ),
    );
  }
}
