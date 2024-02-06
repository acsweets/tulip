// import 'dart:async';
//
// import 'package:cses_saas/cses_saas.dart';
//
// class LivingLogic extends AgoraStreamingLogic with SocketMixin, LiveBarrageAndDingMixin, LiveAnchorMixin {
//   String? roomId;
//   String? anchorId;
//   Rx<RoomBean?> room = Rx<RoomBean?>(null);
//   late Certificate certificate;
//
//   Rx<RemoteUserEntry?> anchor = Rx<RemoteUserEntry?>(null);
//
//   Rx<String?> fullscreenUserId = Rx<String?>(null);
//
//   var onlineCount = 1.obs;
//
//   LivingLogic() {
//     Log.d("${Get.arguments[Keys.roomId]}---------------------------${Get.arguments[Keys.ANCHOR_ID]}");
//
//     room.value = Get.arguments[Keys.BEAN];
//     roomId = Get.arguments[Keys.roomId];
//     anchorId = Get.arguments[Keys.ANCHOR_ID];
//     certificate = Get.arguments[Keys.CERTIFICATE];
//     Log.d("===============>${certificate.toJson()}");
//     uid = certificate.uid;
//     currentUser.value.uid = uid;
//
//     initSocketClient(SocketChannelName.live, roomId, onReconnect: () {
//       subscribe();
//     }, params: {Keys.LIVE_ID: roomId});
//
//     /// 处理socket消息
//     socketEvent = eventBus.on<SocketEvent>().listen((event) {
//       if (event.data![Keys.LIVE_ID] != roomId) return;
//       switch (event.action) {
//         case ActionNames.subscribe:
//           if (User().userId == anchorId) {
//             startLive();
//           } else {
//             joinLive();
//           }
//           break;
//         case ActionNames.start: // 开启直播
//           startLiveAction(event.data!);
//           break;
//         case ActionNames.join: // 进入直播
//           joinLiveAction(event.data!);
//           break;
//         case ActionNames.quit: // 退出直播
//           quitLiveAction(event.data!);
//           break;
//         case ActionNames.end: // 结束直播
//           endAction(event.data!);
//           break;
//         case ActionNames.turnCamera: // 开关摄像头
//           turnCameraAction(event.data!);
//           break;
//         case ActionNames.turnMicrophone: // 开关麦克风
//           turnMicrophoneAction(event.data!);
//           break;
//         case ActionNames.muteAudience: // 禁言
//         // TODO
//           break;
//         case ActionNames.like: // 点赞
//           likeAction(event.data!);
//           break;
//         case ActionNames.applyLink: // 申请连麦
//           applyLinkAction(event.data!, anchorId);
//           break;
//         case ActionNames.acceptLink: // 接受连麦
//           acceptLinkAction(event.data!);
//           break;
//         case ActionNames.closeLink: // 关闭连麦
//           closeLinkAction(event.data!);
//           break;
//         case ActionNames.closeAllLink:
//           closeAllLinkAction(event.data!);
//           break;
//         case ActionNames.fullscreen: // 上台
//           fullscreenAction(event.data!);
//           break;
//         case ActionNames.inviteLink: // 邀请连麦
//           inviteLinkAction(event.data!);
//           break;
//         case ActionNames.acceptInviteLink: // 同意邀请连麦
//           acceptInviteLinkAction(event.data!);
//           break;
//         case ActionNames.refuseInviteLink: // 拒绝邀请连麦
//           if (User().userId == anchorId) showToast(text: "${event.data![Keys.USER_NAME]}拒绝了您的连麦邀请");
//           break;
//         case ActionNames.message: // 弹幕
//           messageAction(event.data!);
//           break;
//         case ActionNames.pin: // 钉问题
//           pinAction(event.data!);
//           break;
//         case ActionNames.unPin: // 取消钉问题
//           unpinAction(event.data!);
//           break;
//         case ActionNames.askQuestion: // 提问
//           askQuestionAction(event.data!, anchorId);
//           break;
//         case ActionNames.answerQuestion: // 回答问题
//           answerQuestionAction(event.data!);
//           break;
//         case ActionNames.startThinking: // 发布感悟
//           sendThinkingThemeAction(event.data!, anchorId);
//           break;
//         case ActionNames.thinking: //
//           submitThinkingAction(event.data!);
//           break;
//         default:
//           break;
//       }
//     });
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     if (room.value!.status != LiveStatusType.closed) {
//       initEngine(
//           cameraState: User().userId == anchorId,
//           microphoneState: User().userId == anchorId && Get.arguments[Keys.IS_OPEN_MICROPHONE],
//           isSilent: false,
//           appId: certificate.appId)
//           .then((value) {
//         joinChannel(
//             token: certificate.token,
//             channel: certificate.channel,
//             uid: uid,
//             roleType:
//             User().userId == anchorId ? ClientRoleType.clientRoleBroadcaster : ClientRoleType.clientRoleAudience);
//       });
//     }
//   }
//
//   @override
//   void onReady() {
//     WakelockPlus.enable();
//     super.onReady();
//   }
//
//   Future joinLive() async {
//     showLoading();
//     LiveJoinResult result = await LiveRepository.joinRoom(roomId);
//     hiddenLoading();
//     if (result.isSuccess) {
//       for (var linkUser in result.links) {
//         if (remoteUserList.every((remoteUser) => remoteUser.userId != linkUser.userId) && linkUser.uid > 0)
//           remoteUserList.add(linkUser);
//       }
//       remoteUserList.refresh();
//       if (remoteUserList.isEmpty) fullscreenUserId.value = null;
//       anchor.value = result.anchor;
//       anchor.refresh();
//     } else {
//       showToast(text: "${result.error}");
//     }
//   }
//
//   // {"liveId":"65a62b8b6fc2674721de0f35","content":"樊祥甫进入了直播间。","userId":"64b66a105965132667458710","userName":"樊祥甫","joinTime":1705389720113,"onlineCount":2,"duration":86484,"questionCount":1,"pinMessage":{"liveId":"65a62b8b6fc2674721de0f35","object":{"id":"65a62e166fc2674721de374f","content":"杭州的记得记得的角度讲","userId":"64b66a105965132667458710","userName":"樊祥甫"}}}
//   void joinLiveAction(Map<String, dynamic> data) {
//     if (anchorId != data[Keys.USER_ID] && User().userId != data[Keys.USER_ID])
//       addJoinLive(data[Keys.USER_ID], data[Keys.USER_NAME]);
//
//     fullscreenUserId.value == data[Keys.FULL_SCREEN_USER_ID];
//     onlineCount.value = data[Keys.ONLINE_COUNT];
//     if (data[Keys.QUESTION_COUNT] != null) questionCount.value = data[Keys.QUESTION_COUNT];
//     if (data[Keys.PIN_MESSAGE] != null) pinObject.value = LivePinBean.fromJson(data[Keys.PIN_MESSAGE]);
//   }
//
//   /// 开启直播
//   Future startLive() async {
//     showLoading();
//     BaseBean result = await LiveRepository.startLive(roomId, {
//       Keys.UID: uid,
//       Keys.USER_ID: User().userId,
//       Keys.USER_NAME: User().userName,
//       Keys.IS_OPEN_CAMERA: true,
//       Keys.IS_OPEN_MICROPHONE: true
//     });
//     hiddenLoading();
//     if (result.isSuccess) {
//       showToast(text: "直播已开启");
//       room.value!.status = LiveStatusType.running;
//       room.value!.startTime = DateTime.now().millisecondsSinceEpoch;
//       room.refresh();
//     } else {
//       showToast(text: "${result.message}");
//     }
//   }
//
//   /// 直播开启 {"liveId":"659ceccbb752fb4bb0e67d9d","content":"樊祥甫开启了直播。","startTime":1704783177479,"anchor":{"userId":"64b66a105965132667458710","userName":"樊祥甫","uid":10000,"isOpenMicrophone":true,"isOpenCamera":true}}
//   void startLiveAction(Map<String, dynamic> data) {
//     room.value!.status = LiveStatusType.running;
//     room.value!.startTime = DateTime.now().millisecondsSinceEpoch;
//     room.refresh();
//
//     anchor.value = RemoteUserEntry.fromJson(data[Keys.ANCHOR]);
//     anchor.refresh();
//   }
//
//   /// 申请连麦
//   Future applyLink() async {
//     showLoading();
//     BaseBean result = await LiveRepository.applyLink(roomId);
//     hiddenLoading();
//
//     if (result.isSuccess) {
//       showToast(text: "申请已发出");
//     } else {
//       showToast(text: "${result.message}");
//     }
//   }
//
//   Future acceptLink(String? userId, String? userName, int uid) async {
//     showLoading();
//     BaseBean result = await LiveRepository.acceptLink(roomId, userId, userName);
//     hiddenLoading();
//     if (result.isSuccess) {
//       if (applyAudienceList.every((element) => element.userId != userId)) {
//         RemoteUserEntry user = RemoteUserEntry(uid: uid, userId: userId, userName: userName);
//         applyAudienceList.add(user);
//         applyAudienceList.refresh();
//       }
//     } else {
//       showToast(text: "${result.message}");
//     }
//   }
//
//   /// {"liveId":"659bd5fd20fd2b018a229089","content":"樊祥甫同意了师春雷的连麦申请","userId":"6008f761453b4e60700f01e2","userName":"师春雷","uid":10011}
//   void acceptLinkAction(Map<String, dynamic> data) async {
//     if (remoteUserList.every((element) => element.userId != data[Keys.USER_ID])) {
//       RemoteUserEntry audience = RemoteUserEntry(
//           userName: data[Keys.USER_NAME],
//           userId: data[Keys.USER_ID],
//           isOpenCamera: false,
//           isOpenMicrophone: false,
//           uid: data[Keys.UID]);
//
//       remoteUserList.add(audience);
//       remoteUserList.refresh();
//     }
//
//     if (User().userId == data[Keys.USER_ID]) await setClientRole(ClientRoleType.clientRoleBroadcaster);
//   }
//
//   // 有人更新摄像头状态 {"liveId":"6597e3f24a10dd52f1c1743d","content":"师春雷打开了摄像头。","userId":"6008f761453b4e60700f01e2","userName":"师春雷","lastModified":1704459169091,"isOpenCamera":true}
//   void turnCameraAction(Map<String, dynamic> data) {
//     for (var element in remoteUserList) {
//       if (element.userId == data[Keys.USER_ID]) element.isOpenCamera = data[Keys.IS_OPEN_CAMERA] ?? false;
//     }
//     remoteUserList.refresh();
//   }
//
//   // 有人更新麦克风状态 {"liveId":"6597e3f24a10dd52f1c1743d","content":"师春雷打开了麦克风。","userId":"6008f761453b4e60700f01e2","userName":"师春雷","lastModified":1704458984623,"isOpenMicrophone":true}
//   void turnMicrophoneAction(Map<String, dynamic> data) {
//     for (var element in remoteUserList) {
//       if (element.userId == data[Keys.USER_ID]) element.isOpenMicrophone = data[Keys.IS_OPEN_MICROPHONE] ?? false;
//     }
//     remoteUserList.refresh();
//   }
//
//   /// 主播邀请用户连麦
//   void inviteLinkAction(Map<String, dynamic> data) {
//     // 弹出同意/拒绝连麦的弹窗
//     if (User().userId == data[Keys.USER_ID])
//       Get.bottomSheet(AudienceJoinLinkRequestDialog(liveId: roomId), isScrollControlled: true);
//   }
//
//   /// 用户同意主播邀请连麦
//   void acceptInviteLinkAction(Map<String, dynamic> data) async {
//     RemoteUserEntry user =
//     RemoteUserEntry(uid: data[Keys.UID], userId: data[Keys.USER_ID], userName: data[Keys.USER_NAME]);
//     if (remoteUserList.every((element) => element.userId != user.userId)) {
//       remoteUserList.add(user);
//       remoteUserList.refresh();
//     }
//
//     if (User().userId == data[Keys.USER_ID]) await setClientRole(ClientRoleType.clientRoleBroadcaster);
//
//     if (User().userId == anchorId) {
//       if (applyAudienceList.every((element) => element.userId != data[Keys.USER_ID])) {
//         applyAudienceList.add(user);
//         applyAudienceList.refresh();
//       }
//     }
//   }
//
//   /// 听众断开与主播的连麦
//   Future audienceCloseLink() async {
//     showLoading();
//
//     /// 如果自己正在全屏，首先退出全屏
//     if (fullscreenUserId.value == User().userId) await fullscreen(roomId, User().userId, User().userName, false);
//     BaseBean result = await LiveRepository.audienceCloseLink(roomId);
//     hiddenLoading();
//     if (result.isSuccess) {
//       setClientRole(ClientRoleType.clientRoleAudience);
//       remoteUserList.removeWhere((element) => element.userId == User().userId);
//       remoteUserList.refresh();
//       if (remoteUserList.isEmpty) fullscreenUserId.value = null;
//     } else {
//       showToast(text: "${result.message}");
//     }
//   }
//
//   /// 挂断某个人的连麦 {"liveId":"659f970e9ba6ad090f79bf84","content":"王东关闭了连麦","userId":"6279411f5a073e0e55763388","userName":"王东"}
//   void closeLinkAction(Map<String, dynamic> data) {
//     remoteUserList.removeWhere((element) => element.userId == data[Keys.USER_ID]);
//     remoteUserList.refresh();
//     if (remoteUserList.isEmpty || fullscreenUserId.value == data[Keys.USER_ID]) fullscreenUserId.value = null;
//     // 当前用户为主播
//     if (User().userId == anchorId) {
//       applyAudienceList.removeWhere((element) => element.userId == data[Keys.USER_ID]);
//       applyAudienceList.refresh();
//     }
//     // 被挂断的人是当前用户
//     if (User().userId == data[Keys.USER_ID]) setClientRole(ClientRoleType.clientRoleAudience);
//   }
//
//   /// 主播断开与听众的连麦
//   Future anchorCloseLink({String? userId, String? userName}) async {
//     showLoading();
//     if (fullscreenUserId.value == userId) await fullscreen(roomId, fullscreenUserId.value, userName, false);
//     BaseBean result = await LiveRepository.anchorCloseLink(roomId, userId: userId, userName: userName);
//     hiddenLoading();
//     if (result.isSuccess) {
//       Get.back();
//     } else {
//       showToast(text: "${result.message}");
//     }
//   }
//
//   /// 主播挂断所有连麦
//   void closeAllLinkAction(Map<String, dynamic> data) {
//     fullscreenUserId.value = null;
//     if (remoteUserList.any((element) => User().userId == element.userId)) {
//       setClientRole(ClientRoleType.clientRoleAudience);
//     }
//
//     for (var remoteUser in remoteUserList) {
//       if (applyAudienceList.any((applyAudience) => remoteUser.userId == applyAudience.userId)) {
//         applyAudienceList.removeWhere((element) => remoteUser.userId == element.userId);
//       }
//     }
//
//     remoteUserList.clear();
//     remoteUserList.refresh();
//   }
//
//   /// 发送弹幕
//   void sendBarrage(String content, BarrageType barrageType) {
//     sendMessage(ActionNames.message, params: {
//       Keys.LIVE_ID: roomId,
//       Keys.USER_NAME: User().userName,
//       Keys.USER_ID: User().userId,
//       Keys.Type: barrageType.name,
//       Keys.Content: content
//     });
//   }
//
//   /// 点赞
//   void like(int count) {
//     sendMessage(ActionNames.like, params: {
//       Keys.LIVE_ID: roomId,
//       Keys.USER_NAME: User().userName,
//       Keys.USER_ID: User().userId,
//       Keys.COUNT: count
//     });
//   }
//
//   /// 听众退出直播 {"liveId":"6597a6b69167f87d9f3b4a8f","content":"樊祥甫退出了直播间。","userId":"64b66a105965132667458710","userName":"樊祥甫","playDuration":117467,"quitTime":1704437841383}
//   Future quit() async {
//     showLoading();
//     if (room.value?.status == LiveStatusType.running &&
//         remoteUserList.any((element) => element.userId == User().userId)) {
//       /// 退出直播，退出直播前要判断当前用户是否正在连线，如果正在连线要先断开连线再退出直播
//       await audienceCloseLink();
//     }
//     BaseBean result = await LiveRepository.quitRoom(roomId);
//     hiddenLoading();
//     if (result.isSuccess) {
//       if (room.value!.status == LiveStatusType.pending ||
//           room.value!.status == LiveStatusType.appointment ||
//           room.value!.isCommented) {
//         Get.back();
//       } else
//         Get.offNamed(LiveRoutePath.live_over, arguments: room.value);
//     } else {
//       showToast(text: "${result.message}");
//       Get.back();
//     }
//   }
//
//   /// 有听众退出直播 {"liveId":"659cacea8ecb5b13bd00fdba","content":"师春雷退出了直播间。","userId":"6008f761453b4e60700f01e2","userName":"师春雷","playDuration":1522588,"quitTime":1704769195347,"members":7}
//   void quitLiveAction(Map<String, dynamic> data) {
//     onlineCount.value = data[Keys.ONLINE_COUNT];
//     if (fullscreenUserId.value == data[Keys.USER_ID]) fullscreenUserId.value = null;
//     // 正在连线，则需要将该用户连线状态修改一下
//     remoteUserList.removeWhere((element) => data[Keys.USER_ID] == element.userId);
//     remoteUserList.refresh();
//
//     if (User().userId != data[Keys.USER_ID]) addQuitLive(data[Keys.USER_ID], data[Keys.USER_NAME]);
//
//     if (User().userId == anchorId) {
//       applyAudienceList.removeWhere((element) => data[Keys.USER_ID] == element.userId);
//       applyAudienceList.refresh();
//     }
//   }
//
//   /// 结束直播 {"liveId":"6593a53ee6cec77574d0b546","content":"樊祥甫关闭了直播。","userId":"64b66a105965132667458710","userName":"樊祥甫","startTime":1704255520960}
//   void endAction(Map<String, dynamic> data) {
//     if (anchorId != User().userId) {
//       room.value!.status = LiveStatusType.closed;
//       room.refresh();
//       showToast(text: "主播下播了");
//       Get.offNamed(LiveRoutePath.live_over, arguments: room.value);
//     } else {
//       eventBus.fire(UpdateLiveRoomStatusEvent(roomId, totalMembers: onlineCount.value, status: LiveStatusType.closed));
//       Get.back();
//     }
//   }
//
//   // {"liveId":"659e7ffff349545e78b78a95","userId":"6279411f5a073e0e55763388","userName":"王东","state":true}
//   void fullscreenAction(Map<String, dynamic> data) {
//     if (data[Keys.State]) {
//       fullscreenUserId.value = data[Keys.USER_ID];
//     } else {
//       fullscreenUserId.value = null;
//     }
//   }
//
//   @override
//   void onClose() {
//     WakelockPlus.disable();
//     closeSocket();
//     release();
//     super.onClose();
//   }
// }
