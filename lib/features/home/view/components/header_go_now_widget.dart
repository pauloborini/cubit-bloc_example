import 'package:flutter/material.dart';
import 'package:motels/core/helpers/extensions/responsive_extension.dart';
import 'package:motels/features/home/view/components/city_dropdown_button.dart';

class HeaderGoNowWidget extends StatelessWidget {
  const HeaderGoNowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.height,
      child: const Center(
        child: CityDropdownButton(),
      ),
    );
  }
}
