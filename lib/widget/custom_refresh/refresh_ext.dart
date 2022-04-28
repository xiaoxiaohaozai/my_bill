import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 刷新状态
enum Refresh {
  ///初次进入页面加载
  first,

  ///上拉加载
  up,

  ///下拉刷新
  down,
}

class RefreshExt {
  ///刷新加载失败
  ///[controller] RefreshController
  ///[refresh] 加载类型 第一次、上拉、下拉
  static onError(RefreshController controller, Refresh refresh) {
    if (refresh == Refresh.down) {
      controller.refreshFailed();
    } else if (refresh == Refresh.up) {
      controller.loadFailed();
    }
  }

  ///刷新加载成功
  ///[controller] RefreshController
  ///[refresh] 加载类型 第一次、上拉、下拉
  ///[over] 是否为最后一页
  static onSuccess(RefreshController controller, Refresh refresh, bool over) {
    if (refresh == Refresh.up) {
      if (over) {
        //最后一页
        controller.loadNoData();
      } else {
        controller.loadComplete();
      }
    } else if (refresh == Refresh.down) {
      controller.refreshCompleted(resetFooterState: true);
    }
  }
}
