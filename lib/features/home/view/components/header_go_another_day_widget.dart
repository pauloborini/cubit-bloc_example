import 'package:flutter/material.dart';
import 'package:motels/core/helpers/extensions/responsive_extension.dart';
import 'package:motels/features/home/view/components/city_dropdown_button.dart';
import 'package:motels/features/home/view/components/date_dropdown_button.dart';

class HeaderGoAnotherDayWidget extends StatelessWidget {
  const HeaderGoAnotherDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CityDropdownButton(),
          SizedBox(width: 32.width),
          const DateDropdownButton(),
        ],
      ),
    );
  }
}
