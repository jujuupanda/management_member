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
  });

  final bool? isDetail;
  final bool? isAdmin;

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
      height: 70.h,
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
          widget.isAdmin == true
              ? FutureBuilder(
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
                )
              : const SizedBox(),
          widget.isDetail == true
              ? const SizedBox()
              : IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: PaletteColor().white,
                  ),
                ),
        ],
      ),
    );
  }
}
