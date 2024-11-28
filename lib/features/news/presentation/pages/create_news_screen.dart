import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_app.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/container_body.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/widget_action_button.dart';
import '../manager/news_bloc.dart';
import '../widgets/add_news_text_form_field.dart';

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
  final List<File> cachedImageC = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleC = TextEditingController();
    contentC = TextEditingController();
    categoryC = TextEditingController();
  }

  uploadImage() async {
    for (var file in cachedImageC) {
      final imageUrl = await PickImage().uploadImage(file, "news");
      setState(() {
        imageC.add(imageUrl);
      });
    }
  }

  createNews(BuildContext context) {
    return () async {
      if (formKey.currentState!.validate()) {
        await uploadImage();
        if (context.mounted) {
          BlocFunction().createNews(
            context,
            titleC.text,
            contentC.text,
            imageC,
            categoryC.text,
          );
        }
      }
    };
  }

  pickMultiImage() {
    return () async {
      final pickedFiles = await PickImage().pickMultiImageFourThree();
      setState(() {
        cachedImageC.addAll(pickedFiles);
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewsBloc, NewsState>(
      listener: (context, state) {
        if (state is NewsLoaded) {
          if (state.isLoading == false && state.isCreated == true) {
            PopUpDialog().successDoSomething(
              context,
              "Berhasil menambahkan berita",
              () {
                context.goNamed(RouteName().news);
              },
            );
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const PageBackground(),
            Column(
              children: [
                const PageHeader(isDetail: true),
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
                      key: formKey,
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
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Gambar",
                                  style: StyleText().openSansNormalBlack,
                                ),
                              ),
                              IconButton(
                                onPressed: pickMultiImage(),
                                icon: const Icon(
                                    Icons.add_photo_alternate_rounded),
                              )
                            ],
                          ),
                          cachedImageC.isNotEmpty
                              ? cachedImageCardView(cachedImageC)
                              : Center(
                                  child: Text(
                                    "Tidak ada gambar",
                                    style: StyleText().openSansNormalBlack,
                                  ),
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
      ),
    );
  }

  cachedImageCardView(List<File> cachedImage) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        aspectRatio: 4 / 3,
        viewportFraction: 1,
        initialPage: 0,
      ),
      itemCount: cachedImage.length,
      itemBuilder: (context, index, realIndex) {
        return GestureDetector(
          onTap: () {
            context.pushNamed<Map<String, dynamic>>(
              RouteName().newsCachedImagesFullScreen,
              extra: {
                "cachedImages": cachedImage,
                "index": index,
              },
            );
          },
          onLongPress: () {
            PopUpDialog().caution(
              context,
              Icons.delete_forever_rounded,
              "Hapus foto?",
              () {
                setState(() {
                  cachedImage.removeAt(index);
                });
              },
            );
          },
          child: Hero(
            tag: cachedImage[index].path,
            child: Image.file(
              cachedImage[index],
              fit: BoxFit.cover,
              scale: 1,
            ),
          ),
        );
      },
    );
  }

  Padding imageCardView(String imageUrl) {
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
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  imageUrl,
                  style: StyleText().openSansNormalBlack,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Material(
                color: PaletteColor().transparent,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(32.r),
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
  }
}
