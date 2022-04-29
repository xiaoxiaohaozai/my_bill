import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'barrage_item.dart';
import 'barrage_mo.dart';
import 'barrage_view_util.dart';
import 'hi_socket.dart';

/// 定义弹幕相关接口
abstract class IBarrage {
  void send(String message);

  void pause();

  void play();
}

enum BarrageStatus { play, pause }

/// 弹幕管理
class HiBarrage extends StatefulWidget {
  final int lineCount; //显示行数
  final String vid; //视频vid
  final int speed; //弹幕速度
  final double top; //距离顶部的距离
  final bool autoPlay; //自动播放
  final Map<String, dynamic> headers;

  const HiBarrage(
      {Key? key,
      this.lineCount = 4,
      required this.vid,
      this.speed = 800,
      this.top = 0,
      this.autoPlay = false,
      required this.headers})
      : super(key: key);

  @override
  HiBarrageState createState() => HiBarrageState();
}

class HiBarrageState extends State<HiBarrage> implements IBarrage {
  late HiSocket _hiSocket;
  late double _height;
  late double _width;
  final List<BarrageItem> _barrageItemList = []; //弹幕widget集合
  final List<BarrageMo> _barrageMoList = []; //弹幕模型
  int _barrageIndex = 0; //第几条弹幕
  BarrageStatus? _barrageStatus;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    //建立socket连接
    _hiSocket = HiSocket(widget.headers);
    _hiSocket.open(widget.vid).listen((value) {
      _handleMessage(value);
    });
  }

  @override
  void dispose() {
    _barrageItemList.clear();
    _barrageMoList.clear();
    _hiSocket.close();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //定义宽高
    _width = MediaQuery.of(context).size.width;
    _height = _width / 16 * 9;
    return SizedBox(
      width: _width,
      height: _height,
      child: Stack(
        children: [
          //TODO 防止Stack的child为会报错
          Container(),
          ..._barrageItemList
        ],
      ),
    );
  }

  ///处理消息，instant=true 马上发送
  void _handleMessage(List<BarrageMo> modelList, {bool instant = false}) {
    if (instant) {
      _barrageMoList.insertAll(0, modelList);
    } else {
      _barrageMoList.addAll(modelList);
    }
    //收到新的弹幕后播放
    if (widget.autoPlay || _barrageStatus != BarrageStatus.pause) {
      play();
    }
  }

  @override
  void play() {
    print('开始播放弹幕');
    _barrageStatus = BarrageStatus.play;
    //定时器播放弹幕
    if (_timer != null && (_timer?.isActive ?? false)) return;
    _timer = Timer.periodic(Duration(milliseconds: widget.speed), (timer) {
      if (_barrageMoList.isNotEmpty) {
        //将发送的弹幕将集合中剔除
        var temp = _barrageMoList.removeAt(0);
        addBarrageItem(temp);
        print('播放弹幕: ${temp.content}');
      } else {
        print('弹幕播放完成');
        //弹幕发送完毕后关闭定时器
        _timer?.cancel();
      }
    });
  }

  ///添加弹幕组件
  void addBarrageItem(BarrageMo model) {
    double perRowHeight = 30.h;
    // 计算弹幕显示在第几行
    var line = _barrageIndex % widget.lineCount;

    _barrageIndex++;
    // 计算每一行的位置
    var top = line * perRowHeight + widget.top;
    //创建单个弹幕组件
    var item = BarrageItem(
      id: _barrageId(model.content), //每条条目生成一个id
      top: top,
      child: BarrageViewUtil.barrageView(model), //构建弹幕样式
      onAnimationComplete: _onAnimationComplete,
    );
    _barrageItemList.add(item);
    setState(() {});
  }

  /// 生成弹幕组件id
  String _barrageId(String content) {
    return "${DateTime.now().millisecondsSinceEpoch}_$content";
  }

  @override
  void pause() {
    if (_barrageStatus == BarrageStatus.pause) {
      return;
    }
    _barrageStatus = BarrageStatus.pause;
    //清空屏幕上的弹幕
    _barrageItemList.clear();
    //停止计时器
    _timer?.cancel();
    setState(() {});
    print('暂停弹幕播放');
  }

  /// 发送弹幕
  @override
  void send(String? message) {
    if (message == null) return;
    _hiSocket.send(message);
    //本地播放弹幕
    _handleMessage(
        [BarrageMo(content: message, vid: '-1', priority: 1, type: 1)]);
  }

  /// 弹幕动画执行完成
  void _onAnimationComplete(id) {
    //弹幕播放完毕将其从弹幕widget集合中剔除
    _barrageItemList.removeWhere((element) => element.id == id);
  }
}
