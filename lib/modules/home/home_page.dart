import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_bili/modules/home/recommend/recommend_page.dart';
import 'package:my_bili/modules/home/tab/tab_page.dart';
import 'package:my_bili/widget/custom_top_bar.dart';

import '../../res/colors.dart';
import '../../res/res.dart';
import '../../widget/hi_tab.dart';
import '../../widget/keep_alive_wrapper.dart';
import 'home_logic.dart';

/// 首页
class HomePage extends StatelessWidget {
  late HomeLogic logic;

  @override
  Widget build(BuildContext context) {
    logic = Get.put(HomeLogic());
    return Container(
      child: Column(
        children: [
          _buildTop(),
          _buildTabBar(),
          _buildTabBarView(),
        ],
      ),
    );
  }

  /// 顶部搜索
  Widget _buildTop() {
    return CustomTopBar(
        height: 44.h,
        color: ColorRes.color_F5F5F9,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  //  Routes.toLogin();
                },
                child: ClipRRect(
                  child: Image.asset(
                    Res.imageUserLogo,
                    height: 28.h,
                    width: 28.h,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(14.h),
                ),
              ),
              SizedBox(
                width: 21.5.h,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.5.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white),
                  height: 32.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(Res.imageIcSearch,
                          width: 20.w,
                          height: 20.w,
                          color: ColorRes.color_979799),
                      Image.asset(
                        Res.imageIcQr,
                        width: 20.w,
                        height: 20.w,
                        color: ColorRes.color_979799,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 21.5.h,
              ),
            ],
          ),
        ));
  }

  /// 构建顶部indicator
  Widget _buildTabBar() {
    return Container(
        color: ColorRes.color_F5F5F9,
        child: Obx(
          () => HiTab(
            logic.tabs.map((category) {
              return Tab(text: category.name);
            }).toList(),
            logic.tabController,
            fontSize: 14.sp,
            borderWidth: 3.h,
          ),
        ));
  }

  /// 构建内容
  Widget _buildTabBarView() {
    return Expanded(
        child: Obx(() => TabBarView(
            controller: logic.tabController,
            children: logic.tabs.map((category) {
              if (category.name == "推荐") {
                return KeepAliveWrapper(
                  child: RecommendPage(),
                );
              } else {
                return KeepAliveWrapper(
                  child: TabPage(
                    name: category.name!,
                  ),
                );
              }
            }).toList())));
  }
}
