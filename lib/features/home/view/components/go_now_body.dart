import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motels/core/helpers/extensions/responsive_extension.dart';
import 'package:motels/core/ui/styles/colors_app.dart';
import 'package:motels/features/home/cubit/home_cubit.dart';
import 'package:motels/features/home/cubit/home_state.dart';
import 'package:motels/features/home/view/components/motel_carrousel_item/motel_carrousel_item.dart';

class GoNowBody extends StatelessWidget {
  const GoNowBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is HomeLoaded,
      builder: (context, state) {
        if (state is! HomeLoaded) {
          return const SizedBox.shrink();
        }

        return RefreshIndicator(
          onRefresh: () async {
            await context.read<HomeCubit>().setupConfigs();
          },
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: context.colors.neutralShade100,
            child: ListView.separated(
              padding: EdgeInsets.only(top: 16.height),
              shrinkWrap: true,
              itemCount: state.motels.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 32.height);
              },
              itemBuilder: (context, index) {
                final motel = state.motels[index];
                return MotelCarrouselItem(
                  motel: motel,
                  isFavorite: state.favoriteTempList.contains(motel.name),
                  onFavoritePressed: () {
                    context.read<HomeCubit>().toggleTempFavorite(motel.name);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
