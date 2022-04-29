
import 'package:get/get.dart';

import '../../constants.dart';

/// 缺省页
/// 增加生命周期 FullLifeCycleController with FullLifeCycleMixin
abstract class BaseEmptyController extends GetxController {
  ///加载状态  0加载中 1加载成功 2加载数据为空 3加载失败
  var loadState = Constants.LOADING.obs;

  ///加载成功，是否显示空页面
  void showSuccess(bool isEmpty) {
    loadState.value = isEmpty ? Constants.EMPTY: Constants.SUCCESS;
  }

  ///加载失败,显示失败页面
  void showError() {
    loadState.value = Constants.ERROR;
  }

  ///重新加载
  void showLoading() {
    loadState.value = Constants.LOADING;
  }
}
