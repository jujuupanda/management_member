import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/utils.dart';
import '../routes/route_app.dart';
import '../services/token_service.dart';

class PageHeader extends StatefulWidget {
  const PageHeader({
    super.key,
    this.isDetail = false,
    this.isAdmin = false,
    this.changeProfilePicture = false,
    this.page,
    this.editProfilePicture,
    this.deleteProfilePicture,
  });

  final bool? isDetail;
  final bool? isAdmin;
  final bool? changeProfilePicture;
  final String? page;
  final VoidCallback? editProfilePicture;
  final VoidCallback? deleteProfilePicture;

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
          widget.isDetail == true
              ? IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: PaletteColor().white,
                  ),
                )
              : const SizedBox(),
          const Spacer(),
          isAdmin(),
          changeProfilePicture(),
          isDetail(),
        ],
      ),
    );
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
    if (widget.isAdmin == true) {
      if (widget.page == "profile") {
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
      if (widget.page == "news") {
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
                    context.pushNamed(RouteName().createNews);
                  },
                  icon: Icon(
                    Icons.newspaper_outlined,
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
    }
    if (widget.isAdmin == true && widget.isDetail == true) {
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
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert_rounded,
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
