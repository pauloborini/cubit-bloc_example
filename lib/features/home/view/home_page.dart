import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motels/core/helpers/extensions/responsive_extension.dart';
import 'package:motels/core/helpers/feedback/feedback_handler.dart';
import 'package:motels/core/ui/styles/colors_app.dart';
import 'package:motels/core/ui/styles/text_styles.dart';
import 'package:motels/core/widgets/custom_button.dart';
import 'package:motels/core/widgets/line_divider_widget.dart';
import 'package:motels/features/home/cubit/home_cubit.dart';
import 'package:motels/features/home/cubit/home_state.dart';
import 'package:motels/features/home/view/components/filter_widget.dart';
import 'package:motels/features/home/view/components/go_now_body.dart';
import 'package:motels/features/home/view/components/header_go_another_day_widget.dart';
import 'package:motels/features/home/view/components/header_go_now_widget.dart';
import 'package:motels/features/home/view/components/home_appbar.dart';
import 'package:motels/features/home/view/components/skeleton_go_now_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().setupConfigs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          FeedbackHandler.showSnackBar(
            context: context,
            isSuccess: false,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.colors.primary,
          appBar: const HomeAppBar(),
          body: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 60.height, minHeight: 60.height),
                child: PageView(
                  controller: context.read<HomeCubit>().pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  children: const [
                    HeaderGoNowWidget(),
                    HeaderGoAnotherDayWidget(),
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: context.colors.neutralShade100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.adaptive),
                    topRight: Radius.circular(16.adaptive),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 12.height),
                    const FilterWidget(),
                    LineDividerWidget(
                      firstPadding: 12.height,
                      secondPadding: 0,
                    ),
                  ],
                ),
              ),
              if (state is HomeLoading)
                const Expanded(child: SkeletonGoNowWidget())
              else if (state is HomeLoaded)
                const Expanded(
                  child: GoNowBody(),
                )
              else if (state is HomeError)
                Expanded(
                  child: Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    color: context.colors.neutralShade100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Erro ao carregar dados',
                            style: context.textStyles.titleMedium,
                          ),
                          SizedBox(height: 16.height),
                          CustomButton(
                            onPressed: () => context.read<HomeCubit>().loadMotels(),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                const Expanded(child: SkeletonGoNowWidget()),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 16.height),
            child: FloatingActionButton.extended(
              elevation: 2,
              backgroundColor: context.colors.neutralWhite,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.adaptive)),
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    PhosphorIconsRegular.mapTrifold,
                    color: context.colors.primary,
                    size: 24.icon,
                  ),
                  SizedBox(width: 8.width),
                  Text(
                    'mapa',
                    style: context.textStyles.bodyTextMedium,
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }
}
