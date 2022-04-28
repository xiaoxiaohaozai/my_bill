
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../widget/custom_refresh/refresh_ext.dart';
import 'base_empty_controller.dart';



/// 支持上拉加载,下拉刷新,缺省页
/// L 为列表数据模型
abstract class BasePageController extends BaseEmptyController {
  //当前页数
  int _page = 1;

  // 列表刷新适配器
  late RefreshController refreshController;

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
  }

  ///预留上拉刷新
  void onRefresh() {
    requestData(Refresh.down, 1);
  }

  ///预留下拉加载
  void onLoading() {
    requestData(Refresh.up, _page + 1);
  }

  ///网络请求在此处进行，不用在重复进行上拉下拉的处理
  void requestData(Refresh refresh, int page);

  void updatePage(int newPage) {
    _page = newPage;
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
