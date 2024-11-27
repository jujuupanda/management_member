import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:widget_zoom/widget_zoom.dart';

import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../../domain/entities/news_entity.dart';

class NewsImagesFullScreen extends StatefulWidget {
  const NewsImagesFullScreen({
    super.key,
    required this.news,
    required this.index,
  });

  final NewsEntity news;
  final int index;

  @override
  State<NewsImagesFullScreen> createState() => _NewsImagesFullScreenState();
}

class _NewsImagesFullScreenState extends State<NewsImagesFullScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationC;
  double verticalDragOffset = 0.0;
  bool isDragging = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;

    animationC = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    animationC.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      verticalDragOffset += details.delta.dy;
      isDragging = true;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (verticalDragOffset.abs() > 150) {
      Navigator.pop(context);
    } else {
      setState(() {
        isDragging = false;
        verticalDragOffset = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double dragPercentage =
        (verticalDragOffset / MediaQuery.of(context).size.height)
            .clamp(-1.0, 1.0);
    final double scale = 1 - dragPercentage.abs() * 0.3;
    final double opacity = 1 - dragPercentage.abs();
    return GestureDetector(
      onVerticalDragUpdate: _handleDragUpdate,
      onVerticalDragEnd: _handleDragEnd,
      child: Scaffold(
        body: Stack(
          children: [
            const PageBackground(),
            Stack(
              children: [
                const PageHeader(
                  isDetail: true,
                ),
                Center(
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      aspectRatio: 4 / 3,
                      viewportFraction: 1,
                      initialPage: currentIndex,
                    ),
                    itemCount: widget.news.image.length,
                    itemBuilder: (context, index, realIndex) {
                      return WidgetZoom(
                        heroAnimationTag: "newsImages-$index",
                        zoomWidget: SizedBox(
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          child: Transform.scale(
                            scale: scale.clamp(0.7, 1.0),
                            child: Opacity(
                              opacity: opacity.clamp(0.0, 1.0),
                              child: CachedNetworkImage(
                                imageUrl: widget.news.image[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
