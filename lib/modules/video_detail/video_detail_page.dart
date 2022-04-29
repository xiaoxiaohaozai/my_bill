import 'package:flutter/material.dart';
import 'package:flutter_overlay/flutter_overlay.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_bili/common/player/custom_video_player.dart';
import 'package:my_bili/modules/video_detail/video_detail_logic.dart';
import 'package:my_bili/modules/video_detail/widget/barrage_input.dart';
import 'package:my_bili/modules/video_detail/widget/barrage_switch.dart';
import 'package:my_bili/modules/video_detail/widget/expandable_content.dart';
import 'package:my_bili/modules/video_detail/widget/video_header.dart';
import 'package:my_bili/modules/video_detail/widget/video_toolbar.dart';
import 'package:my_bili/widget/custom_top_bar.dart';

import '../../common/constants.dart';
import '../../widget/h_video_card.dart';
import '../../widget/hi_tab.dart';
import '../../widget/state_wrapper.dart';

class VideoDetailPage extends StatelessWidget {
  late VideoDetailLogic logic;

  var vid = Get.arguments[Constants.VID];

  @override
  Widget build(BuildContext context) {
    // 每个播放器绑定不同的logic
    logic = Get.put(VideoDetailLogic(), tag: vid);
    double screenWidth = ScreenUtil().screenWidth;
    double playerHeight = screenWidth * (9 / 16);
    return Scaffold(
      body: Column(
        children: [
          CustomTopBar(
            color: Colors.black,
            height: playerHeight,
            child: _buildVideoView(screenWidth, playerHeight),
          ),
          _buildTabBar(),
          _buildTabBarView(),
        ],
      ),
    );
  }

  /// 简介和评论
  Widget _buildTabBar() {
    //Material 实现阴影效果

    return Material(
      elevation: 0.3,
      // shadowColor: Colors.grey[100],
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10.w),
        height: 40.h,
        child: Row(
          children: [
            _buildLeftTab(),
            _buildRightBarrageBtn(),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }

  /// 左侧tab 导航
  Widget _buildLeftTab() {
    return Obx(() {
      return HiTab(
        logic.tabs.map((tab) => Tab(child: Text(tab))).toList(),
        logic.tabController,
        fontSize: 14.sp,
      );
    });
  }

  ///右侧弹幕按钮
  Widget _buildRightBarrageBtn() {
    return Obx(() {
      //弹幕开关组件
      return BarrageSwitch(
        //输入框是否显示
        onShowInput: () {
          logic.inputShowing.value = true;
          // 悬浮输入框
          HiOverlay.show(Get.context!, child: BarrageInput(
            //关闭
            onTabClose: () {
              logic.inputShowing.value = false;
            },
          )).then((value) {
            //TODO 发送弹幕
          });
        },
        //弹幕功能开关回调
        onBarrageSwitch: (open) {
          if (open) {
            //TODO 打开弹幕
          } else {
            //TODO 关闭弹幕
          }
        },
        //正在输入弹幕
        inputShowing: logic.inputShowing.value,
      );
    });
  }

  /// 构建内容
  _buildTabBarView() {
    return Expanded(child: Obx(() {
      return TabBarView(
          controller: logic.tabController,
          children: logic.tabs.map((tab) {
            if (tab == "简介") {
              return _buildInfo();
            } else {
              return _buildComment();
            }
          }).toList());
    }));
  }

  /// 推荐视频列表
  Widget _buildInfo() {
    return StateWrapper(
        state: logic.loadState.value,
        child: ListView(padding: const EdgeInsets.all(0).r, //四周间距
            children: [
              if (logic.videoDetailMo.value != null) ..._buildMenu(),
              if (logic.videoDetailMo.value != null) ..._buildVideoList(),
            ]));
  }

  /// 评论
  Widget _buildComment() {
    return StateWrapper(child: Container(), state: Constants.EMPTY);
  }

  /// 视频基础信息
  List<Widget> _buildMenu() {
    var videoInfo = logic.videoDetailMo.value!.videoInfo!;
    return [
      VideoHeader(videoInfo.owner!),
      ExpandableContent(videoInfo: videoInfo),
      //支持点赞和收藏
      ViewToolBar(
        videoDetailMo: logic.videoDetailMo.value!,
        onLike: logic.likeClick,
        onUnLike: logic.unlikeClick,
        onFavorite: logic.favoriteClick,
      ),
    ];
  }

  ///视频列表
  List<Widget> _buildVideoList() {
    var videoList = logic.videoDetailMo.value!.videoList!;
    return videoList
        .map(
          (video) => HVideoCard(videoMo: video),
        )
        .toList();
  }

  /// 视频播放
  Widget _buildVideoView(double screenWidth, double playerHeight) {
    return Obx(() {
      var videoMo = logic.videoMo.value;
      if (videoMo?.url == null) {
        return Container(
          alignment: Alignment.center,
          color: Colors.black,
          width: screenWidth,
          height: playerHeight,
          child: const Text(
            "正在获取视频数据...",
            style: TextStyle(color: Colors.white),
          ),
        );
      } else {
        return CustomVideoPlayer(url: videoMo!.url!);
      }
    });
  }
}
