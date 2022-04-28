

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 显示网络图片 ,磁盘缓存
Widget cachedImage(String url, {double? width, double? height , BoxFit? fit =BoxFit.cover }) {
  return CachedNetworkImage(
    imageUrl: url,
    height: height,
    width: width,
    fit: fit,

    //占位图
    placeholder: (BuildContext context, String url) {
      return Container(
        color: Colors.grey[200],
      );
    },
    //错误图
    errorWidget: (BuildContext context, String url, dynamic error) {
      return const Icon(Icons.error);
    },
  );

}
