import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/utils.dart';

class ContainerBody extends StatelessWidget {
  const ContainerBody({
    super.key,
    required this.child,
    this.height,
    this.roundedAll = false,
  });

  final Widget child;
  final double? height;
  final bool? roundedAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: BoxDecoration(
        color: PaletteColor().white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32.r),
          bottom: roundedAll == true ? Radius.circular(32.r) : Radius.zero,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 3,
            blurRadius: 2,
            offset: const Offset(2, 0), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
