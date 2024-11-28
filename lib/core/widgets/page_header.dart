import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/utils.dart';
import '../routes/route_app.dart';
import '../services/token_service.dart';

class PageHeader extends StatefulWidget {
  const PageHeader({
    super.key,
    this.isDetail = false,
    this.changeProfilePicture = false,
    this.page,
    this.editProfilePicture,
    this.deleteProfilePicture,
    this.editNews,
    this.deleteNews,
    this.popContextChanged,
  });

  final bool? isDetail;
  final bool? changeProfilePicture;
  final String? page;
  final VoidCallback? editProfilePicture;
  final VoidCallback? deleteProfilePicture;
  final VoidCallback? editNews;
  final VoidCallback? deleteNews;
  final VoidCallback? popContextChanged;

  @override
  State<PageHeader> createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader> {
  late String role;

  getRole() async {
    return role = await TokenService().jwtPayloadRole();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          widgetPopContext(),
          const Spacer(),
          isAdmin(),
          changeProfilePicture(),
          isDetail(),
        ],
      ),
    );
  }

  widgetPopContext() {
    if (widget.isDetail == true) {
      return IconButton(
        onPressed: widget.popContextChanged ??
            () {
              context.pop();
            },
        icon: Icon(
          Icons.arrow_back_rounded,
          color: PaletteColor().white,
        ),
      );
    }
    return const SizedBox();
  }

  isDetail() {
    if (widget.isDetail == true) {
      return const SizedBox();
    }

    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.notifications,
        color: PaletteColor().white,
      ),
    );
  }

  isAdmin() {
    if (widget.isDetail == false && widget.page == "profile") {
      return FutureBuilder(
        future: getRole(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          } else if (snapshot.hasError) {
            return const SizedBox();
          } else if (snapshot.hasData) {
            final role = snapshot.data!;
            if (role == "admin") {
              return IconButton(
                onPressed: () {
                  context.pushNamed(RouteName().addUser);
                },
                icon: Icon(
                  Icons.person_add,
                  color: PaletteColor().white,
                ),
              );
            }
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        },
      );
    }
    if (widget.isDetail == false && widget.page == "news") {
      return FutureBuilder(
        future: getRole(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          } else if (snapshot.hasError) {
            return const SizedBox();
          } else if (snapshot.hasData) {
            final role = snapshot.data!;
            if (role == "admin") {
              return Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.pushNamed(RouteName().archivedNews);
                    },
                    icon: Icon(
                      Icons.archive_rounded,
                      color: PaletteColor().white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.pushNamed(RouteName().createNews);
                    },
                    icon: Icon(
                      Icons.newspaper_outlined,
                      color: PaletteColor().white,
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        },
      );
    }
    if (widget.isDetail == true && widget.page == "news") {
      return FutureBuilder(
        future: getRole(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          } else if (snapshot.hasError) {
            return const SizedBox();
          } else if (snapshot.hasData) {
            final role = snapshot.data!;
            if (role == "admin") {
              return PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    widget.editNews!();
                  }
                  if (value == 'delete') {
                    widget.deleteNews!();
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: "edit",
                      child: Row(
                        children: [
                          const Icon(Icons.edit),
                          Gap(4.w),
                          Text(
                            "Edit Postingan",
                            style: StyleText().openSansNormalBlack,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: "delete",
                      child: Row(
                        children: [
                          const Icon(
                            Icons.delete_forever_rounded,
                          ),
                          Gap(4.w),
                          Text(
                            "Hapus Postingan",
                            style: StyleText().openSansNormalBlack,
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: PaletteColor().white,
                ),
                offset: Offset(0, 50.h),
                color: PaletteColor().lightGray,
              );
            }
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        },
      );
    }

    return const SizedBox();
  }

  changeProfilePicture() {
    if (widget.changeProfilePicture == true) {
      return Row(
        children: [
          IconButton(
            onPressed: widget.editProfilePicture,
            icon: Icon(
              Icons.edit,
              color: PaletteColor().white,
            ),
          ),
          IconButton(
            onPressed: widget.deleteProfilePicture,
            icon: Icon(
              Icons.delete,
              color: PaletteColor().white,
            ),
          ),
        ],
      );
    }
    return const SizedBox();
  }
}
