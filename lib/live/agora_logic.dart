// import 'package:cses_saas/cses_saas.dart';
//
// class AgoraStreamingLogic extends BaseLogic {
//   late int uid;
//
//   late final RtcEngine engine;
//   late final RtcEngineEventHandler rtcEngineEventHandler;
//
//   var localUserJoined = false.obs;
//
//   /// 远程用户
//   RxList<RemoteUserEntry> remoteUserList = RxList<RemoteUserEntry>([]);
//
//   /// 当前用户
//   Rx<RemoteUserEntry> currentUser =
//   Rx<RemoteUserEntry>(RemoteUserEntry(isOnline: false, userId: User().userId, userName: User().userName));
//
//   Future initEngine(
//       {bool cameraState = true,
//         bool microphoneState = true,
//         bool isSilent = true,
//         bool isFrontCamera = true,
//         String? appId}) async {
//     videoEnabled.value = cameraState;
//     micEnabled.value = !microphoneState;
//
//     currentUser.value.isOpenCamera = videoEnabled.value;
//     currentUser.value.isOpenMicrophone = !micEnabled.value;
//
//     engine = createAgoraRtcEngine();
//     await engine.initialize(RtcEngineContext(
//         appId: appId ?? Constants.AGORA_APP_ID,
//         channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//         logConfig: const LogConfig(level: LogLevel.logLevelNone)));
//
//     rtcEngineEventHandler = RtcEngineEventHandler(
//       onError: (ErrorCodeType err, String msg) {
//         Log.d('[onError] err: $err, msg: $msg');
//       },
//       // 成功加入频道回调
//       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//         localUserJoined.value = true;
//         Log.d('[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed 成功进入直播间');
//       },
//       // 成功重新加入频道回调
//       onRejoinChannelSuccess: (RtcConnection connection, int elapsed) {
//         Log.d('[onRejoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed 成功重新进入直播间');
//       },
//       onConnectionStateChanged:
//           (RtcConnection connection, ConnectionStateType state, ConnectionChangedReasonType reason) {
//         Log.d('[onConnectionStateChanged] connection: ${connection.toJson()} reason: $reason state: $state');
//       },
//       // 远端用户加入频道回调
//       onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
//         Log.d('[onUserJoined] connection: ${connection.toJson()} remoteUid:远端用户 $rUid 进入直播间 elapsed: $elapsed');
//       },
//       // 远端用户（通信场景）/主播（直播场景）离开当前频道回调
//       onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
//         Log.d('[onUserOffline] connection: ${connection.toJson()}  remoteUid: $remoteUid 离开直播间 reason: $reason');
//       },
//       // 用户离开频道回调
//       onLeaveChannel: (RtcConnection connection, RtcStats stats) {
//         Log.d('[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
//       },
//       // 远端用户开/关视频模块回调
//       onUserEnableVideo: (RtcConnection connection, int remoteUid, bool enabled) {
//         Log.d(
//             '[onUserEnableVideo] connection: ${connection.toJson()} remoteUid: $remoteUid stats: ${enabled ? "打开" : "关闭"}摄像头');
//         remoteUserList.refresh();
//       },
//       // 本地视频状态发生改变回调
//       onLocalVideoStateChanged: (VideoSourceType source, LocalVideoStreamState state, LocalVideoStreamError error) {
//         Log.d('[onLocalVideoStateChanged] source: $source stats: $state error: $error');
//         if (!(source == VideoSourceType.videoSourceScreen || source == VideoSourceType.videoSourceScreenPrimary)) {
//           return;
//         }
//         switch (state) {
//           case LocalVideoStreamState.localVideoStreamStateCapturing:
//           case LocalVideoStreamState.localVideoStreamStateEncoding:
//             screenCapture.value = true;
//             break;
//           case LocalVideoStreamState.localVideoStreamStateStopped:
//           case LocalVideoStreamState.localVideoStreamStateFailed:
//             screenCapture.value = false;
//             break;
//           default:
//             break;
//         }
//       },
//       // 本地音频状态发生改变回调
//       onLocalAudioStateChanged: (RtcConnection connection, LocalAudioStreamState state, LocalAudioStreamError error) {
//         Log.d('[onLocalAudioStateChanged] connection: ${connection.toJson()} stats: $state error: $error');
//       },
//       // 远端用户（通信场景）/主播（直播场景）停止或恢复发送音频流回调
//       onUserMuteAudio: (RtcConnection connection, int remoteUid, bool muted) {
//         Log.d(
//             '[onUserMuteAudio] connection: ${connection.toJson()} remoteUid: $remoteUid stats: ${muted ? "关闭" : "打开"}麦克风');
//       },
//       // 监测到远端最活跃用户回调
//       onActiveSpeaker: (RtcConnection connection, int uid) {
//         Log.d('[onActiveSpeaker] connection: ${connection.toJson()} uid: $uid');
//       },
//       // 用户音量提示回调
//       onAudioVolumeIndication:
//           (RtcConnection connection, List<AudioVolumeInfo> speakers, int speakerNumber, int totalVolume) {
//         // Log.d(
//         //     '[onAudioVolumeIndication] connection: ${connection.toJson()} speakers: ${speakers.map((e) => e.toJson()).toList()} speakerNumber: $speakerNumber, totalVolume: $totalVolume');
//         //
//         // if (speakers.isNotEmpty) {
//         //   if (speakers.singleWhere((element) => element.uid == 0).vad == 0) {
//         //     Log.d("本地无人声");
//         //   } else {
//         //     Log.d(
//         //         "本地有人声=======》音量：${speakers.singleWhere((element) => element.uid == 0).volume} =====>音调：${speakers.singleWhere((element) => element.uid == 0).voicePitch}");
//         //   }
//         //
//         //   speakers.where((element) => element.uid != 0).toList().forEach((element) {
//         //     Log.d("远端用户====>${element.toJson()}");
//         //   });
//         // }
//       },
//       // 直播场景下用户角色已切换回调
//       onClientRoleChanged:
//           (RtcConnection connection, ClientRoleType oldRole, ClientRoleType newRole, ClientRoleOptions newRoleOptions) {
//         Log.d(
//             '[onClientRoleChanged] connection: ${connection.toJson()} oldRole: $oldRole newRole: $newRole newRoleOptions: ${newRoleOptions.toJson()}');
//       },
//       // 直播场景下切换用户角色失败回调
//       onClientRoleChangeFailed:
//           (RtcConnection connection, ClientRoleChangeFailedReason reason, ClientRoleType currentRole) {
//         Log.d(
//             '[onClientRoleChangeFailed] connection: ${connection.toJson()} currentRole: $currentRole reason: $reason');
//       },
//       // Token 已过期回调
//       onRequestToken: (RtcConnection connection) {
//         Log.d('[onRequestToken] connection: ${connection.toJson()}');
//       },
//     );
//
//     engine.registerEventHandler(rtcEngineEventHandler);
//
//     /// 启用视频模块
//     await engine.enableVideo();
//
//     /// 是否启动摄像头采集并创建本地视频流
//     await engine.enableLocalVideo(cameraState);
//
//     /// 是否发布本地视频流
//     await engine.muteLocalVideoStream(!cameraState);
//
//     /// 启用音频模块
//     await engine.enableAudio();
//
//     /// 开关本地音频采集
//     await engine.enableLocalAudio(microphoneState);
//
//     /// 取消或恢复发布本地音频流
//     await engine.muteLocalAudioStream(!microphoneState);
//
//     /// 启用用户音量提示
//     // await engine.enableAudioVolumeIndication(interval: 15000, reportVad: true, smooth: 3);
//
//     /// 初始化本地视图。
//     await engine.setupLocalVideo(const VideoCanvas(
//         backgroundColor: 0xffffffff,
//         renderMode: RenderModeType.renderModeHidden,
//         mirrorMode: VideoMirrorModeType.videoMirrorModeAuto));
//
//     /// 静音
//     if (isSilent) setReceiveAudioType(ReceiveAudioType.mute);
//
//     /// 开启视频预览
//     await engine.startPreview();
//
//     if (!isFrontCamera) switchCamera();
//   }
//
//   /// 加入频道
//   Future<void> joinChannel(
//       {required String token, required String channel, required int uid, required ClientRoleType roleType}) async {
//     await engine.joinChannel(
//         token: token,
//         channelId: channel,
//         uid: uid,
//         options: ChannelMediaOptions(
//             channelProfile: ChannelProfileType.channelProfileLiveBroadcasting, clientRoleType: roleType));
//
//     /// 取消或恢复订阅所有远端用户的视频流，该方法需要在加入频道后调用。
//     await engine.muteAllRemoteVideoStreams(false);
//
//     /// 取消或恢复订阅所有远端用户的音频流，该方法需要在加入频道后调用。
//     await engine.muteAllRemoteAudioStreams(false);
//   }
//
//   /// 设置直播场景下的用户角色和级别。
//   Future setClientRole(ClientRoleType role) async {
//     engine.setClientRole(role: role);
//
//     /// 将用户切换为听众后要将摄像头和麦克风关掉
//     if (role == ClientRoleType.clientRoleAudience) {
//       if (videoEnabled.value) turnCamera();
//       if (!micEnabled.value) turnMicrophone();
//     }
//   }
//
//   /// 离开频道
//   Future leaveChannel() async {
//     await engine.leaveChannel();
//   }
//
//   /// 摄像头启用状态
//   var videoEnabled = true.obs;
//
//   /// 开关摄像头
//   Future turnCamera() async {
//     if (videoEnabled.value) {
//       /// 关闭摄像头前将虚拟背景关掉
//       if (enableVirtual.value) await enableVirtualBackground(false);
//       await engine.enableLocalVideo(false);
//       await engine.muteLocalVideoStream(true);
//       videoEnabled.value = false;
//     } else {
//       await engine.enableLocalVideo(true);
//       await engine.muteLocalVideoStream(false);
//       videoEnabled.value = true;
//     }
//     currentUser.value.isOpenCamera = videoEnabled.value;
//   }
//
//   /// 麦克风禁用状态
//   var micEnabled = false.obs;
//
//   /// 开关麦克风
//   Future turnMicrophone() async {
//     if (micEnabled.value) {
//       await engine.enableLocalAudio(true);
//       await engine.muteLocalAudioStream(false);
//       micEnabled.value = false;
//     } else {
//       await engine.enableLocalAudio(false);
//       await engine.muteLocalAudioStream(true);
//       micEnabled.value = true;
//     }
//     currentUser.value.isOpenMicrophone = !micEnabled.value;
//   }
//
//   /// 加入频道后更新频道媒体选项
//   ///
//   /// [token] TOKEN
//   /// [roleType] 角色
//   ///
//   Future updateChannelMediaOptions(String token, ClientRoleType roleType) async {
//     engine.updateChannelMediaOptions(ChannelMediaOptions(
//         publishCameraTrack: roleType == ClientRoleType.clientRoleBroadcaster,
//         publishMicrophoneTrack: roleType == ClientRoleType.clientRoleBroadcaster,
//         channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//         clientRoleType: roleType,
//         token: token,
//         audienceLatencyLevel: AudienceLatencyLevelType.audienceLatencyLevelLowLatency));
//   }
//
//   /// 接收远程声音模式
//   var receiveAudioType = ReceiveAudioType.reproducer.obs;
//
//   void setReceiveAudioType(ReceiveAudioType receiveAudioType) {
//     if (this.receiveAudioType.value == receiveAudioType) return;
//     switch (receiveAudioType) {
//       case ReceiveAudioType.reproducer:
//         engine.setEnableSpeakerphone(true).then((value) {
//           engine.adjustPlaybackSignalVolume(400).then((value) {
//             this.receiveAudioType.value = receiveAudioType;
//           });
//         });
//         break;
//       case ReceiveAudioType.mute:
//         engine.adjustPlaybackSignalVolume(0).then((value) {
//           this.receiveAudioType.value = receiveAudioType;
//         });
//         break;
//       case ReceiveAudioType.earpiece:
//         engine.setEnableSpeakerphone(false).then((value) {
//           engine.adjustPlaybackSignalVolume(400).then((value) {
//             this.receiveAudioType.value = receiveAudioType;
//           });
//         });
//         break;
//     }
//   }
//
//   /// 是否是前置摄像头
//   bool isFrontCamera = true;
//
//   /// 切换前置/后置摄像头
//   Future switchCamera() async {
//     if (videoEnabled.value)
//       await engine.switchCamera().then((value) {
//         isFrontCamera = !isFrontCamera;
//       });
//   }
//
//   /// 是否开启虚拟背景
//   var enableVirtual = false.obs;
//
//   /// 虚拟背景设置下标
//   var backgroundImageIndex = 0.obs;
//
//   /// 开启/关闭虚拟背景,在 enableVideo 或 startPreview 之后调用该方法
//   Future enableVirtualBackground(bool enabled, {int imageIndex = 0}) async {
//     backgroundImageIndex.value = imageIndex;
//     if (videoEnabled.value) {
//       String? imagePath;
//       if (imageIndex > 1) {
//         imagePath = await FileUtil.saveFileToLocal(Context().pictureUri(Constants().live_background[imageIndex - 2]),
//             "${await FileUtil.getTempPath()}${FileUtil.getFileNameByPathWithSuffix(Constants().live_background[imageIndex - 2])}");
//       }
//       Log.d("$imagePath");
//       enableVirtual.value == enabled;
//       engine.enableVirtualBackground(
//         // 是否开启虚拟背景
//           enabled: enabled,
//           // 自定义的背景
//           backgroundSource: VirtualBackgroundSource(
//               backgroundSourceType: imageIndex == 1
//                   ? BackgroundSourceType.backgroundBlur
//                   : imagePath == null
//                   ? BackgroundSourceType.backgroundColor
//                   : BackgroundSourceType.backgroundImg,
//               source: imagePath),
//           // 背景图像的处理属性
//           segproperty: const SegmentationProperty(modelType: SegModelType.segModelAi));
//     }
//   }
//
//   /// 屏幕共享
//   var screenCapture = false.obs;
//
//   ScreenCaptureParameters2 parameters = const ScreenCaptureParameters2(
//       captureAudio: true,
//       audioParams: ScreenAudioParameters(captureSignalVolume: 100),
//       captureVideo: true,
//       videoParams: ScreenVideoParameters(
//         dimensions: VideoDimensions(width: 1280, height: 720), // 视频编码的分辨率。默认值为 1280 × 720
//         frameRate: 10, // 视频编码帧率 (fps)。默认值为 15
//         bitrate: 1000, // 视频编码码率 (Kbps)
//         contentHint: VideoContentHint.contentHintDetails, // 屏幕共享视频的内容类型
//       ));
//
//   void launch() {
//     // if (DeviceUtils.isIOS)
//     // Please fill in the name of the Broadcast Extension in your project, which is the file name of the `.appex` product
//     // ReplayKitLauncher.launchReplayKitBroadcast('ScreenSharing');
//   }
//
//   void finish() {
//     // if (DeviceUtils.isIOS)
//     // Please fill in the CFNotification name in your project
//     // ReplayKitLauncher.finishReplayKitBroadcast('MyFinishBroadcastUploadExtensionProcessNotification');
//   }
//
//   Future release() async {
//     await engine.setupLocalVideo(const VideoCanvas(view: null));
//     engine.unregisterEventHandler(rtcEngineEventHandler);
//     await leaveChannel();
//     await engine.release();
//   }
//
//   /// 选择一张图片（相册,相机）
//   Future<String?> pickerSingleImage() async {
//     try {
//       return await AssetPicker.pickAssets(Get.context!,
//           pickerConfig: AssetPickerConfig(
//               maxAssets: 1,
//               requestType: RequestType.image,
//               themeColor: Get.theme.primaryColor,
//               specialItemPosition: SpecialItemPosition.none))
//           .then((value) async {
//         if (value != null && value.isNotEmpty) {
//           return (await value.first.originFile)!.path;
//         }
//         return null;
//       });
//     } on Exception catch (e) {
//       Log.d('选择图片报错：${e.toString()}');
//       return null;
//     }
//   }
// }
