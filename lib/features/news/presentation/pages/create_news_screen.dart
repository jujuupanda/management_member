import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/container_body.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/widget_action_button.dart';

class CreateNewsScreen extends StatefulWidget {
  const CreateNewsScreen({super.key});

  @override
  State<CreateNewsScreen> createState() => _CreateNewsScreenState();
}

class _CreateNewsScreenState extends State<CreateNewsScreen> {
  late TextEditingController titleC;
  late TextEditingController contentC;
  late TextEditingController categoryC;
  final List<String> imageC = [];

  @override
  void initState() {
    super.initState();
    titleC = TextEditingController();
    contentC = TextEditingController();
    categoryC = TextEditingController();
  }

  createNews(BuildContext context) {
    return () {
      BlocFunction().createNews(
        context,
        titleC.text,
        contentC.text,
        imageC,
        categoryC.text,
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const PageBackground(),
          Column(
            children: [
              const PageHeader(
                isDetail: true,
              ),
              Gap(10.h),
              ContainerBody(
                height: MediaQuery.of(context).size.height - 110.h,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    vertical: 24.h,
                    horizontal: 12.w,
                  ),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Tambah Berita",
                            style: StyleText().openSansTitleBlack,
                          ),
                        ),
                        Gap(10.h),
                        Text(
                          "Judul",
                          style: StyleText().openSansNormalBlack,
                        ),
                        AddNewsTextFormField(
                          controller: titleC,
                          identifiedAs: "title",
                        ),
                        Gap(20.h),
                        Text(
                          "Isi",
                          style: StyleText().openSansNormalBlack,
                        ),
                        AddNewsTextFormField(
                          controller: contentC,
                          identifiedAs: "content",
                        ),
                        Gap(20.h),
                        Text(
                          "Gambar",
                          style: StyleText().openSansNormalBlack,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: PaletteColor().softDarkGrey,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "data ssssssssssssss sssssss ssssssss ssssd sddsd s",
                                          style:
                                              StyleText().openSansNormalBlack,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Material(
                                        color: PaletteColor().transparent,
                                        child: InkWell(
                                          onTap: () {},
                                          borderRadius:
                                              BorderRadius.circular(32.r),
                                          splashColor: PaletteColor().lightGray,
                                          child: const Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Icon(Icons.close),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Gap(36.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: WidgetActionButton(
                            name: "Buat",
                            onTap: createNews(context),
                          ),
                        ),
                        Gap(30.h),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AddNewsTextFormField extends StatelessWidget {
  const AddNewsTextFormField({
    super.key,
    required this.identifiedAs,
    required this.controller,
  });

  final String identifiedAs;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction(),
      keyboardType: keyboardType(),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText(),
        hintStyle: StyleText().openSansNormalBlack,
      ),
      minLines: 1,
      maxLines: maxLines(),
    );
  }

  hintText() {
    if (identifiedAs == "title") {
      return "Tulis judul di sini....";
    }
    if (identifiedAs == "content") {
      return "Tulis konten berita di sini....";
    }
  }

  textInputAction() {
    if (identifiedAs == "title") {
      return TextInputAction.next;
    }
    if (identifiedAs == "content") {
      return TextInputAction.none;
    }
  }

  keyboardType() {
    if (identifiedAs == "title") {
      return TextInputType.text;
    }
    if (identifiedAs == "content") {
      return TextInputType.multiline;
    }
  }

  maxLines() {
    if (identifiedAs == "title") {
      return 2;
    }
    if (identifiedAs == "content") {
      return 10;
    }
  }
}
