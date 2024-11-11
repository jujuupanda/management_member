import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';

class ProfileBackground extends StatelessWidget {
  const ProfileBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: ColorPalette().blue1,
      ),
    );
  }
}
