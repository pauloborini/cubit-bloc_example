import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:motels/core/helpers/extensions/responsive_extension.dart';
import 'package:motels/core/helpers/ui/modal_helper.dart';
import 'package:motels/core/ui/styles/colors_app.dart';
import 'package:motels/core/ui/styles/text_styles.dart';
import 'package:motels/features/home/cubit/home_cubit.dart';
import 'package:motels/features/home/cubit/home_state.dart';
import 'package:motels/features/home/view/modals/date_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DateDropdownButton extends StatelessWidget {
  const DateDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final selectedInitialDate = state is HomeLoaded ? state.selectedInitialDate : '10 fev';
        final selectedFinalDate = state is HomeLoaded ? state.selectedFinalDate : '11 fev';

        return GestureDetector(
          onTap: () => _showDateSelectionModal(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              IntrinsicWidth(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$selectedInitialDate - $selectedFinalDate',
                      style: context.textStyles.bodyTextMedium.copyWith(color: context.colors.neutralWhite),
                    ),
                    SizedBox(width: 6.width),
                    Icon(
                      PhosphorIconsBold.caretDown,
                      color: context.colors.neutralWhite,
                      size: 16.icon,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.height),
              Builder(
                builder: (context) {
                  final textWidth = _calculateTextWidth(context, selectedInitialDate) +
                      _calculateTextWidth(context, selectedFinalDate) +
                      _calculateTextWidth(context, ' - ');
                  final totalWidth = textWidth + 24.width;
                  return SizedBox(
                    width: totalWidth,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final dashCount = (constraints.maxWidth / 5).floor();
                        return Row(
                          children: List.generate(
                            dashCount,
                            (index) => Container(
                              width: 3.width,
                              height: 1.height,
                              color: context.colors.neutralWhite,
                              margin: EdgeInsets.symmetric(horizontal: 1.width),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  double _calculateTextWidth(BuildContext context, String text) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: context.textStyles.bodyTextMedium),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  void _showDateSelectionModal(BuildContext context) {
    ModalHelper.showCustomModal(
      context: context,
      child: BlocProvider.value(
        value: context.read<HomeCubit>(),
        child: const DateBottomSheet(),
      ),
    );
  }
}
