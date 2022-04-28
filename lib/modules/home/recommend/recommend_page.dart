import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/models/banner_mo.dart';
import '../../../res/colors.dart';
import '../../../widget/video_card.dart';
import '../widget/recommend_banner.dart';
import 'recommend_logic.dart';

/// 推荐页
class RecommendPage extends StatelessWidget {
  late RecommendLogic logic;

  RecommendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logic = Get.put(RecommendLogic());
    return Container(
      color: ColorRes.color_F5F5F9,
      child: _buildVideoList(),
    );
  }

  /// 视频列表
  Widget _buildVideoList() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SmartRefresher(
          controller: logic.refreshController,
          enablePullUp: true,
          enablePullDown: true,
          onLoading: logic.onLoading,
          onRefresh: logic.onRefresh,
          child: CustomScrollView(
            cacheExtent: 700,
            slivers: [
              //banner
              SliverToBoxAdapter(
                child: _buildBanner(logic.bannerList),
              ),
              //瀑布流
              SliverMasonryGrid.count(
                  childCount: logic.videoList.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.h,
                  crossAxisSpacing: 5.w,
                  itemBuilder: (context, index) {
                    return _buildVideoCard(index);
                  }),
            ],
          ),
        ),
      );
    });
  }

  /// banner
  Widget _buildBanner(List<BannerMo> bannerList) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: RecommendBanner(
        bannerList,
        bannerHeight: 177.h,
      ),
    );
  }

  Widget _buildVideoCard(int index) {
    return VideoCard(videoMo: logic.videoList[index]);
  }
}
