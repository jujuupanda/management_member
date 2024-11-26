import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_zoom/widget_zoom.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../manager/attendance_bloc.dart';

class AttendanceImageFullScreen extends StatefulWidget {
  const AttendanceImageFullScreen({super.key, this.photo});

  final File? photo;

  @override
  State<AttendanceImageFullScreen> createState() =>
      _AttendanceImageFullScreenState();
}

class _AttendanceImageFullScreenState extends State<AttendanceImageFullScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationC;
  double verticalDragOffset = 0.0;
  bool isDragging = false;

  @override
  void initState() {
    super.initState();
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
            BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, state) {
                if (state is AttendancesLoaded) {
                  if (state.isLoading == true) {
                    final attendToday = state.attendToday!;
                    return Stack(
                      children: [
                        const PageHeader(
                          isDetail: true,
                        ),
                        Center(
                          child: WidgetZoom(
                            heroAnimationTag: "attendancePicture",
                            zoomWidget: Container(
                              height: MediaQuery.of(context).size.width,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: PaletteColor().white,
                              ),
                              child:
                                  ImageLoader().attendanceSquare(attendToday),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  if (state.attendToday != null) {
                    final attendToday = state.attendToday!;
                    return Stack(
                      children: [
                        const PageHeader(
                          isDetail: true,
                        ),
                        Center(
                          child: WidgetZoom(
                            heroAnimationTag: "attendancePicture",
                            zoomWidget: SizedBox(
                              height: MediaQuery.of(context).size.width,
                              width: MediaQuery.of(context).size.width,
                              child: Transform.scale(
                                scale: scale.clamp(0.7, 1.0),
                                child: Opacity(
                                  opacity: opacity.clamp(0.0, 1.0),
                                  child: ImageLoader()
                                      .attendanceSquare(attendToday),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Stack(
                    children: [
                      const PageHeader(
                        isDetail: true,
                      ),
                      Center(
                        child: WidgetZoom(
                          heroAnimationTag: "attendancePicture",
                          zoomWidget: SizedBox(
                            height: MediaQuery.of(context).size.width,
                            width: MediaQuery.of(context).size.width,
                            child: Transform.scale(
                              scale: scale.clamp(0.7, 1.0),
                              child: Opacity(
                                opacity: opacity.clamp(0.0, 1.0),
                                child: widget.photo != null
                                    ? Image.file(widget.photo!)
                                    : Image.asset(
                                        NamedString().noProfilePicture),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
