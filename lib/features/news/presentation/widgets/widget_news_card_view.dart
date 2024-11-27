import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_app.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/entities/news_entity.dart';

class WidgetNewsCardView extends StatelessWidget {
  const WidgetNewsCardView({
    super.key,
    required this.news,
  });

  final NewsEntity news;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        height: 200.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: PaletteColor().white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            width: 1,
            color: PaletteColor().softGray,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 2,
              offset: const Offset(2, 0), // changes position of shadow
            ),
          ],
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
                      .formatDateTimeIDFormat(news.publishedAt),
                  style: StyleText().openSansSmallBlack,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                news.title,
                style: StyleText().openSansTitleBlack,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Expanded(
                child: Text(
                  news.content,
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
                        "Penulis: ${news.author}",
                        style: StyleText().openSansSmallBlack,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          RouteName().newsFullContent,
                          extra: news,
                        );
                      },
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
  }
}
