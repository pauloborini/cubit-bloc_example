import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motels/core/helpers/extensions/responsive_extension.dart';
import 'package:motels/core/ui/styles/colors_app.dart';
import 'package:motels/core/ui/styles/text_styles.dart';
import 'package:motels/core/widgets/custom_icon_button.dart';
import 'package:motels/core/widgets/custom_text_button.dart';
import 'package:motels/features/home/cubit/home_cubit.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(
          icon: PhosphorIconsBold.caretDown,
          iconColor: context.colors.textColorLight,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'filtros',
          style: context.textStyles.titleMedium.copyWith(
            color: context.colors.textColorLight,
          ),
        ),
        centerTitle: true,
        actions: [
          CustomTextButton(
            label: 'limpar',
            labelSize: 16.font,
            onPressed: () => context.read<HomeCubit>().clearFilters(),
          ),
          SizedBox(width: 12.width),
        ],
      ),
      body: const Column(),
    );
  }
}
