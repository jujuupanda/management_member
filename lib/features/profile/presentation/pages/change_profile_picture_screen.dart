import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_zoom/widget_zoom.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../../domain/entities/user_entity.dart';
import '../manager/profile_bloc.dart';

class ChangeProfilePictureScreen extends StatefulWidget {
  const ChangeProfilePictureScreen({super.key});

  @override
  State<ChangeProfilePictureScreen> createState() =>
      _ChangeProfilePictureScreenState();
}

class _ChangeProfilePictureScreenState extends State<ChangeProfilePictureScreen>
    with SingleTickerProviderStateMixin {
  changeImage(UserEntity user) {
    return () async {
      final stringUrl = await PickImage().pickImageAndUpload("profile_picture");
      if (mounted) {
        BlocFunction().editProfile(
          context,
          user,
          {"image": stringUrl},
        );
      }
    };
  }

  removeImage(UserEntity user) {
    return () {
      PopUpDialog().caution(
       context:  context,
       iconData:  Icons.delete_forever_rounded,
       message:  "Ingin menghapus foto profile?",
        confirmOnTap: () {
          BlocFunction().editProfile(
            context,
            user,
            {"image": ""},
          );
        },
      );
    };
  }

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
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileSuccessState) {
                  if (state.isLoading == true) {
                    final dataUser = state.dataUser!;
                    return Stack(
                      children: [
                        const PageHeader(
                          isDetail: true,
                          changeProfilePicture: true,
                        ),
                        Center(
                          child: WidgetZoom(
                            heroAnimationTag: "profilePicture",
                            zoomWidget: Container(
                              height: MediaQuery.of(context).size.width,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: PaletteColor().white,
                              ),
                              child: ImageLoader().profileSquare(dataUser),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  final dataUser = state.dataUser!;
                  return Stack(
                    children: [
                      PageHeader(
                        isDetail: true,
                        changeProfilePicture: true,
                        editProfilePicture: changeImage(dataUser),
                        deleteProfilePicture: removeImage(dataUser),
                      ),
                      Center(
                        child: WidgetZoom(
                          heroAnimationTag: "profilePicture",
                          zoomWidget: SizedBox(
                            height: MediaQuery.of(context).size.width,
                            width: MediaQuery.of(context).size.width,
                            child: Transform.scale(
                              scale: scale.clamp(0.7, 1.0),
                              child: Opacity(
                                opacity: opacity.clamp(0.0, 1.0),
                                child:
                                    ImageLoader().profileSquare(dataUser),
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
