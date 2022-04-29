import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

import 'package:fijkplayer_skin/slider.dart'
    show NewFijkSliderColors, NewFijkSlider;


double speed = 1.0;
bool lockStuff = false;
bool hideLockStuff = false;
const double barHeight = 50.0;
final double barFillingHeight =
    MediaQueryData.fromWindow(window).padding.top + barHeight;
final double barGap = barFillingHeight - barHeight;

abstract class ShowConfigAbs {
  late bool speedBtn;
  late bool lockBtn;
  late bool topBar;
  late bool bottomPro;
  late bool stateAuto;
  late bool isAutoPlay;
}

class WithPlayerChangeSource {}

/// 格式化时间
String _duration2String(Duration duration) {
  if (duration.inMilliseconds < 0) return "-: negative";

  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  int inHours = duration.inHours;
  return inHours > 0
      ? "$inHours:$twoDigitMinutes:$twoDigitSeconds"
      : "$twoDigitMinutes:$twoDigitSeconds";
}

/// 自定义面板
class CustomPanel extends StatefulWidget {
  final FijkPlayer player;
  final Size viewSize;
  final Rect texturePos;
  final BuildContext? pageContext;
  final String playerTitle;
  final ShowConfigAbs showConfig;

  const CustomPanel(
      {Key? key,
      required this.player,
      required this.viewSize, //  对应 FijkView 的实际显示大小
      required this.texturePos, // 视频的实际位置
      this.pageContext,
      this.playerTitle = "",
      required this.showConfig})
      : super(key: key);

  @override
  _CustomPanelState createState() => _CustomPanelState();
}

class _CustomPanelState extends State<CustomPanel>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  FijkPlayer get player => widget.player;

  ShowConfigAbs get showConfig => widget.showConfig;

  bool _lockStuff = lockStuff;
  bool _hideLockStuff = hideLockStuff;
  Timer? _hideLockTimer;

  FijkState? _playerState;
  bool _isPlaying = false;

  StreamSubscription? _currentPosSubs;

  AnimationController? _animationController;

  void initEvent() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 280),
      vsync: this,
    );

    _playerState = player.value.state;
    if (player.value.duration.inMilliseconds > 0 && !_isPlaying) {
      _isPlaying = true;
    }
    setState(() {});
    player.addListener(_onPlayerValueChanged);
    Wakelock.enable();
  }

  @override
  void initState() {
    super.initState();
    initEvent();
  }

  @override
  void dispose() {
    _currentPosSubs?.cancel();
    _hideLockTimer?.cancel();
    player.removeListener(_onPlayerValueChanged);
    _animationController!.dispose();
    Wakelock.disable();
    super.dispose();
  }

  /// 监听播放器变化
  void _onPlayerValueChanged() {
    if (player.value.duration.inMilliseconds > 0 && !_isPlaying) {
      setState(() {
        _isPlaying = true;
      });
    }
    setState(() {
      _playerState = player.value.state;
    });
  }

  // 切换UI lock显示状态
  void changeLockState(bool state) {
    setState(() {
      _lockStuff = state;
      if (state == true) {
        _hideLockStuff = true;
        _cancelAndRestartLockTimer();
      }
    });
  }

  void _cancelAndRestartLockTimer() {
    if (_hideLockStuff == true) {
      _startHideLockTimer();
    }
    setState(() {
      _hideLockStuff = !_hideLockStuff;
    });
  }

  void _startHideLockTimer() {
    _hideLockTimer?.cancel();
    _hideLockTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _hideLockStuff = true;
      });
    });
  }

  // 锁 组件
  Widget _buildLockStateDetector() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _cancelAndRestartLockTimer,
      child: AnimatedOpacity(
        opacity: _hideLockStuff ? 0.0 : 0.7,
        duration: const Duration(milliseconds: 400),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              top:
                  showConfig.stateAuto && !player.value.fullScreen ? barGap : 0,
            ),
            child: IconButton(
              iconSize: 30,
              onPressed: () {
                setState(() {
                  _lockStuff = false;
                  _hideLockStuff = true;
                });
              },
              icon: const Icon(Icons.lock_open),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // 返回按钮
  Widget _buildTopBackBtn() {
    return Container(
      height: barHeight,
      alignment: Alignment.centerLeft,
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        color: Colors.white,
        onPressed: () {
          // 判断当前是否全屏，如果全屏，退出
          if (widget.player.value.fullScreen) {
            player.exitFullScreen();
          } else {
            if (widget.pageContext == null) return;
            player.stop();
            Navigator.pop(widget.pageContext!);
          }
        },
      ),
    );
  }

  ///  通用容器 包含状态栏间距处理
  Widget _buildPublicFrameWidget({
    required Widget slot,
    Color? bgColor,
  }) {
    return Container(
      color: bgColor,
      child: Stack(
        children: [
          // 视频标题,返回键
          showConfig.topBar
              ? Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  child: Container(
                    height:
                        showConfig.stateAuto && !widget.player.value.fullScreen
                            ? barFillingHeight
                            : barHeight,
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: barHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          //返回键
                          _buildTopBackBtn(),
                          //标题
                          Expanded(
                            child: Text(
                              widget.playerTitle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
          //全屏占位组件
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                    top: showConfig.stateAuto && !widget.player.value.fullScreen
                        ? barGap
                        : 0),
                child: slot,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 错误slot
  Widget _buildErrorStateSlotWidget() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: showConfig.stateAuto && !widget.player.value.fullScreen
                ? barGap
                : 0,
          ),
          // 失败图标
          const Icon(
            Icons.error,
            size: 50,
            color: Colors.white,
          ),
          // 错误信息
          const Text(
            "播放失败，您可以点击重试！",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          // 重试
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () {},
            child: const Text(
              "点击重试",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  // 加载中slot
  Widget _buildLoadingStateSlotWidget() {
    return const SizedBox(
      width: barHeight * 0.8,
      height: barHeight * 0.8,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ),
    );
  }

  // 未开始slot
  Widget _buildIdleStateSlotWidget() {
    return IconButton(
      iconSize: barHeight * 1.2,
      icon: const Icon(Icons.play_arrow, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      onPressed: () async {},
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //全屏尺寸
    Rect rect = player.value.fullScreen
        ? Rect.fromLTWH(
            0,
            0,
            widget.viewSize.width,
            widget.viewSize.height,
          )
        : Rect.fromLTRB(
            max(0.0, widget.texturePos.left),
            max(0.0, widget.texturePos.top),
            min(widget.viewSize.width, widget.texturePos.right),
            min(widget.viewSize.height, widget.texturePos.bottom),
          );

    // 管理组件堆叠
    List<Widget> stackWidgets = [];

    // 错误状态
    if (_playerState == FijkState.error) {
      stackWidgets.add(
        _buildPublicFrameWidget(
          slot: _buildErrorStateSlotWidget(),
          bgColor: Colors.black,
        ),
      );
    }
    // 准备状态
    else if ((_playerState == FijkState.asyncPreparing ||
            _playerState == FijkState.initialized) &&
        !_isPlaying) {
      stackWidgets.add(
        _buildPublicFrameWidget(
          slot: _buildLoadingStateSlotWidget(),
          bgColor: Colors.black,
        ),
      );
    }
    // 闲置状态
    else if (_playerState == FijkState.idle && !_isPlaying) {
      stackWidgets.add(
        _buildPublicFrameWidget(
          slot: _buildIdleStateSlotWidget(),
          bgColor: Colors.black,
        ),
      );
    } else {
      // 面板锁定
      if (_lockStuff == true &&
          showConfig.lockBtn &&
          widget.player.value.fullScreen) {
        stackWidgets.add(
          _buildLockStateDetector(),
        );
      }
      // 未锁定
      else {
        stackWidgets.add(
          _PanelGestureDetector(
            player: widget.player,
            texturePos: widget.texturePos,
            showConfig: widget.showConfig,
            pageContext: widget.pageContext,
            playerTitle: widget.playerTitle,
            viewSize: widget.viewSize,
            changeLockState: changeLockState,
          ),
        );
      }
    }

    // 返回键
    return WillPopScope(
      child: Positioned.fromRect(
        rect: rect,
        child: Stack(
          children: stackWidgets,
        ),
      ),
      onWillPop: () async {
        if (!widget.player.value.fullScreen) widget.player.stop();
        return true;
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _PanelGestureDetector extends StatefulWidget {
  final FijkPlayer player;
  final Size viewSize;
  final Rect texturePos;
  final BuildContext? pageContext;
  final String playerTitle;
  final Function changeLockState;
  final ShowConfigAbs showConfig;

  const _PanelGestureDetector({
    Key? key,
    required this.player,
    required this.viewSize,
    required this.texturePos,
    this.pageContext,
    this.playerTitle = "",
    required this.showConfig,
    required this.changeLockState,
  }) : super(key: key);

  @override
  _PanelGestureDetectorState createState() => _PanelGestureDetectorState();
}

class _PanelGestureDetectorState extends State<_PanelGestureDetector> {
  FijkPlayer get player => widget.player;

  ShowConfigAbs get showConfig => widget.showConfig;

  Duration _duration = const Duration();
  Duration _currentPos = const Duration();
  Duration _bufferPos = const Duration();

  // 滑动后值
  Duration _dragPos = const Duration();

  bool _isTouch = false;

  bool _playing = false;
  bool _prepared = false;
  String? _exception;

  double? updatePrevDx;
  double? updatePrevDy;
  int? updatePosX;

  bool? isDragVerLeft;

  double? updateDragVarVal;

  bool varTouchInitSuc = false;

  bool _buffering = false;

  double _seekPos = -1.0;

  StreamSubscription? _currentPosSubs;
  StreamSubscription? _bufferPosSubs;
  StreamSubscription? _bufferingSubs;

  Timer? _hideTimer;
  bool _hideStuff = true;

  bool _hideSpeedStu = true;
  double _speed = speed;

  bool _isHorizontalMove = false;

  Map<String, double> speedList = {
    "2.0": 2.0,
    "1.8": 1.8,
    "1.5": 1.5,
    "1.2": 1.2,
    "1.0": 1.0,
  };

  void initEvent() {
    // 设置初始化的值，全屏与半屏切换后，重设
    setState(() {
      _speed = speed;
      // 每次重绘的时候，判断是否已经开始播放
      _hideStuff = !_playing ? false : true;
    });
    // 延时隐藏
    _startHideTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _hideTimer?.cancel();

    player.removeListener(_playerValueChanged);
    _currentPosSubs?.cancel();
    _bufferPosSubs?.cancel();
    _bufferingSubs?.cancel();
  }

  @override
  void initState() {
    super.initState();

    initEvent();

    _duration = player.value.duration;
    _currentPos = player.currentPos;
    _bufferPos = player.bufferPos;
    _prepared = player.state.index >= FijkState.prepared.index;
    _playing = player.state == FijkState.started;
    _exception = player.value.exception.message;
    _buffering = player.isBuffering;

    player.addListener(_playerValueChanged);

    _currentPosSubs = player.onCurrentPosUpdate.listen((v) {
      setState(() {
        _currentPos = v;
        // 后加入，处理fijkplay reset后状态对不上的bug，
        _playing = true;
        _prepared = true;
      });
    });

    _bufferPosSubs = player.onBufferPosUpdate.listen((v) {
      setState(() {
        _bufferPos = v;
      });
    });

    _bufferingSubs = player.onBufferStateUpdate.listen((v) {
      setState(() {
        _buffering = v;
      });
    });
  }

  void _playerValueChanged() async {
    FijkValue value = player.value;
    if (value.duration != _duration) {
      setState(() {
        _duration = value.duration;
      });
    }
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    print('++++++++ 是否开始播放 => ${value.state == FijkState.started} ++++++++');
    print('+++++++++++++++++++ 播放器状态 => ${value.state} ++++++++++++++++++++');
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    // 新状态
    bool playing = value.state == FijkState.started;
    bool prepared = value.prepared;
    String? exception = value.exception.message;
    // 状态不一致，修改
    if (playing != _playing ||
        prepared != _prepared ||
        exception != _exception) {
      setState(() {
        _playing = playing;
        _prepared = prepared;
        _exception = exception;
      });
    }
    value.state == FijkState.completed;
  }

  _onHorizontalDragStart(details) {
    setState(() {
      updatePrevDx = details.globalPosition.dx;
      updatePosX = _currentPos.inMilliseconds;
    });
  }

  _onHorizontalDragUpdate(details) {
    double curDragDx = details.globalPosition.dx;
    // 确定当前是前进或者后退
    int cdx = curDragDx.toInt();
    int pdx = updatePrevDx!.toInt();
    bool isBefore = cdx > pdx;

    // 计算手指滑动的比例
    int newInterval = pdx - cdx;
    double playerW = MediaQuery.of(context).size.width;
    int curIntervalAbs = newInterval.abs();
    double movePropCheck = (curIntervalAbs / playerW) * 100;

    // 计算进度条的比例
    double durProgCheck = _duration.inMilliseconds.toDouble() / 100;
    int checkTransfrom = (movePropCheck * durProgCheck).toInt();
    int dragRange =
        isBefore ? updatePosX! + checkTransfrom : updatePosX! - checkTransfrom;

    // 是否溢出 最大
    int lastSecond = _duration.inMilliseconds;
    if (dragRange >= _duration.inMilliseconds) {
      dragRange = lastSecond;
    }
    // 是否溢出 最小
    if (dragRange <= 0) {
      dragRange = 0;
    }
    //
    setState(() {
      _isHorizontalMove = true;
      _hideStuff = false;
      _isTouch = true;
      // 更新下上一次存的滑动位置
      updatePrevDx = curDragDx;
      // 更新时间
      updatePosX = dragRange.toInt();
      _dragPos = Duration(milliseconds: updatePosX!.toInt());
    });
  }

  _onHorizontalDragEnd(details) {
    player.seekTo(_dragPos.inMilliseconds);
    setState(() {
      _isHorizontalMove = false;
      _isTouch = false;
      _hideStuff = true;
      _currentPos = _dragPos;
    });
  }

  _onVerticalDragStart(details) async {
    double clientW = widget.viewSize.width;
    double curTouchPosX = details.globalPosition.dx;

    setState(() {
      // 更新位置
      updatePrevDy = details.globalPosition.dy;
      // 是否左边
      isDragVerLeft = (curTouchPosX > (clientW / 2)) ? false : true;
    });
    // 大于 右边 音量 ， 小于 左边 亮度
    if (!isDragVerLeft!) {
      // 音量
      await FijkVolume.getVol().then((double v) {
        varTouchInitSuc = true;
        setState(() {
          updateDragVarVal = v;
        });
      });
    } else {
      // 亮度
      await FijkPlugin.screenBrightness().then((double v) {
        varTouchInitSuc = true;
        setState(() {
          updateDragVarVal = v;
        });
      });
    }
  }

  _onVerticalDragUpdate(details) {
    if (!varTouchInitSuc) return null;
    double curDragDy = details.globalPosition.dy;
    // 确定当前是前进或者后退
    int cdy = curDragDy.toInt();
    int pdy = updatePrevDy!.toInt();
    bool isBefore = cdy < pdy;
    // + -, 不满足, 上下滑动合法滑动值，> 3
    if (isBefore && pdy - cdy < 3 || !isBefore && cdy - pdy < 3) return null;
    // 区间
    double dragRange =
        isBefore ? updateDragVarVal! + 0.03 : updateDragVarVal! - 0.03;
    // 是否溢出
    if (dragRange > 1) {
      dragRange = 1.0;
    }
    if (dragRange < 0) {
      dragRange = 0.0;
    }
    setState(() {
      updatePrevDy = curDragDy;
      varTouchInitSuc = true;
      updateDragVarVal = dragRange;
      // 音量
      if (!isDragVerLeft!) {
        FijkVolume.setVol(dragRange);
      } else {
        FijkPlugin.setScreenBrightness(dragRange);
      }
    });
  }

  _onVerticalDragEnd(details) {
    setState(() {
      varTouchInitSuc = false;
    });
  }

  void _playOrPause() {
    if (_playing == true) {
      player.pause();
    } else {
      player.start();
    }
  }

  /// 手势点击时触发
  void _cancelAndRestartTimer() {
    if (_hideStuff == true) {
      _startHideTimer();
    }
    //修改状态
    _hideStuff = !_hideStuff;
    if (_hideStuff == true) {
      _hideSpeedStu = true;
    }
    //控制状态栏
   // _showStatusBar(!_hideStuff, fullScreen: widget.player.value.fullScreen);
    setState(() {});
  }

  /// 隐藏
  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 5), () {
      //控制状态栏
      // if (!_hideStuff) {
      //   _showStatusBar(false, fullScreen: widget.player.value.fullScreen);
      // }
      setState(() {
        _hideStuff = true;
        _hideSpeedStu = true;
      });
    });
  }

  // 底部控制栏 - 播放按钮
  Widget _buildPlayStateBtn(IconData iconData, Function cb) {
    return Ink(
      child: InkWell(
        onTap: () => cb(),
        child: SizedBox(
          height: 30,
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // 控制器ui 底部
  Widget _buildBottomBar(BuildContext context) {
    // 计算进度时间
    double duration = _duration.inMilliseconds.toDouble();
    double currentValue = _seekPos > 0
        ? _seekPos
        : (_isHorizontalMove
            ? _dragPos.inMilliseconds.toDouble()
            : _currentPos.inMilliseconds.toDouble());
    currentValue = min(currentValue, duration);
    currentValue = max(currentValue, 0);

    // 计算底部吸底进度
    double curConWidth = MediaQuery.of(context).size.width;
    double curTimePro = (currentValue / duration) * 100;
    double curBottomProW = (curConWidth / 100) * curTimePro;

    return SizedBox(
      height: barHeight,
      child: Stack(
        children: [
          // 底部UI控制器
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedOpacity(
              opacity: _hideStuff ? 0.0 : 0.8,
              duration: const Duration(milliseconds: 400),
              child: Container(
                height: barHeight,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromRGBO(0, 0, 0, 0),
                      Color.fromRGBO(0, 0, 0, 0.4),
                    ],
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 7),
                    // 按钮 - 播放/暂停
                    _buildPlayStateBtn(
                      _playing ? Icons.pause : Icons.play_arrow,
                      _playOrPause,
                    ),
                    // 已播放时间
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0, left: 5),
                      child: Text(
                        _duration2String(_currentPos),
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // 播放进度 if 没有开始播放 占满，空ui， else fijkSlider widget
                    _duration.inMilliseconds == 0
                        ? Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5, left: 5),
                              child: NewFijkSlider(
                                colors: const NewFijkSliderColors(
                                  cursorColor: Colors.blue,
                                  playedColor: Colors.blue,
                                ),
                                onChangeEnd: (double value) {},
                                value: 0,
                                onChanged: (double value) {},
                              ),
                            ),
                          )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5, left: 5),
                              child: NewFijkSlider(
                                colors: const NewFijkSliderColors(
                                  cursorColor: Colors.blue,
                                  playedColor: Colors.blue,
                                ),
                                value: currentValue,
                                cacheValue:
                                    _bufferPos.inMilliseconds.toDouble(),
                                min: 0.0,
                                max: duration,
                                onChanged: (v) {
                                  _startHideTimer();
                                  setState(() {
                                    _seekPos = v;
                                  });
                                },
                                onChangeEnd: (v) {
                                  setState(() {
                                    player.seekTo(v.toInt());
                                    print("seek to $v");
                                    _currentPos = Duration(
                                        milliseconds: _seekPos.toInt());
                                    _seekPos = -1;
                                  });
                                },
                              ),
                            ),
                          ),

                    // 总播放时间
                    _duration.inMilliseconds == 0
                        ? Container(
                            child: const Text(
                              "00:00",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(right: 5.0, left: 5),
                            child: Text(
                              _duration2String(_duration),
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            ),
                          ),

                    // 倍数按钮
                    widget.player.value.fullScreen && showConfig.speedBtn
                        ? Ink(
                            padding: const EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _hideSpeedStu = !_hideSpeedStu;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 40,
                                height: 30,
                                child: Text(
                                  _speed.toString() + " X",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    // 按钮 - 全屏/退出全屏
                    _buildPlayStateBtn(
                      widget.player.value.fullScreen
                          ? Icons.fullscreen_exit
                          : Icons.fullscreen,
                      () {
                        if (widget.player.value.fullScreen) {
                          player.exitFullScreen();
                        } else {
                          player.enterFullScreen();
                        }
                      },
                    ),
                    const SizedBox(width: 7),
                    //
                  ],
                ),
              ),
            ),
          ),
          // 隐藏进度条，ui隐藏时出现
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: showConfig.bottomPro &&
                    _hideStuff &&
                    _duration.inMilliseconds != 0
                ? Container(
                    alignment: Alignment.bottomLeft,
                    height: 4,
                    color: Colors.white70,
                    child: Container(
                      color: Colors.blue,
                      width: curBottomProW is double ? curBottomProW : 0,
                      height: 4,
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  // 返回按钮
  Widget _buildTopBackBtn() {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      color: Colors.white,
      onPressed: () {
        // 判断当前是否全屏，如果全屏，退出
        if (widget.player.value.fullScreen) {
          player.exitFullScreen();
        } else {
          if (widget.pageContext == null) return null;
          player.stop();
          Navigator.pop(widget.pageContext!);
        }
      },
    );
  }

  // 播放器顶部 返回 + 标题
  Widget _buildTopBar() {
    return AnimatedOpacity(
      opacity: _hideStuff ? 0.0 : 0.8,
      duration: const Duration(milliseconds: 400),
      child: Container(
        height: showConfig.stateAuto && !widget.player.value.fullScreen
            ? barFillingHeight
            : barHeight,
        alignment: Alignment.bottomLeft,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(0, 0, 0, 0.5),
              Color.fromRGBO(0, 0, 0, 0),
            ],
          ),
        ),
        child: SizedBox(
          height: barHeight,
          child: Row(
            children: <Widget>[
              _buildTopBackBtn(),
              Expanded(
                child: Container(
                  child: Text(
                    widget.playerTitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 居中播放按钮
  Widget _buildCenterPlayBtn() {
    return Container(
      color: Colors.transparent,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: (_prepared && !_buffering)
            ? AnimatedOpacity(
                opacity: _hideStuff ? 0.0 : 0.7,
                duration: const Duration(milliseconds: 400),
                child: IconButton(
                  iconSize: barHeight * 1.2,
                  icon: Icon(_playing ? Icons.pause : Icons.play_arrow,
                      color: Colors.white),
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  onPressed: _playOrPause,
                ),
              )
            : const SizedBox(
                width: barHeight * 0.8,
                height: barHeight * 0.8,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
      ),
    );
  }

  // build 滑动进度时间显示
  Widget _buildDargProgressTime() {
    return _isTouch
        ? Container(
            height: 40,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              color: Color.fromRGBO(0, 0, 0, 0.8),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                '${_duration2String(_dragPos)} / ${_duration2String(_duration)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          )
        : Container();
  }

  // build 显示垂直亮度，音量
  Widget _buildDargVolumeAndBrightness() {
    // 不显示
    if (!varTouchInitSuc) return Container();

    IconData iconData;
    // 判断当前值范围，显示的图标
    if (updateDragVarVal! <= 0) {
      iconData = !isDragVerLeft! ? Icons.volume_mute : Icons.brightness_low;
    } else if (updateDragVarVal! < 0.5) {
      iconData = !isDragVerLeft! ? Icons.volume_down : Icons.brightness_medium;
    } else {
      iconData = !isDragVerLeft! ? Icons.volume_up : Icons.brightness_high;
    }
    // 显示，亮度 || 音量
    return Card(
      color: Color.fromRGBO(0, 0, 0, 0.8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              iconData,
              color: Colors.white,
            ),
            Container(
              width: 100,
              height: 3,
              margin: EdgeInsets.only(left: 8),
              child: LinearProgressIndicator(
                value: updateDragVarVal,
                backgroundColor: Colors.white54,
                valueColor: AlwaysStoppedAnimation(Colors.lightBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // build 倍数列表
  List<Widget> _buildSpeedListWidget() {
    List<Widget> columnChild = [];
    speedList.forEach((String mapKey, double speedVals) {
      columnChild.add(
        Ink(
          child: InkWell(
            onTap: () {
              if (_speed == speedVals) return null;
              setState(() {
                _speed = speed = speedVals;
                _hideSpeedStu = true;
                player.setSpeed(speedVals);
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: 50,
              height: 30,
              child: Text(
                mapKey + " X",
                style: TextStyle(
                  color: _speed == speedVals ? Colors.blue : Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      );
      columnChild.add(
        Padding(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Container(
            width: 50,
            height: 1,
            color: Colors.white54,
          ),
        ),
      );
    });
    columnChild.removeAt(columnChild.length - 1);
    return columnChild;
  }

  /// 播放器控制器 ui
  Widget _buildGestureDetector() {
    return GestureDetector(
      onTap: _cancelAndRestartTimer,
      behavior: HitTestBehavior.opaque,
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      onVerticalDragStart: _onVerticalDragStart,
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      //AbsorbPointer 禁止用户输入事件
      child: AbsorbPointer(
        absorbing: _hideStuff,
        child: Column(
          children: <Widget>[
            // 播放器顶部控制器
            showConfig.topBar
                ? _buildTopBar()
                : Container(
                    height:
                        showConfig.stateAuto && !widget.player.value.fullScreen
                            ? barFillingHeight
                            : barHeight,
                  ),
            // 中间按钮
            Expanded(
              child: Stack(
                children: <Widget>[
                  // 顶部显示
                  Positioned(
                    top: widget.player.value.fullScreen ? 20 : 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 显示左右滑动快进时间的块
                        _buildDargProgressTime(),
                        // 显示上下滑动音量亮度
                        _buildDargVolumeAndBrightness()
                      ],
                    ),
                  ),
                  // 中间按钮
                  Align(
                    alignment: Alignment.center,
                    child: _buildCenterPlayBtn(),
                  ),
                  // 倍数选择
                  Positioned(
                    right: 35,
                    bottom: 0,
                    child: !_hideSpeedStu
                        ? Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: _buildSpeedListWidget(),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )
                        : Container(),
                  ),
                  // 锁按钮
                  showConfig.lockBtn && widget.player.value.fullScreen
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: AnimatedOpacity(
                            opacity: _hideStuff ? 0.0 : 0.7,
                            duration: const Duration(milliseconds: 400),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: IconButton(
                                iconSize: 30,
                                onPressed: () {
                                  // 更改 ui显示状态
                                  widget.changeLockState(true);
                                },
                                icon: const Icon(Icons.lock_outline),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            // 播放器底部控制器
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildGestureDetector();
  }
}

/// 显示隐藏状态栏
void _showStatusBar(bool isShow, {bool fullScreen = false}) {
  if (fullScreen) {
    // 全屏是不设置
    return;
  }
  if (isShow) {
    //状态栏显示白色文字图标
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  } else {
    //隐藏状态栏，保留底部按钮栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]); //隐藏状态栏，保留底部按钮栏
  }
}
