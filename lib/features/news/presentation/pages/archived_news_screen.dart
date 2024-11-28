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
import '../manager/news_bloc.dart';
import '../widgets/widget_news_card_view.dart';
import '../widgets/widget_shimmer_news.dart';
import '../../domain/entities/news_entity.dart';

class ArchivedNewsScreen extends StatefulWidget {
  const ArchivedNewsScreen({
    super.key,
  });

  @override
  State<ArchivedNewsScreen> createState() => _ArchivedNewsScreenState();
}

class _ArchivedNewsScreenState extends State<ArchivedNewsScreen> {
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
                isDetail: true,
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
                            // return WidgetShimmerNews().listNewsShimmer();
                            final news = state.news!;
                            final sortedLatestNews = SortingFilterObject()
                                .newsSortingFilter(news: news, isArchive: true);
                            if (sortedLatestNews.isEmpty) {
                              return Center(
                                child: Text(
                                  "Arsip kosong",
                                  style: StyleText().openSansTitleBlack,
                                ),
                              );
                            }
                            return listNews(sortedLatestNews);
                          }
                          final news = state.news!;
                          final sortedLatestNews = SortingFilterObject()
                              .newsSortingFilter(news: news, isArchive: true);
                          if (sortedLatestNews.isEmpty) {
                            return Center(
                              child: Text(
                                "Arsip kosong",
                                style: StyleText().openSansTitleBlack,
                              ),
                            );
                          }
                          return listNews(sortedLatestNews);
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

  Padding listNews(List<NewsEntity> news) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: news.length,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              NewsEntity? returnedData = await context.pushNamed(
                RouteName().newsFullContent,
                extra: {
                  "news": news[index],
                  "fromArchive": true,
                },
              );
              if (returnedData != null) {
                if (context.mounted) {
                  Future.delayed(
                    const Duration(seconds: 1),
                    () {
                      BlocFunction().deleteNews(context, returnedData);
                    },
                  );
                }
              }
            },
            child: WidgetNewsCardView(
              news: news[index],
            ),
          );
        },
      ),
    );
  }
}
