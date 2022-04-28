import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../res/colors.dart';

class LottieItem {
  String name;
  String lottieAssetPath;

  LottieItem(this.name, this.lottieAssetPath);
}

/// 自定义底部导航栏
class LottieBottomBar extends BottomAppBar {
  List<LottieItem> items;

  //默认选中
  int currentIndex;

  ValueChanged<int> onBottomItemChanged;

  LottieBottomBar(this.items,
      {Key? key, this.currentIndex = 0, required this.onBottomItemChanged})
      : super(key: key);

  @override
  State<LottieBottomBar> createState() => _LottieBottomBarState();
}

class _LottieBottomBarState extends State<LottieBottomBar>
    with TickerProviderStateMixin {
  // 绑定动画控制器
  late Map<int, AnimationController> controllers = <int, AnimationController>{};

  //默认
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    for (var index = 0; index < widget.items.length; index++) {
      controllers[index] = AnimationController(vsync: this);
    }
  }

  @override
  void dispose() {
    controllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //底部空出安全距离
    var bottom = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.only(bottom: bottom),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.items.map((item) {
              return _buildBottomAppBarItem(item);
            }).toList()),
      ),
    );
  }

  /// 构建item
  Widget _buildBottomAppBarItem(LottieItem item) {
    var tempIndex = widget.items.indexOf(item);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        var tempIndex = widget.items.indexOf(item);
        if (tempIndex != currentIndex) {
          currentIndex = tempIndex;
          controllers.forEach((key, value) {
            if (key == currentIndex) {
              value.forward();
            } else {
              value.reverse();
            }
          });

          //更新状态
          setState(() {});
          widget.onBottomItemChanged(tempIndex);
        }
      },
      child: Column(children: [
        //Lottie
        Lottie.asset(item.lottieAssetPath,
            height: 30.w,
            width: 30.w,
            controller: controllers[tempIndex], onLoaded: (composition) {
          var controller = controllers[tempIndex]!;
          controller.duration = const Duration(milliseconds: 500);

          //第一次执行
          if (currentIndex == tempIndex) {
            controller.forward();
          }
        }),
        Padding(
          padding: EdgeInsets.only(top: 3.5.h, bottom: 4.5.h),
          child: Text(
            item.name,
            style: TextStyle(
                fontSize: 10.sp,
                color: tempIndex == currentIndex
                    ? ColorRes.color_232323
                    : ColorRes.color_979799),
          ),
        )
      ]),
    );
  }
}
