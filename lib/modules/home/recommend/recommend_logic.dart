import 'package:get/get.dart';
import 'package:my_bili/common/app_ext.dart';

import '../../../common/base/controllers/base_page_controller.dart';
import '../../../data/models/banner_mo.dart';
import '../../../data/models/home_mo.dart';
import '../../../data/models/video_mo.dart';
import '../../../data/repositories/bili_repository.dart';
import '../../../widget/custom_refresh/refresh_ext.dart';
import '../home_logic.dart';

/// 推荐页逻辑
class RecommendLogic extends BasePageController {
  //轮播图
  var bannerList = RxList<BannerMo>();

  //视频列表数据
  var videoList = RxList<VideoMo>();


  @override
  void onReady() {
    //首页接口已经请求过了,首次加载直接使用
    var homeLogic = Get.find<HomeLogic>();
    bannerList.value = homeLogic.homeMo.bannerList!;
    videoList.value = homeLogic.homeMo.videoList!;
    super.onReady();
  }

  @override
  void requestData(Refresh refresh, int page) async {
    asyncRequest(
      () => BiliRepository.to.loadHomeCategory("推荐", page),
      onSuccess: (data) {
        var homeMo = HomeMo.fromJson(data);
        var newVideoList = homeMo.videoList!;
        //下拉刷新
        if (refresh == Refresh.down) {
          // 刷新banner
          bannerList.value = homeMo.bannerList!;
          videoList.clear();
        }
        if (newVideoList.isNotEmpty) {
          videoList.addAll(newVideoList);
        }
        //刷新成功,在同步页数
        updatePage(page);
        //分页加载成功
        RefreshExt.onSuccess(refreshController, refresh, newVideoList.isEmpty);
      },
      onFailure: (error, code, msg) {
        //分页加载失败
        RefreshExt.onError(refreshController, refresh);
      },
    );
  }
}
