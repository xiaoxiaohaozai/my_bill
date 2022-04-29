import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_bili/common/app_ext.dart';
import 'package:my_bili/common/base/controllers/base_empty_controller.dart';
import 'package:my_bili/data/repositories/bili_repository.dart';

import '../../common/constants.dart';
import '../../common/utils/loading.dart';
import '../../data/models/video_detail_mo.dart';
import '../../data/models/video_mo.dart';

class VideoDetailLogic extends BaseEmptyController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  //视频播放信息,用户信息
  var videoMo = Rx<VideoMo?>(null);

  //分类
  var tabs = RxList(["简介", "评论"]);

  //是否正在输入弹幕
  var inputShowing = RxBool(false);

  //视频详情信息
  var videoDetailMo = Rx<VideoDetailMo?>(null);

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
    // 获取视频详情
    var arguments = Get.arguments;
    var vid = arguments[Constants.VID];
    showLoading();
    asyncRequest(
      () => BiliRepository.to.loadVideoDetail(vid),
      onSuccess: (data) {
        var mo = VideoDetailMo.fromJson(data);
        //播放器需要的信息
        videoMo.value = mo.videoInfo;
        if (mo.videoList?.isNotEmpty == true) {
          //视频相关信息
          videoDetailMo.value = mo;
          showSuccess(false);
        } else {
          showSuccess(true);
        }
      },
      onFailure: (error, code, msg) {
        showError();
      },
    );
  }


  /// 点赞
  void likeClick() async{
    Loading.toast("暂不支持该功能!");
  }

  /// 取消点赞
  void unlikeClick() {
    Loading.toast("暂不支持该功能!");
  }

  /// 收藏取消收藏
  void favoriteClick() {
    Loading.toast("暂不支持该功能!");
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }
}
