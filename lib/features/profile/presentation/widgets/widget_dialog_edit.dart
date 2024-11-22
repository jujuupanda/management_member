import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/utils.dart';
import 'widget_text_form_field_edit_user.dart';

class WidgetDialogEdit {
  void showFormDialog(
    BuildContext context,
    String label,
    String value,
    String hint,
    String identifiedAs,
    IconData iconData,
    ValueChanged<String> onTap,
  ) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController controller = TextEditingController(text: value);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          insetPadding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 20.w,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 16.w,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      "Ubah data",
                      style: StyleText().openSansTitleBlack,
                    ),
                    Gap(20.h),

                    WidgetTextFormFieldEditUser(
                      controller: controller,
                      labelText: label,
                      hintText: hint,
                      identifiedAs: identifiedAs,
                      iconData: iconData,
                    ),
                    Gap(20.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 40.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              width: 1.w,
                              color: PaletteColor().softBlack,
                            ),
                          ),
                          child: Material(
                            color: PaletteColor().transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12.r),
                              onTap: () {
                                context.pop();
                              },
                              splashColor: PaletteColor().softBlue1,
                              child: Center(
                                child: Text(
                                  "Batal",
                                  style: StyleText().openSansNormalBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Gap(15.w),
                        Container(
                          height: 40.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              width: 1.w,
                              color: PaletteColor().softBlack,
                            ),
                            color: PaletteColor().softBlack,
                          ),
                          child: Material(
                            color: PaletteColor().transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12.r),
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  onTap(controller.text);
                                  context.pop();
                                }
                              },
                              splashColor: PaletteColor().softBlue1,
                              child: Center(
                                child: Text(
                                  "Simpan",
                                  style: StyleText().openSansNormalWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
