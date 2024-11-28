import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_app.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/container_body.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../../domain/entities/news_entity.dart';
import '../manager/news_bloc.dart';

class NewsFullContentScreen extends StatefulWidget {
  const NewsFullContentScreen({
    super.key,
    required this.news,
  });

  final NewsEntity news;

  @override
  State<NewsFullContentScreen> createState() => _NewsFullContentScreenState();
}

class _NewsFullContentScreenState extends State<NewsFullContentScreen> {
  int currentIndex = 0;

  checkCurrentIndexFromDetail() async {
    final result = await context.pushNamed<int>(
      RouteName().newsImagesFullScreen,
      extra: {
        "index": currentIndex,
      },
    );
    if (result != null) {
      setState(() {
        currentIndex = result;
      });
    } else {
      setState(() {
        currentIndex = 0;
      });
    }
  }

  indentationContent(String content) {
    List<String> paragraphs = content.split("\n");
    List<Widget> paragraphWidgets = paragraphs.map((paragraph) {
      return Text.rich(
        TextSpan(
          children: [
            TextSpan(text: "    ", style: StyleText().openSansNormalBlack),
            TextSpan(text: paragraph, style: StyleText().openSansNormalBlack),
          ],
        ),
      );
    }).toList();
    return paragraphWidgets;
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
          initialPage: currentIndex,
        ),
        itemCount: news.image.length,
        itemBuilder: (context, index, realIndex) {
          return GestureDetector(
            onTap: () {
              context.pushNamed<Map<String, dynamic>>(
                RouteName().newsImagesFullScreen,
                extra: {
                  "news": news,
                  "index": index,
                },
              );
            },
            child: Hero(
              tag: widget.news.image[index],
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

  editNews(BuildContext context) {
    return () {
      context.pushNamed(
        RouteName().editNews,
        extra: widget.news,
      );
    };
  }

  deleteNews(BuildContext context) {
    return () {
      PopUpDialog().caution(
        context: context,
        iconData: Icons.delete_forever_rounded,
        message: "Ingin menghapus berita?",
        confirmOnTap: () {
          Future.delayed(const Duration(milliseconds: 500), () {
            PopUpDialog().successDoSomething(
              context,
              "Berhasil menghapus berita",
              () {
                context.pop();
                GoRouter.of(context).pop(widget.news);
              },
            );
          });
        },
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const PageBackground(),
          Column(
            children: [
              PageHeader(
                isDetail: true,
                page: "news",
                editNews: editNews(context),
                deleteNews: deleteNews(context),
              ),
              Expanded(
                child: ContainerBody(
                  child: BlocBuilder<NewsBloc, NewsState>(
                    builder: (context, state) {
                      if (state is NewsLoaded) {
                        final newsIndexed = state.news!
                            .where((listNews) => listNews.id == widget.news.id)
                            .first;
                        return ListView(
                          padding: EdgeInsets.symmetric(
                            vertical: 32.h,
                            horizontal: 12.w,
                          ),
                          children: [
                            Text(
                              newsIndexed.title,
                              style: StyleText().openSansTitleBlack,
                            ),
                            Text(
                              ParsingString().formatDateTimeIDFormatFull(newsIndexed.publishedAt),
                              style: StyleText().openSansSmallBlack,
                              maxLines: 1,
                            ),
                            Text(
                              "Penulis: ${newsIndexed.author}",
                              style: StyleText().openSansSmallBlack,
                              maxLines: 1,
                            ),
                            Gap(20.h),
                            newsIndexed.image.isNotEmpty
                                ? imageSlider(context, newsIndexed)
                                : const SizedBox(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: indentationContent(newsIndexed.content),
                            ),
                          ],
                        );
                      }
                      return Text(
                        "Berita tidak ditemukan",
                        style: StyleText().openSansTitleBlack,
                      );
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
