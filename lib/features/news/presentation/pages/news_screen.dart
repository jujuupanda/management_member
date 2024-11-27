import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/container_body.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../manager/news_bloc.dart';
import '../widgets/widget_news_card_view.dart';
import '../widgets/widget_shimmer_news.dart';
import '../../domain/entities/news_entity.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key, this.toDeleted});

  final NewsEntity? toDeleted;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsEntity? toDeleted;

  @override
  void initState() {
    super.initState();
    BlocFunction().getNews(context);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.toDeleted != null) {
      toDeleted = widget.toDeleted;
      BlocFunction().deleteNews(context, toDeleted!);
      toDeleted = null;
    }
    return Scaffold(
      body: Stack(
        children: [
          const PageBackground(),
          Column(
            children: [
              const PageHeader(
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
                          final sortedLatestNews = SortingFilterObject()
                              .newsSortingFilter(news: news);
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
          return WidgetNewsCardView(
            news: news[index],
          );
        },
      ),
    );
  }
}
