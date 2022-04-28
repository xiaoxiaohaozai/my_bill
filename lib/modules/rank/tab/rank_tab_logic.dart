import 'package:get/get.dart';
import 'package:my_bili/common/app_ext.dart';

import '../../../common/base/controllers/base_page_controller.dart';
import '../../../data/models/ranking_mo.dart';
import '../../../data/models/video_mo.dart';
import '../../../data/repositories/bili_repository.dart';
import '../../../widget/custom_refresh/refresh_ext.dart';

class RankTabLogic extends BasePageController {
  String sort;

  RankTabLogic({required this.sort});

  //视频卡片
  var videoList = RxList<VideoMo>();

  @override
  void onReady() {
    showLoading();
    asyncRequest(
      () => BiliRepository.to.loadRankingDataBySort(sort, 1),
      onSuccess: (data) {
        var rankMo = RankingMo.fromJson(data);
        updatePage(1);
        if (rankMo.list!.isNotEmpty) {
          videoList.value = rankMo.list!;
          showSuccess(false);
        } else {
          showSuccess(true);
        }
      },
      onFailure: (error, code, msg) {
        showError();
      },
    );
    super.onReady();
  }

  @override
  void requestData(Refresh refresh, int page) async {
    asyncRequest(
      () => BiliRepository.to.loadRankingDataBySort(sort, page),
      onSuccess: (data) {
        var rankMo = RankingMo.fromJson(data);
        var newVideoList = rankMo.list!;
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
        RefreshExt.onError(refreshController, refresh);
      },
    );
  }
}
