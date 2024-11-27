import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/container_body.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/widget_action_button.dart';
import '../../domain/entities/news_entity.dart';

class EditNewsScreen extends StatefulWidget {
  const EditNewsScreen({super.key, required this.news});

  final NewsEntity news;

  @override
  State<EditNewsScreen> createState() => _EditNewsScreenState();
}

class _EditNewsScreenState extends State<EditNewsScreen> {
  late TextEditingController titleC;
  late TextEditingController contentC;
  late TextEditingController categoryC;
  late bool archiveC;
  final List<String> imageC = [];

  @override
  void initState() {
    super.initState();
    titleC = TextEditingController(text: widget.news.title);
    contentC = TextEditingController(text: widget.news.content);
    categoryC = TextEditingController(text: widget.news.category);
    archiveC = widget.news.archived;
  }

  editNews(BuildContext context) {
    return () {
      BlocFunction().editNews(
        context,
        widget.news,
        {
          "title": titleC.text,
          "content": contentC.text,
          "image": imageC,
          "category": categoryC.text,
        },
      );
    };
  }

  archiveNews(BuildContext context) {
    BlocFunction().editNews(
      context,
      widget.news,
      {
        "archived": archiveC,
      },
    );
  }

  imageSlider(
    BuildContext context,
    NewsEntity news,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          autoPlay: false,
          enlargeCenterPage: true,
          aspectRatio: 4 / 3,
          viewportFraction: 1,
          initialPage: 0,
        ),
        itemCount: news.image.length,
        itemBuilder: (context, index, realIndex) {
          return GestureDetector(
            onLongPress: () {
              PopUpDialog().caution(
                context,
                Icons.delete_forever_rounded,
                "Hapus foto?",
                () {
                  setState(() {
                    // cachedImage.removeAt(index);
                  });
                },
              );
            },
            child: Hero(
              tag: "newsImages-$index",
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: news.image[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
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
                            "Edit Berita",
                            style: StyleText().openSansTitleBlack,
                          ),
                        ),
                        Gap(10.h),
                        archiveWidget(),
                        Gap(10.h),
                        Text(
                          "Judul",
                          style: StyleText().openSansNormalBlack,
                        ),
                        EditNewsTextFormField(
                          controller: titleC,
                          identifiedAs: "title",
                        ),
                        Gap(20.h),
                        Text(
                          "Isi",
                          style: StyleText().openSansNormalBlack,
                        ),
                        EditNewsTextFormField(
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
                              onPressed: () {},
                              icon:
                                  const Icon(Icons.add_photo_alternate_rounded),
                            )
                          ],
                        ),
                        widget.news.image.isNotEmpty
                            ? imageSlider(context, widget.news)
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
                            name: "Simpan",
                            onTap: editNews(context),
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

  Material archiveWidget() {
    return Material(
      color: PaletteColor().transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            archiveC = !archiveC;
          });
          archiveNews(context);
        },
        splashColor: PaletteColor().lightGray,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                archiveC == false
                    ? Icons.archive_rounded
                    : Icons.unarchive_rounded,
              ),
              Gap(5.w),
              Text(
                archiveC == false ? "Arsipkan" : "Batal Arsip",
                style: StyleText().openSansNormalBlack,
              ),
            ],
          ),
        ),
      ),
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

class EditNewsTextFormField extends StatelessWidget {
  const EditNewsTextFormField({
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
