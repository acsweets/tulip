// import 'package:cses_saas/cses_saas.dart';
//
// mixin LiveAnchorMixin on BaseLogic {
//   /// 录制状态
//   var recording = false.obs;
//
//   /// 开启录制
//   Future startRecord(String? roomId, String? anchorId) async {
//     showLoading();
//     BaseBean result = await LiveRepository.startRecordLive(roomId, anchorId);
//     hiddenLoading();
//     if (result.isSuccess) {
//       recording.value = true;
//     } else {
//       showToast(text: "${result.message}");
//     }
//   }
//
//   /// 结束录制
//   Future stopRecord(String? roomId) async {
//     showLoading();
//     BaseBean result = await LiveRepository.stopRecordLive(roomId);
//     hiddenLoading();
//     if (result.isSuccess) {
//       recording.value = false;
//     } else {
//       showToast(text: "${result.message}");
//     }
//   }
//
//   /// 上台
//   Future fullscreen(String? roomId, String? userId, String? userName, bool state) async {
//     showLoading();
//     BaseBean result = await LiveRepository.fullscreen(roomId, userId, userName, state);
//
//     hiddenLoading();
//     if (result.isSuccess) {
//       // showToast(text: "设置成功");
//     } else {
//       showToast(text: "${result.message}");
//     }
//   }
//
//   /// 结束直播
//   Future stopLive(String? roomId, int onlineCount) async {
//     showLoading();
//     if (recording.value) await stopRecord(roomId);
//     BaseBean result = await LiveRepository.stopLive(roomId);
//     hiddenLoading();
//     if (result.isSuccess) {
//       eventBus.fire(UpdateLiveRoomStatusEvent(roomId, totalMembers: onlineCount, status: LiveStatusType.closed));
//       Get.back();
//     } else {
//       showToast(text: "${result.message}");
//     }
//   }
//
//   /// 申请连线的人员列表
//   RxList<RemoteUserEntry> applyAudienceList = RxList<RemoteUserEntry>([]);
//
//   /// 听众申请连麦 {"liveId":"6597e3f24a10dd52f1c1743d","content":"师春雷申请连麦","userId":"6008f761453b4e60700f01e2","userName":"师春雷","applyTime":1704453626391,"uid":10011}
//   void applyLinkAction(Map<String, dynamic> data, String? anchorId) {
//     if (User().userId == anchorId) {
//       if (applyAudienceList.every((element) => element.userId != data[Keys.USER_ID])) {
//         /// todo
//         RemoteUserEntry audience = RemoteUserEntry(userId: data[Keys.USER_ID], userName: data[Keys.USER_NAME]);
//         applyAudienceList.add(audience);
//         applyAudienceList.refresh();
//       }
//
//       eventBus.fire(ApplyLinksTipEvent(RemoteUserEntry(userId: data[Keys.USER_ID], userName: data[Keys.USER_NAME])));
//     }
//   }
// }
