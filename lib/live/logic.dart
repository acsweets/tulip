// import 'dart:async';
//
// import 'package:cses_saas/cses_saas.dart';
//
// class PreviewLiveLogic extends BaseLogic {
//   RtcEngine? rtcEngine;
//   var isFrontCamera = true.obs;
//
//   RoomBean? roomBean;
//
//   PreviewLiveLogic() {
//     roomBean = Get.arguments[Keys.BEAN];
//     initEngine();
//   }
//
//   Future initEngine() async {
//     initTime();
//
//     /// 创建 RtcEngine 实例（指定访问区域）
//     rtcEngine = createAgoraRtcEngine();
//
//     await rtcEngine!.initialize(const RtcEngineContext(appId: "3ab1168dd9bd4ce1b71fa6672be62be9"));
//
//     /// 启用视频模块
//     await rtcEngine!.enableVideo();
//
//     /// 开启视频预览
//     await rtcEngine!.startPreview();
//   }
//
//   var isOpenMic = true.obs;
//
//   void onSwitchCamera() {
//     /// 切换前置/后置摄像头
//     rtcEngine?.switchCamera().then((value) {
//       isFrontCamera.value = !isFrontCamera.value;
//     });
//   }
//
//   int _totalSeconds = 0;
//
//   void initTime() {
//     if (roomBean!.startTime <= DateTime.now().millisecondsSinceEpoch) {
//       isTimeOver.value = true;
//
//       /// 超时
//       _totalSeconds = DateTime.now().millisecondsSinceEpoch - roomBean!.startTime;
//     } else {
//       isTimeOver.value = false;
//       _totalSeconds = roomBean!.startTime - DateTime.now().millisecondsSinceEpoch;
//     }
//
//     surplusSeconds.value = _totalSeconds;
//     countdown();
//   }
//
//   Timer? _timer;
//
//   var surplusSeconds = 0.obs;
//
//   var isTimeOver = false.obs;
//
//   void countdown() {
//     if (_timer != null) {
//       _timer!.cancel();
//       _timer = null;
//     }
//     surplusSeconds.value = _totalSeconds;
//     _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
//       if (surplusSeconds.value < 100) {
//         _timer?.cancel();
//         _timer = null;
//         surplusSeconds.value = 0;
//         Future.delayed(const Duration(seconds: 1), initTime);
//       } else {
//         if (isTimeOver.value)
//           surplusSeconds.value += 100;
//         else
//           surplusSeconds.value -= 100;
//       }
//     });
//   }
//
//   /// 删除直播
//   Future deleteLive() async {
//     showLoading();
//     BaseBean result = await LiveRepository.removeRoom(roomBean?.id);
//     hiddenLoading();
//
//     if (result.isSuccess) {
//       eventBus.fire(DeleteLiveEvent(roomBean?.id));
//       Get.back(result: true);
//     } else
//       showToast(text: '${result.message}');
//   }
//
//   Future start() async {
//     /// 目前 Agora Flutter SDK 只支持每个 app 创建一个 RtcEngine 实例。所以进入下一个页面前要销毁这个实例，然后再下一个页面重新创建实例
//     await release();
//     NavigatorUtil.goLivePage(roomBean?.id, isOpenMic: isOpenMic.value, replace: true);
//   }
//
//   bool isRelease = false;
//
//   Future release() async {
//     if (!isRelease) {
//       isRelease = true;
//       await rtcEngine?.stopPreview();
//       await rtcEngine?.release();
//     }
//   }
//
//   @override
//   void onClose() {
//     release();
//     if (_timer != null) {
//       _timer!.cancel();
//       _timer = null;
//     }
//     super.onClose();
//   }
// }
