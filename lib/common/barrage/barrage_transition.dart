import 'package:flutter/material.dart';

///弹幕组件移动动效
///http://laomengit.com/flutter/widgets/SlideTransition.html#slidetransition
class BarrageTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final ValueChanged onAnimationComplete;

  const BarrageTransition(
      {Key? key,
      required this.duration,
      required this.onAnimationComplete,
      required this.child})
      : super(key: key);

  @override
  BarrageTransitionState createState() => BarrageTransitionState();
}

class BarrageTransitionState extends State<BarrageTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    //创建动画控制器
    _animationController =
        AnimationController(duration: widget.duration, vsync: this)
          ..addStatusListener((status) {
            //动画执行完毕之后的回调
            if (status == AnimationStatus.completed) {
              widget.onAnimationComplete('');
            }
          });
    //定义从右向左的补间动画,Tween中设置Offset的值是比例，1表示父组件的宽高。
    var begin = const Offset(1.0, 0);
    var end = const Offset(-1, 0);
    _animation = Tween(begin: begin, end: end).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    //平移动画
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
