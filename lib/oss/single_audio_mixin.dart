// import 'package:cses_saas/cses_saas.dart';
// import 'package:flutter/material.dart';
//
// mixin SingleAudioWavePlayerMixin on GetxController {
//   AnimationController? waveController;
//
//   AudioPlayer? _audioPlayer;
//
//   var curState = PlayerState.stopped.obs;
//
//   void initAudioPlayer(TickerProvider vsync) {
//     _audioPlayer = AudioPlayer()
//       ..onDurationChanged.listen((Duration duration) {
//         if (waveController == null && duration.inMilliseconds > 0) {
//           waveController = AnimationController(duration: Duration(milliseconds: duration.inMilliseconds), vsync: vsync)
//             ..addListener(update)
//             ..forward();
//         }
//       })
//       ..onPlayerStateChanged.listen((PlayerState state) {
//         curState.value = state;
//       })
//       ..onPlayerComplete.listen((event) {
//         waveController?.reset();
//       });
//   }
//
//   void toggle(String url, {bool isLocal = false}) {
//     Log.d("播放音频路径----------------------------------------->$url");
//     if (curState.value == PlayerState.stopped || curState.value == PlayerState.completed) {
//       play(url, isLocal: isLocal);
//     } else if (curState.value == PlayerState.playing) {
//       pause();
//     } else if (curState.value == PlayerState.paused) {
//       resume();
//     }
//   }
//
//   /// 播放
//   void play(String url, {bool isLocal = false}) async {
//     if (curState.value == PlayerState.playing) stop();
//
//     await _audioPlayer?.play(isLocal ? DeviceFileSource(url) : UrlSource(url)).then((value) {
//       Log.d("开始播放");
//       if (waveController?.status != AnimationStatus.forward) waveController?.forward(from: 0);
//     });
//   }
//
//   void pause() async {
//     await _audioPlayer?.pause().then((value) {
//       Log.d("暂停播放");
//       waveController?.stop();
//     });
//   }
//
//   void resume() async {
//     await _audioPlayer?.resume().then((value) {
//       Log.d("继续播放");
//       waveController?.forward();
//     });
//   }
//
//   Future stop() async {
//     await _audioPlayer?.stop().then((value) {
//       Log.d("停止播放");
//       waveController?.reset();
//     });
//   }
//
//   RxList<int> waveData = RxList<int>([]);
//
//   void initWaveData(String? audioUri) async {
//     if (audioUri != null)
//       FileUtil.fileToUint8List(Context().audioUrl(audioUri)).then((value) {
//         waveData.value = value;
//         Future.delayed(const Duration(milliseconds: 200), () {
//           waveData.refresh();
//         });
//       });
//   }
//
//   bool _isDispose = false;
//
//   @override
//   void onClose() {
//     if (!_isDispose) {
//       _isDispose = true;
//       _audioPlayer?.dispose();
//       waveController?.dispose();
//       waveController = null;
//     }
//
//     super.onClose();
//   }
// }



// BaseNewLogic({bool isInitAudioPlayer = false, bool isSquare = false, bool isClip = true}) {
//   handler = ResourcePickerHandler(
//       isClip: isClip,
//       singleListener: this,
//       videoListener: this,
//       isSquare: isSquare,
//       audioListener: this,
//       attachmentListener: this);