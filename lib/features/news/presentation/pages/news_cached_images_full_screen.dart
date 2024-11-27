import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:widget_zoom/widget_zoom.dart';

import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';

class NewsCachedImagesFullScreen extends StatefulWidget {
  const NewsCachedImagesFullScreen({
    super.key,
    required this.cachedImages,
    required this.index,
  });

  final List<File> cachedImages;
  final int index;

  @override
  State<NewsCachedImagesFullScreen> createState() =>
      _NewsCachedImagesFullScreenState();
}

class _NewsCachedImagesFullScreenState extends State<NewsCachedImagesFullScreen>
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
                    itemCount: widget.cachedImages.length,
                    itemBuilder: (context, index, realIndex) {
                      return WidgetZoom(
                        heroAnimationTag: "cachedImageNews-$index",
                        zoomWidget: SizedBox(
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          child: Transform.scale(
                            scale: scale.clamp(0.7, 1.0),
                            child: Opacity(
                              opacity: opacity.clamp(0.0, 1.0),
                              child: Image.file(
                                widget.cachedImages[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
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
