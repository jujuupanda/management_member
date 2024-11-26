import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/container_body.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../../domain/entities/news_entity.dart';

class NewsContentScreen extends StatelessWidget {
  const NewsContentScreen({super.key, required this.news});

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
              ContainerBody(
                child: Column(
                  children: [
                    Text(
                      news.title,
                      style: StyleText().openSansTitleBlack,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: indentationContent(news.content),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
