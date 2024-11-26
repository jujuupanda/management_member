import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/container_body.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../../domain/entities/news_entity.dart';
import '../manager/news_bloc.dart';

class NewsFullContentScreen extends StatelessWidget {
  const NewsFullContentScreen({super.key, required this.news});

  final NewsEntity news;

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

  imageSlider(NewsEntity news) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: false,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          viewportFraction: 1,
        ),
        items: news.image
            .map((item) => GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: item,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const PageBackground(),
          Column(
            children: [
              const PageHeader(
                isDetail: true,
              ),
              Expanded(
                child: ContainerBody(
                  child: BlocBuilder<NewsBloc, NewsState>(
                    builder: (context, state) {
                      if (state is NewsLoaded) {
                        final newsIndexed = state.news!
                            .where((listNews) => listNews.id == news.id)
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
                              "${ParsingString().formatDateTimeIDFormatFull(newsIndexed.publishedAt)}, Oleh: ${newsIndexed.author}",
                              style: StyleText().openSansSmallBlack,
                            ),
                            Gap(20.h),
                            newsIndexed.image.isNotEmpty
                                ? imageSlider(newsIndexed)
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
