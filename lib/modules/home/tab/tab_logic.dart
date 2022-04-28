import 'package:get/get.dart';
import 'package:my_bili/common/app_ext.dart';

import '../../../common/base/controllers/base_page_controller.dart';
import '../../../data/models/home_mo.dart';
import '../../../data/models/video_mo.dart';
import '../../../data/repositories/bili_repository.dart';
import '../../../widget/custom_refresh/refresh_ext.dart';

class TabLogic extends BasePageController {
  //视频列表数据
  var videoList = RxList<VideoMo>();

  String name;

  TabLogic({required this.name});

  @override
  void onReady() {
    loadData();
    super.onReady();
  }

  /// 第一次加载
  void loadData() async {
    showLoading();
    asyncRequest(
      () => BiliRepository.to.loadHomeCategory(name, 1),
      onSuccess: (data) {
        var homeMo = HomeMo.fromJson(data);
        updatePage(1);
        if (homeMo.videoList!.isNotEmpty) {
          videoList.value = homeMo.videoList!;
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

  @override
  void requestData(Refresh refresh, int page) async {
    asyncRequest(
      () => BiliRepository.to.loadHomeCategory(name, page),
      onSuccess: (data) {
        var homeMo = HomeMo.fromJson(data);
        var newVideoList = homeMo.videoList!;
        //下拉刷新
        if (refresh == Refresh.down) {
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
