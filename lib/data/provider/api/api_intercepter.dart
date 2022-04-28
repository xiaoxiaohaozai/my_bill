
import 'package:dio/dio.dart';

import '../../../common/constants.dart';

/// app 拦截器 统一处理请求逻辑
class ApiInterceptor extends Interceptor {
  /// 请求拦截
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 增加请求头
    options.headers.addAll({
      "boarding-pass": Constants.BOARDING_PASS,
      "auth-token": Constants.AUTH_TOKEN
    });
    super.onRequest(options, handler);
  }
}
