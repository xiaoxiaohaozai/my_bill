import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_bili/common/utils/loading.dart';

///  请求逻辑处理上移到controller层

typedef OnFailure = Function(dynamic error, int? code, String? msg);

typedef OnSuccess = Function(dynamic data);

///  给controller 扩展 api 请求
extension ControllerExt on GetxController {
  /// 异步请求
  Future<void> asyncRequest(Future<Response> Function() request,
      {required OnSuccess? onSuccess, OnFailure? onFailure}) async {
    try {
      Response response = await request();
      var code = response.data["code"];
      var msg = response.data["msg"];
      var data = response.data["data"];
      //业务码异常处理
      if (code == 0) {
        onSuccess?.call(data);
      } else {
        onFailure?.call(data, code, msg);
        if (msg != null) {
          Loading.dismiss();
          Loading.showError(msg);
        }
      }
    } on Exception catch (error) {
      handleError(error, onFailure: onFailure);
    }
  }
}

/// 统一异常处理
void handleError(Exception error, {OnFailure? onFailure}) {
  int? code = -1;
  String? msg = "未知异常";
  dynamic errorData;
  if (error is DioError) {
    // dio 异常
    switch (error.type) {
      case DioErrorType.connectTimeout:
        msg = "连接超时,请稍后再试";
        break;
      case DioErrorType.receiveTimeout:
        msg = "响应超时,请稍后再试";
        break;
      case DioErrorType.sendTimeout:
        msg = "请求超时,请稍后再试";
        break;
      case DioErrorType.cancel:
        msg = "请求取消";
        break;
      case DioErrorType.response:
        //状态码异常
        code = error.response?.statusCode;
        errorData = error.response?.data;
        if (code != null) {
          handleStatusCode(code);
        }
        break;
      case DioErrorType.other:
        if (error.error is SocketException) {
          msg = "当前无网络，请检查你的网络设置";
        }
        break;
    }
  } else {
    //其他异常，例如json解析异常等
    msg = "请求报错 ${error.toString()}";
    errorData = error;
  }
  //显示全局错误
  Loading.dismiss();
  Loading.showError(msg);
  onFailure?.call(errorData, code, msg);
}

/// 统一状态码处理
void handleStatusCode(int code) {}
