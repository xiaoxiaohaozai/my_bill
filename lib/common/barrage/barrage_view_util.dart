import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/res.dart';
import 'barrage_mo.dart';

/// 创建弹幕样式
class BarrageViewUtil {
  //如果想定义弹幕样式，可以在这里根据弹幕的类型来定义
  static barrageView(BarrageMo model) {
    switch (model.type) {
      case 1:
        return _barrageType1(model);
    }
    return Text(model.content, style: const TextStyle(color: Colors.white));
  }

  /// 弹幕样式1
  static _barrageType1(BarrageMo model) {
    return Row(children: [
      ClipRRect(
        child: Image.asset(
          Res.imageUserLogo,
          height: 28.h,
          width: 28.h,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(14.h),
      ),
      const SizedBox(width: 10,),
      Text(
        model.content,
        style: const TextStyle(color: Colors.red),
      )
    ]);
  }
}
