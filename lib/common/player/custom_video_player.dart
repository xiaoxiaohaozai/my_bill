import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:my_bili/common/utils/log_utils.dart';

import '../../application.dart';
import 'custom_panel.dart';

/// 自定义播放器
class CustomVideoPlayer extends StatefulWidget {
  final String url; //播放连接
  final bool showCover; // 显示第一帧封面
  final bool autoPlay; //自动播放
  final Widget? barrageUI;

  const CustomVideoPlayer(
      {Key? key,
      required this.url,
      this.showCover = true,
      this.autoPlay = true,
      this.barrageUI})
      : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

/// RouteAware 监听当前页面的生命周期
/// WidgetsBindingObserver 前后台
class _CustomVideoPlayerState extends State<CustomVideoPlayer>
    with RouteAware, WidgetsBindingObserver {
  // FijkPlayer实例
  late FijkPlayer player;

  bool isResume = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    player = FijkPlayer();
    //播放
    player.setDataSource(
      widget.url,
      autoPlay: widget.autoPlay,
      showCover: widget.showCover,
    );
    // 这句不能省，必须有
    speed = 1.0;
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    routeObserver.unsubscribe(this);
    player.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //设置播放器宽高
    double playerWidth = MediaQuery.of(context).size.width;
    double playerHeight = playerWidth * (9 / 16);
    return FijkView(
      player: player,
      color: Colors.black,
      width: playerWidth,
      fit: FijkFit.ar16_9,
      fsFit: FijkFit.ar16_9,
      height: playerHeight,
      // 自定义面板
      panelBuilder: (FijkPlayer player, FijkData data, BuildContext context,
          Size viewSize, Rect texturePos) {
        return Stack(
          children: [
            //弹幕组件
            if (widget.barrageUI != null) widget.barrageUI!,
            //控制组件
            _customPanel(
              player,
              viewSize,
              texturePos,
              context,
            )
          ],
        );
      },
    );
  }

  /// 自定义控制面板
  Widget _customPanel(FijkPlayer player, Size viewSize, Rect texturePos,
      BuildContext? pageContext) {
    return CustomPanel(
      player: player,
      // 传递 context 用于左上角返回箭头关闭当前页面，不要传递错误 context，
      // 如果要点击箭头关闭当前的页面，那必须传递当前组件的根 context
      pageContext: pageContext,
      viewSize: viewSize,
      texturePos: texturePos,
      // 标题 当前页面顶部的标题部分，可以不传，默认空字符串
      playerTitle: "",
      // 显示的配置
      showConfig: PlayerShowConfig(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // 可见时执行
    if (isResume == false) {
      return;
    }
    if (state == AppLifecycleState.resumed) {
      loggerNoStack.e("$this,前台");
      player.start();
    } else {
      loggerNoStack.e("$this,后台");
      player.pause();
    }
  }

  @override
  void didPushNext() {
    super.didPushNext();
    isResume = false;
    loggerNoStack.e("$this,下个界面进入");
    player.pause();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    loggerNoStack.e("$this,下个界面退出");
    isResume = true;
    player.start();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }
}

// 这里实现一个皮肤显示配置项
class PlayerShowConfig implements ShowConfigAbs {
  @override
  bool speedBtn = true; // 是否显示速度按钮
  @override
  bool topBar = true; // 是否显示播放器状态栏（顶部），非系统
  @override
  bool lockBtn = true; // 是否显示锁按钮

  @override
  bool bottomPro = true; // 底部吸底进度条，贴底部，类似开眼视频
  @override
  bool stateAuto = false; // 是否自适应系统状态栏，true 会计算系统状态栏，从而加大 topBar 的高度，避免挡住播放器状态栏
  @override
  bool isAutoPlay = true; // 是否自动开始播放
}
