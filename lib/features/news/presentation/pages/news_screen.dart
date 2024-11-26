import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/container_body.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../manager/news_bloc.dart';
import '../widgets/widget_shimmer_news.dart';
import '../../domain/entities/news_entity.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    BlocFunction().getNews(context);
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
                isAdmin: true,
                page: "news",
              ),
              Gap(10.h),
              Expanded(
                child: ContainerBody(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      BlocFunction().getNews(context);
                    },
                    child: BlocBuilder<NewsBloc, NewsState>(
                      builder: (context, state) {
                        if (state is NewsLoaded) {
                          if (state.isLoading == true) {
                            return WidgetShimmerNews().listNewsShimmer();
                          }
                          final news = state.news!;
                          return listNews(news);
                        }
                        return WidgetShimmerNews().listNewsShimmer();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ListView listNews(List<NewsEntity> news) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: news.length,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 30.h,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Container(
            height: 200.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: PaletteColor().lightGray,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 8.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ParsingString()
                          .formatDateTimeIDFormat(news[index].publishedAt),
                      style: StyleText().openSansSmallBlack,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    news[index].title,
                    style: StyleText().openSansTitleBlack,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Expanded(
                    child: Text(
                      news[index].content,
                      style: StyleText().openSansNormalBlack,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            "Penulis: ${news[index].author}",
                            style: StyleText().openSansSmallBlack,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            color: PaletteColor().transparent,
                            height: 30.h,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Selengkapnya...",
                                style: StyleText().openSansNormalBlack,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
