// import 'dart:ui';
//
// import 'package:cses_saas/cses_saas.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// /// 主播预览页面
// class PreviewLivePage extends StatelessWidget {
//   const PreviewLivePage({super.key});
//
//   PreviewLiveLogic get logic => Get.find<PreviewLiveLogic>();
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () async {
//           if (logic.roomBean?.status == LiveStatusType.appointment ||
//               logic.roomBean!.startTime > DateTime.now().millisecondsSinceEpoch) {
//             eventBus
//                 .fire(UpdateLiveListPage(categoryType: logic.roomBean?.categoryType, type: logic.roomBean?.scopeType));
//             return true;
//           } else {
//             showCustomDialog(
//                 context: context,
//                 builder: (_) {
//                   return CustomAlertDialog(title: "提示", content: "开播时间已到，您确定要放弃开播并退出吗？", onConfirm: logic.deleteLive);
//                 });
//             return false;
//           }
//         },
//         child: AnnotatedRegion<SystemUiOverlayStyle>(
//             value: SystemUiOverlayStyle.light,
//             child: Scaffold(
//                 resizeToAvoidBottomInset: false,
//                 body: BaseWidget<PreviewLiveLogic>(
//                     logic: logic,
//                     builder: (PreviewLiveLogic logic) {
//                       return Stack(children: [
//                         logic.rtcEngine == null
//                             ? const SizedBox.expand()
//                             : AgoraVideoView(
//                             controller:
//                             VideoViewController(rtcEngine: logic.rtcEngine!, canvas: const VideoCanvas(uid: 0)),
//                             onAgoraVideoViewCreated: (viewId) {
//                               logic.rtcEngine!.startPreview();
//                             }),
//                         SizedBox(
//                             height: DeviceUtils.navigationBarHeight,
//                             child: AppBar(
//                                 backgroundColor: Colors.transparent,
//                                 title: Row(mainAxisSize: MainAxisSize.min, children: [
//                                   Text(logic.isTimeOver.value ? '开播超时 : ' : "开播倒计时 : "),
//                                   Container(
//                                       constraints: BoxConstraints(minWidth: 25.w),
//                                       padding: EdgeInsets.symmetric(horizontal: 2.w),
//                                       height: 25.w,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(2.r), color: ColorUtil.color_333333),
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                           periodToString(logic.surplusSeconds.value)[1].toString().padLeft(2, "0"),
//                                           style: TextStyle(color: Colors.white, fontSize: 10.sp))),
//                                   Text(" : ",
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyMedium!
//                                           .copyWith(fontSize: 13.sp, fontWeight: FontWeight.w700)),
//                                   Container(
//                                       width: 25.w,
//                                       height: 25.w,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(2.r), color: ColorUtil.color_333333),
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                           periodToString(logic.surplusSeconds.value)[2].toString().padLeft(2, "0"),
//                                           style: TextStyle(color: Colors.white, fontSize: 10.sp))),
//                                   Text(" : ",
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyMedium!
//                                           .copyWith(fontSize: 13.sp, fontWeight: FontWeight.w700)),
//                                   Container(
//                                       width: 25.w,
//                                       height: 25.w,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(2.r), color: ColorUtil.color_333333),
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                           periodToString(logic.surplusSeconds.value)[3].toString().padLeft(2, "0"),
//                                           style: TextStyle(color: Colors.white, fontSize: 13.sp)))
//                                 ]),
//                                 actions: [
//                                   Center(
//                                       child: TextButton(
//                                           style: ButtonStyle(
//                                               backgroundColor: MaterialStateProperty.all(Colors.redAccent.shade200)),
//                                           onPressed: () {
//                                             if (logic.roomBean == null) {
//                                               Get.back();
//                                             } else {
//                                               if (logic.roomBean!.status != LiveStatusType.appointment) {
//                                                 if (logic.roomBean!.startTime >=
//                                                     DateTime.now().millisecondsSinceEpoch) {
//                                                   eventBus.fire(UpdateLiveListPage(
//                                                       categoryType: logic.roomBean!.categoryType,
//                                                       type: logic.roomBean!.scopeType));
//                                                   Get.back();
//                                                 } else {
//                                                   showCustomDialog(
//                                                       context: context,
//                                                       builder: (_) {
//                                                         return CustomAlertDialog(
//                                                             title: "提示",
//                                                             content: "开播时间已到，您确定要放弃开播并退出吗？",
//                                                             onConfirm: logic.deleteLive);
//                                                       });
//                                                 }
//                                               } else {
//                                                 eventBus.fire(UpdateLiveListPage(
//                                                     categoryType: logic.roomBean!.categoryType,
//                                                     type: logic.roomBean!.scopeType));
//                                                 Get.back();
//                                               }
//                                             }
//                                           },
//                                           child: const Text('退出', style: TextStyle(color: Colors.white)))),
//                                   SizedBox(width: 10.w)
//                                 ],
//                                 centerTitle: false,
//                                 automaticallyImplyLeading: false)),
//                         Positioned(
//                             bottom: 10.w,
//                             right: 15.w,
//                             left: 15.w,
//                             child: SafeArea(
//                                 top: false,
//                                 child: Column(children: [
//                                   buildItemView(context),
//                                   SizedBox(height: 20.r),
//                                   RadiusInkWellWidget(
//                                       color: Colors.redAccent,
//                                       radius: 25,
//                                       onPressed: logic.start,
//                                       child: Container(
//                                           alignment: Alignment.center,
//                                           height: 50,
//                                           child: Text('开始直播', style: TextStyle(color: Colors.white, fontSize: 18.sp))))
//                                 ])))
//                       ]);
//                     }))));
//   }
//
//   Widget buildItemView(BuildContext context) {
//     return ClipRRect(
//         borderRadius: BorderRadius.circular(16.r),
//         child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 11.0),
//             child: Container(
//                 padding: EdgeInsets.only(top: 12.r, bottom: 12.r, left: 20.w, right: 20.w),
//                 decoration:
//                 BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: Colors.black.withOpacity(0.4)),
//                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//                   BottomIconView(
//                       title: "麦克风",
//                       onPressed: logic.isOpenMic.toggle,
//                       icon: logic.isOpenMic.value ? IconFont.openMic : IconFont.closeMic,
//                       iconColor: logic.isOpenMic.value ? Colors.greenAccent : Colors.redAccent),
//                   BottomIconView(
//                       title: "分享",
//                       onPressed: logic.roomBean == null
//                           ? null
//                           : () {
//                         showShareDialog(
//                             webPageUrl: Context().shareUrl(
//                                 type: ShareType.live,
//                                 id: logic.roomBean?.id,
//                                 params: {Keys.ANCHOR_ID: logic.roomBean?.anchorId}),
//                             imgUrl: logic.roomBean?.cover?.uri,
//                             title: '${logic.roomBean?.title}',
//                             description: '');
//                       },
//                       icon: IconFont.share),
//                   BottomIconView(
//                       title: "问题预设",
//                       onPressed: () {
//                         Get.toNamed(LiveRoutePath.live_questions);
//                       },
//                       icon: IconFont.problemPreset),
//                   BottomIconView(
//                       title: "感悟主题",
//                       onPressed: () {
//                         Get.toNamed(LiveRoutePath.live_thinking_theme, arguments: {Keys.roomId: logic.roomBean?.id});
//                       },
//                       icon: IconFont.thinking_theme)
//                 ]))));
//   }
// }
