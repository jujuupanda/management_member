import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 56.h),
        child: AppBar(
          title: const Text("Aplikasi Kehadiran"),
          titleTextStyle: StyleText().openSansHeader,
          backgroundColor: ColorPalette().softBlue1,
          actions: [
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 1),
                    content: Text("Notifikasi"),
                  ),
                );
              },
              splashColor: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(50),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 12.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Laporan Kehadiran",
                    style: StyleText().openSansTitle,
                  ),
                ),
                Gap(10.h),
                Center(
                  child: Container(
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(
                      color: ColorPalette().white,
                      border: Border.all(color: ColorPalette().softBlue1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Kehadiranmu",
                      style: StyleText().openSansTitle,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_alt),
                    )
                  ],
                ),
                Gap(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 140.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: ColorPalette().white,
                        border: Border.all(color: ColorPalette().softBlue1),
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 70.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorPalette().greenPresence,
                            ),
                            child: Center(
                              child: Text(
                                "10",
                                style: StyleText().openSansBigValueWhite,
                              ),
                            ),
                          ),
                          Gap(10.h),
                          Text(
                            "Hadir",
                            style: StyleText().openSansTitle,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 140.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: ColorPalette().white,
                        border: Border.all(color: ColorPalette().softBlue1),
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 70.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorPalette().yellowPresence,
                            ),
                            child: Center(
                              child: Text(
                                "10",
                                style: StyleText().openSansBigValueWhite,
                              ),
                            ),
                          ),
                          Gap(10.h),
                          Text(
                            "Terlambat",
                            style: StyleText().openSansTitle,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 140.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: ColorPalette().white,
                        border: Border.all(color: ColorPalette().softBlue1),
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 70.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorPalette().redPresence,
                            ),
                            child: Center(
                              child: Text(
                                "10",
                                style: StyleText().openSansBigValueWhite,
                              ),
                            ),
                          ),
                          Gap(10.h),
                          Text(
                            "Tidak Hadir",
                            style: StyleText().openSansTitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(20.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Pengajuan Izin",
                      style: StyleText().openSansTitle,
                    ),
                    const Spacer(),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.help))
                  ],
                ),
                Gap(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 140.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                          color: ColorPalette().white,
                          border: Border.all(color: ColorPalette().softBlue1),
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    Container(
                      height: 140.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                          color: ColorPalette().white,
                          border: Border.all(color: ColorPalette().softBlue1),
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    Container(
                      height: 140.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                          color: ColorPalette().white,
                          border: Border.all(color: ColorPalette().softBlue1),
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                  ],
                ),
                Gap(20.h),
                Text(
                  "Pengajuan Izin Terbaru",
                  style: StyleText().openSansTitle,
                ),
                ListView.builder(
                  itemCount: 3,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Container(
                        height: 140.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: ColorPalette().white,
                          border: Border.all(color: ColorPalette().softBlue1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
