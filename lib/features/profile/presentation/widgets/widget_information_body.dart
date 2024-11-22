import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/utils.dart';

class WidgetInformationBody extends StatelessWidget {
  const WidgetInformationBody({
    super.key,
    required this.iconData,
    required this.name,
    required this.value,
    required this.onTap,
    this.isEdit = true,
    this.goDetail = false,
  });

  final IconData iconData;
  final String name;
  final String value;
  final VoidCallback onTap;
  final bool? isEdit;
  final bool? goDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 350.w,
      decoration: BoxDecoration(
        color: PaletteColor().grayToWhite,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Icon(iconData),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: StyleText().openSansSmallBlack,
                ),
                Text(
                  value,
                  style: StyleText().openSansNormalBlack,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          suffixIcon(),
        ],
      ),
    );
  }
  suffixIcon(){
    if(isEdit == false){
      return const SizedBox();
    }
    if(goDetail == true){
      return IconButton(
        onPressed: onTap,
        icon: const Icon(
          Icons.arrow_forward_ios_rounded,
        ),
      );
    }
    return IconButton(
      onPressed: onTap,
      icon: const Icon(
        Icons.edit,
      ),
    );
  }
}
