import 'package:flutter/material.dart';

import 'barrage_transition.dart';

/// 每一条弹幕对应的widget
class BarrageItem extends StatelessWidget {
  final String id;
  final double top; //距离顶部距离
  final Widget child;
  final ValueChanged onAnimationComplete;
  final Duration duration; // 每条动画的执行时间

  const BarrageItem(
      {Key? key,
      required this.id,
      required this.top,
      required this.onAnimationComplete,
      this.duration = const Duration(milliseconds: 9000),
      required this.child})
      : super(key: key);

  // //fix 动画状态错乱
  // final _key = GlobalKey<BarrageTransitionState>();

  @override
  Widget build(BuildContext context) {
    // Positioned.fill 填充满整个stack
    return Positioned(
      left: 0,
      right: 0,
      top: top,
      child: BarrageTransition(
        // key: _key,
        child: child,
        onAnimationComplete: (v) {
          onAnimationComplete(id);
        },
        duration: duration,
      ),
    );
  }
}
