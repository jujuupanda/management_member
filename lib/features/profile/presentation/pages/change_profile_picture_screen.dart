import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class _ChangeProfilePictureScreenState
    extends State<ChangeProfilePictureScreen> {
  changeImage(UserEntity user) {
    return () async {
      final stringUrl = await PickImage().pickImageAndUpload("profile_picture");
      if (mounted) {
        context.read<ProfileBloc>().add(
              EditProfile(user, {
                "image": stringUrl,
              }),
            );
      }
    };
  }

  removeImage(UserEntity user) {
    return () async {
      context.read<ProfileBloc>().add(
            EditProfile(user, const {
              "image": "",
            }),
          );
    };
  }

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
                      Center(
                        child: Hero(
                          tag: "profilePicture",
                          child: Container(
                            height: MediaQuery.of(context).size.width,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: PaletteColor().white,
                            ),
                            child: ImageLoader().imageLoaderSquare(dataUser),
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
                      child: Hero(
                        tag: "profilePicture",
                        child: Container(
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: PaletteColor().white,
                          ),
                          child: ImageLoader().imageLoaderSquare(dataUser),
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
