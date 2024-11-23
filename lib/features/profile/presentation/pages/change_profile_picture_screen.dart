import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/pick_image.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../manager/profile_bloc.dart';

class ChangeProfilePictureScreen extends StatelessWidget {
  const ChangeProfilePictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Expanded(
                        child: Center(
                          child: Hero(
                            tag: "profilePicture",
                            child: Container(
                              height: MediaQuery.of(context).size.width,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: PaletteColor().white,
                              ),
                            ),
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
                      editProfilePicture: () {
                        PickImage().pickImage(ImageSource.gallery);
                      },
                      deleteProfilePicture: () {},
                    ),
                    Center(
                      child: Hero(
                        tag: "profilePicture",
                        child: Container(
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: PaletteColor().white,
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
    );
  }
}
