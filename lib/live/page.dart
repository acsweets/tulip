// import 'package:cses_saas/cses_saas.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class LivingPage extends StatelessWidget {
//   final String? tag;
//
//   const LivingPage({super.key, this.tag});
//
//   LivingLogic get logic => Get.find<LivingLogic>(tag: tag);
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () async {
//           return false;
//         },
//         child: AnnotatedRegion<SystemUiOverlayStyle>(
//             value: SystemUiOverlayStyle.light,
//             child: Scaffold(
//                 backgroundColor: Colors.black,
//                 resizeToAvoidBottomInset: false,
//                 body: Stack(children: [
//                   /// 背景
//                   LiveScreenBody(imageUri: logic.room.value?.cover?.uri),
//
//                   /// 主屏显示区域
//                   Positioned.fill(
//                       child: Obx(() => logic.room.value != null
//                           ? (logic.room.value!.status == LiveStatusType.pending ||
//                           logic.room.value!.status == LiveStatusType.appointment) &&
//                           logic.anchorId != User().userId
//                           ? WaitLiveCenterBody(bean: logic.room.value!)
//                           : logic.room.value!.status == LiveStatusType.running
//                           ? LivingView(tag: tag)
//                           : logic.room.value!.status == LiveStatusType.closed
//                           ? CloseLiveBody(
//                           userId: logic.room.value!.anchorId, userName: logic.room.value!.anchorName)
//                           : const SizedBox.shrink()
//                           : const SizedBox.shrink())),
//
//                   /// 点赞区域
//                   Obx(() => logic.room.value?.status == LiveStatusType.running && User().userId != logic.anchorId
//                       ? LikeGestureWidget(
//                       tag: tag, child: const SizedBox(width: double.infinity, height: double.infinity))
//                       : const SizedBox.shrink()),
//
//                   /// 用户申请连麦弹幕
//                   User().userId == logic.anchorId ? const ApplyLinkTipView() : const SizedBox.shrink(),
//
//                   /// 顶部
//                   Positioned(
//                       left: 0,
//                       right: 0,
//                       top: 0,
//                       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                         logic.anchorId != User().userId ? AudienceHeaderView(tag: tag) : AnchorHeaderView(tag: tag),
//                         SizedBox(height: 10.h),
//
//                         /// 钉
//                         Obx(() => logic.pinObject.value != null && logic.room.value?.status == LiveStatusType.running
//                             ? PinView(tag: tag)
//                             : const SizedBox.shrink()),
//                         Obx(() => logic.recording.value ? const RecordingView() : const SizedBox.shrink())
//                       ])),
//
//                   /// 底部
//                   Positioned(
//                       left: 0,
//                       right: 0,
//                       bottom: 0,
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             /// 弹幕
//                             BarrageBody(tag: tag),
//
//                             /// 弹幕操作
//                             logic.anchorId != User().userId
//                                 ? Obx(() {
//                               return AnimatedContainer(
//                                   margin: EdgeInsets.only(left: 15.w),
//                                   decoration: BoxDecoration(
//                                       color: Colors.black45, borderRadius: BorderRadius.circular(30.w)),
//                                   width: logic.showBarrage.value ? 150.w : 40.w,
//                                   height: 40.w,
//                                   duration: const Duration(milliseconds: 200),
//                                   child: Row(children: [
//                                     CustomIconButton(
//                                         radius: 20.w,
//                                         icon: Icon(
//                                             logic.showBarrage.value
//                                                 ? IconFont.openBarrage
//                                                 : IconFont.closeBarrage,
//                                             color: Colors.white,
//                                             size: 22.w),
//                                         onPressed: logic.showBarrage.toggle),
//                                     AnimatedContainer(
//                                         width: logic.showBarrage.value ? 110.w : 0,
//                                         duration: const Duration(milliseconds: 200),
//                                         child: GestureDetector(
//                                             onTap: () {
//                                               showDialog(
//                                                   context: context,
//                                                   builder: (_) {
//                                                     return SubmitBarrageDialog(
//                                                         onSubmit: (String content, BarrageType barrageType) {
//                                                           logic.sendBarrage(content, barrageType);
//                                                         },
//                                                         barrageType: BarrageType.barrage);
//                                                   });
//                                             },
//                                             behavior: HitTestBehavior.opaque,
//                                             child: SingleChildScrollView(
//                                                 scrollDirection: Axis.horizontal,
//                                                 child: Row(children: [
//                                                   Container(
//                                                       height: 16.w,
//                                                       margin: EdgeInsets.only(right: 10.r),
//                                                       width: 2.w,
//                                                       color: Colors.white),
//                                                   Text("说点什么...",
//                                                       style: TextStyle(color: Colors.white, fontSize: 14.sp))
//                                                 ]))))
//                                   ]));
//                             })
//                                 : const SizedBox.shrink(),
//                             SizedBox(height: 10.h),
//                             logic.anchorId == User().userId
//                                 ? AnchorBottomView(tag: tag)
//                                 : Obx(() => logic.room.value?.status == LiveStatusType.running
//                                 ? AudienceBottomView(tag: tag)
//                                 : SizedBox(height: DeviceUtils.bottomSafeHeight))
//                           ]))
//                 ]))));
//   }
// }
