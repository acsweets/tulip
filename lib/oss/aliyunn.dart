// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:cses_saas/cses_saas.dart';
// import 'package:flutter/material.dart';
// import 'package:mime/mime.dart';
//
// class ResourcePickerHandler {
//   /// 媒体资源（包括单张照片，多张照片，视频等）
//   PickerResourceListener? resourceListener;
//
//   /// 单张照片
//   SingleImagePickerListener? singleListener;
//
//   /// 多张照片
//   MultipleImagePickerListener? multipleListener;
//
//   /// 多个音频
//   MultipleAudiosPostListener? multipleAudioListener;
//
//   /// 视频
//   VideoPickerListener? videoListener;
//
//   /// 头像
//   FacePickerListener? faceListener;
//
//   /// 附件
//   AttachmentPickerListener? attachmentListener;
//
//   /// 音频
//   AudioPostListener? audioListener;
//
//   /// 语音
//   VoicePostListener? voiceListener;
//
//   bool isClip; // 是否裁剪
//
//   bool isSquare; // 是否裁剪成正方形
//
//   ResourcePickerHandler({
//     this.resourceListener,
//     this.singleListener,
//     this.multipleListener,
//     this.videoListener,
//     this.faceListener,
//     this.attachmentListener,
//     this.audioListener,
//     this.voiceListener,
//     this.multipleAudioListener,
//     this.isClip = false,
//     this.isSquare = false,
//   });
//
//   /// 视频录制
//   Future pickerImageOrVideoFromCamara(BuildContext context) async {
//     AssetEntity? assetEntity = await CameraPicker.pickFromCamera(context,
//         pickerConfig: const CameraPickerConfig(enableRecording: true, resolutionPreset: ResolutionPreset.medium));
//     if (assetEntity != null) {
//       var videoPath = (await assetEntity.originFile)!.path;
//       showLoading();
//       if (AssetType.video == assetEntity.type) {
//         var json = await FileUtil.getVideoInfo(videoPath);
//         if (json != null)
//           pushVideoToAliYun(LocalMediaInfo.fromJson(json));
//         else
//           BotToast.closeAllLoading();
//       } else {
//         pushPictureToAliYun(videoPath);
//       }
//     } else {
//       showToast(text: "用户取消了");
//     }
//   }
//
//   /// 选择一张图片（相册,相机）
//   Future pickerSingleImage(BuildContext context, {bool showCamara = true}) async {
//     try {
//       await AssetPicker.pickAssets(context,
//           pickerConfig: AssetPickerConfig(
//               maxAssets: 1,
//               // 最多选择的图片数量
//               requestType: RequestType.image,
//               // 选择器选择资源的类型
//               themeColor: Theme.of(context).primaryColor,
//               // 选择器的主题色
//               specialItemPosition: showCamara ? SpecialItemPosition.prepend : SpecialItemPosition.none,
//               specialItemBuilder: showCamara
//                   ? (BuildContext context, AssetPathEntity? path, int length) {
//                 if (path?.isAll != true) {
//                   return null;
//                 }
//                 return GestureDetector(
//                     behavior: HitTestBehavior.opaque,
//                     onTap: () async {
//                       final AssetEntity? result = await _pickFromCamera(context, false, false);
//                       if (result != null) Get.back(result: <AssetEntity>[result]);
//                     },
//                     child: Center(child: Icon(Icons.camera_enhance, size: 42.w)));
//               }
//                   : null))
//           .then((value) async {
//         if (value != null && value.isNotEmpty) {
//           String imagePath = (await value.first.originFile)!.path;
//
//           if (isClip) {
//             _cropImage(imagePath);
//           } else {
//             showLoading();
//             if (faceListener != null) {
//               _pushFaceToAliYun(imagePath);
//             } else {
//               pushPictureToAliYun(imagePath);
//             }
//           }
//         }
//       });
//     } on Exception catch (e) {
//       BotToast.closeAllLoading();
//       Log.d('选择图片报错：${e.toString()}');
//     }
//   }
//
//   /// 选择一个媒体文件（图片、音、视频）
//   Future pickerSingleMediumFile(BuildContext context,
//       {RequestType requestType = RequestType.image, bool showCamara = true, bool isAttachment = false}) async {
//     DeviceUtils.hideKeyboard(context);
//     try {
//       await AssetPicker.pickAssets(context,
//           pickerConfig: AssetPickerConfig(
//               maxAssets: 1,
//               // 最多选择的图片数量
//               requestType: requestType,
//               // 选择器选择资源的类型
//               themeColor: Theme.of(context).primaryColor,
//               // 选择器的主题色
//               specialItemPosition: showCamara ? SpecialItemPosition.prepend : SpecialItemPosition.none,
//               specialItemBuilder: showCamara
//                   ? (_, AssetPathEntity? path, int length) {
//                 if (path?.isAll != true) {
//                   return null;
//                 }
//                 return GestureDetector(
//                     behavior: HitTestBehavior.opaque,
//                     onTap: () async {
//                       final AssetEntity? result = await _pickFromCamera(
//                           context,
//                           requestType == RequestType.video ||
//                               requestType == RequestType.common ||
//                               requestType == RequestType.all,
//                           requestType == RequestType.video);
//                       if (result != null) Navigator.of(context).pop(<AssetEntity>[result]);
//                     },
//                     child: Center(child: Icon(Icons.camera_enhance, size: 42.w)));
//               }
//                   : null))
//           .then((value) async {
//         if (value != null && value.isNotEmpty) {
//           String _path = (await value.first.originFile)!.path;
//
//           Log.d("wwwwwwwwwwwwwwwwwwwwwwwwwwweee========================>$_path");
//           if (AssetType.video == value.first.type) {
//             showLoading();
//             var json = await FileUtil.getVideoInfo(_path);
//             if (json != null)
//               pushVideoToAliYun(LocalMediaInfo.fromJson(json), isAttachment: isAttachment);
//             else
//               BotToast.closeAllLoading();
//           } else if (AssetType.audio == value.first.type) {
//             showLoading();
//             Map<String, dynamic> mediaInfo = await FileUtil.getAudioInfo(_path);
//             uploadAudioToAliYun(LocalMediaInfo.fromJson(mediaInfo), isAttachment: isAttachment);
//           } else {
//             if (isClip) {
//               _cropImage(_path);
//             } else {
//               showLoading();
//               if (faceListener != null) {
//                 _pushFaceToAliYun(_path);
//               } else {
//                 pushPictureToAliYun(_path, isAttachment: isAttachment);
//               }
//             }
//           }
//         } else {
//           Log.d("用户取消了");
//         }
//       });
//     } on Exception catch (e) {
//       BotToast.closeAllLoading();
//       Log.d('选择媒体文件报错：${e.toString()}');
//     }
//   }
//
//   /// 裁剪(仅单张图片才会有裁剪)
//   Future _cropImage(String path) async {
//     CroppedFile? croppedFile = await ImageCropper().cropImage(
//         sourcePath: path,
//         aspectRatio: isSquare ? const CropAspectRatio(ratioY: 1, ratioX: 1) : null,
//         uiSettings: [
//           AndroidUiSettings(
//               hideBottomControls: isSquare,
//               initAspectRatio: CropAspectRatioPreset.original,
//               lockAspectRatio: false,
//               toolbarTitle: '裁剪',
//               toolbarColor: Colors.black,
//               statusBarColor: Colors.black,
//               toolbarWidgetColor: Colors.white),
//           IOSUiSettings(title: "图片裁剪", doneButtonTitle: "完成", cancelButtonTitle: "取消")
//         ]);
//
//     Log.d("=========Cropper========================${croppedFile?.path}");
//
//     if (croppedFile != null) {
//       showLoading();
//       if (faceListener != null) {
//         _pushFaceToAliYun(croppedFile.path);
//       } else {
//         pushPictureToAliYun(croppedFile.path);
//       }
//     }
//   }
//
//   /// 从相册选择多张照片
//   Future pickerImagesFromGallery(BuildContext context,
//       {int maxImages = 9, List<AssetEntity> imageList = const []}) async {
//     List<AssetEntity> resultList = [];
//     try {
//       await AssetPicker.pickAssets(context,
//           pickerConfig: AssetPickerConfig(
//               maxAssets: maxImages,
//               // 最多选择的图片数量
//               requestType: RequestType.image,
//               // 选择器选择资源的类型
//               themeColor: Theme.of(context).primaryColor,
//               // 选择器的主题色
//               selectedAssets: imageList))
//           .then((value) {
//         if (value != null) {
//           resultList = value;
//           if (resultList.isNotEmpty) {
//             if (resourceListener != null) resourceListener!.multipleImages(images: resultList);
//             if (multipleListener != null) multipleListener!.multipleImages(images: resultList);
//           }
//         }
//       });
//     } on Exception catch (e) {
//       BotToast.closeAllLoading();
//       Log.d('选择图片报错：${e.toString()}');
//     }
//   }
//
//   /// 上传视频到阿里云
//   Future pushVideoToAliYun(LocalMediaInfo videoBean, {bool isAttachment = false}) async {
//     String fileId = StringUtil.newId();
//     Log.d(videoBean.toJson());
//     try {
//       await Aliyun().upload(BucketType.video.name, fileId, videoBean.path!,
//           snapshot: videoBean.snapshotPath,
//           duration: videoBean.duration,
//           fileDate: DateTime.now(), onComplete: (UploadResponse resp) async {
//             BotToast.closeAllLoading();
//             if (resp.success != null && resp.success!) {
//               ResourceBean video = ResourceBean(
//                   id: fileId,
//                   ossType: OssType.ALIYUN_OSS,
//                   bucket: resp.fileBucket,
//                   contentType: FileContentType.VIDEO,
//                   snapshot: resp.snapshot,
//                   duration: videoBean.duration,
//                   uri: resp.fileKey,
//                   size: videoBean.size,
//                   title: "${FileUtil.getFileNameByPathWithSuffix(videoBean.path)}",
//                   createTime: DateTime.now().millisecondsSinceEpoch,
//                   userName: User().userName,
//                   departName: Context().departmentName);
//               if (resourceListener != null) resourceListener!.singleVideo(video, isAttachment: isAttachment);
//               if (videoListener != null) videoListener!.singleVideo(video, isAttachment: isAttachment);
//               Log.d("=====videoParams=======${video.toJson().toString()}");
//             } else {
//               showToast(text: "上传视频失败！");
//               Log.error("${resp.message}", action: "onUpload", eventName: Keys.VIDEO);
//             }
//           });
//     } catch (e) {
//       BotToast.closeAllLoading();
//       showToast(text: "上传视频失败！");
//       Log.error("${e.toString()}", action: "onUpload", eventName: "video-try");
//     }
//   }
//
//   /// 上传单张图片到阿里云
//   Future pushPictureToAliYun(String path, {int? size, bool isAttachment = false}) async {
//     String? pngPath = await HeicToJpg.convert(path);
//     Log.d("原始图片=$path==============================转换后的图片======$pngPath");
//     String fileId = StringUtil.newId();
//     try {
//       await Aliyun().upload(BucketType.picture.name, fileId, pngPath ?? path, fileDate: DateTime.now(),
//           onComplete: (UploadResponse resp) {
//             Log.d("upload picture complete==>${resp.fileKey}&==${resp.fileBucket}=========>${resp.toJson()}");
//             BotToast.closeAllLoading();
//             if (resp.success != null && resp.success!) {
//               ResourceBean picture = ResourceBean(
//                   id: fileId,
//                   ossType: OssType.ALIYUN_OSS,
//                   bucket: resp.fileBucket,
//                   contentType: FileContentType.IMAGE,
//                   uri: resp.fileKey,
//                   size: size,
//                   title: '${FileUtil.getFileNameByPathWithSuffix(path)}',
//                   createTime: DateTime.now().millisecondsSinceEpoch,
//                   userName: User().userName,
//                   departName: Context().departmentName);
//
//               Log.d("===>${picture.toJson()}");
//
//               if (singleListener != null) singleListener!.singleImage(picture, isAttachment: isAttachment);
//               if (resourceListener != null) resourceListener!.singleImage(picture, isAttachment: isAttachment);
//             } else {
//               showToast(text: "上传失败！");
//               Log.error("${resp.message}", action: "onUpload", eventName: Keys.PICTURE);
//             }
//           });
//     } catch (e) {
//       BotToast.closeAllLoading();
//       showToast(text: "上传失败！");
//       Log.error("${e.toString()}", action: "onUpload", eventName: "picture-try");
//     }
//   }
//
//   /// 上传多张图片到阿里云
//   Future pushImagesToAliYun(List<AssetEntity> imageList) async {
//     showLoading();
//     List<Map<String, dynamic>> pictureList = [];
//     try {
//       for (int i = 0; i < imageList.length; i++) {
//         String fileId = StringUtil.newId();
//         File? _file = await imageList[i].originFile;
//         String filePath = _file!.path;
//         String? pngPath = await HeicToJpg.convert(filePath);
//         Uint8List? fileData = await imageList[i].originBytes;
//         Log.d("==$pngPath===========>$filePath");
//         await Aliyun().upload(BucketType.picture.name, fileId, pngPath ?? filePath, fileDate: DateTime.now(),
//             onComplete: (UploadResponse resp) {
//               Log.d("upload picture complete==>${resp.fileKey}&==${resp.fileBucket}=========>${resp.toJson()}");
//               if (resp.success != null && resp.success!) {
//                 pictureList.add({
//                   Keys.OSS_TYPE: OssType.ALIYUN_OSS.name,
//                   Keys.BUCKET: resp.fileBucket,
//                   Keys.CONTENT_TYPE: FileContentType.IMAGE.name,
//                   Keys.URI: resp.fileKey,
//                   Keys.TITLE: FileUtil.getFileNameByPathWithSuffix(pngPath ?? filePath),
//                   Keys.ID: fileId,
//                   Keys.USER_NAME: User().userName,
//                   Keys.CREATE_TIME: DateTime.now().millisecondsSinceEpoch,
//                   Keys.DEPART_NAME: Context().departmentName
//                 });
//                 if (i == imageList.length - 1 && pictureList.isNotEmpty) {
//                   if (resourceListener != null) resourceListener!.multipleImages(picturesParams: pictureList);
//                   if (multipleListener != null) multipleListener!.multipleImages(picturesParams: pictureList);
//                 }
//               } else {
//                 BotToast.closeAllLoading();
//                 showToast(text: "上传失败！");
//                 Log.error("${resp.message}", action: "onUpload", eventName: Keys.PICTURE);
//               }
//             });
//       }
//     } catch (e) {
//       BotToast.closeAllLoading();
//       Log.error("${e.toString()}", action: "onUpload", eventName: "picture-try");
//     }
//   }
//
//   /// 上传头像到阿里云
//   Future _pushFaceToAliYun(String path) async {
//     String? pngPath = await HeicToJpg.convert(path);
//     String fileId = User().userId!;
//     try {
//       await Aliyun().upload(BucketType.face.name, fileId, pngPath ?? path, fileDate: DateTime.now(),
//           onComplete: (UploadResponse resp) {
//             Log.d("upload face complete==>${resp.fileKey}&==${resp.fileBucket}");
//             BotToast.closeAllLoading();
//             if (resp.success != null && resp.success!) {
//               if (faceListener != null) faceListener!.singleImage(true);
//             } else {
//               showToast(text: "上传失败！");
//               if (faceListener != null) faceListener!.singleImage(false);
//               Log.error("${resp.message}", action: "onUpload", eventName: Keys.FACE);
//             }
//           });
//     } catch (e) {
//       BotToast.closeAllLoading();
//       showToast(text: e.toString());
//       if (faceListener != null) faceListener!.singleImage(false);
//       Log.error("${e.toString()}", action: "onUpload", eventName: "face-try");
//     }
//   }
//
//   Future pickerFile({bool isAttachment = false}) async {
//     FilePickerResult? result;
//     try {
//       result = await FilePicker.platform.pickFiles(type: FileType.any);
//     } catch (e) {
//       BotToast.closeAllLoading();
//     }
//
//     if (result != null) {
//       String filePath = result.files.single.path!;
//
//       String? type = lookupMimeType(filePath);
//
//       if (type != null) {
//         Log.d(type);
//
//         if (type.contains("image/")) {
//           Log.d("图片");
//           String? pngPath = await HeicToJpg.convert(filePath);
//           pushPictureToAliYun(pngPath ?? filePath, size: result.files.single.size, isAttachment: isAttachment);
//         } else if (type.contains("audio/")) {
//           Log.d("音频");
//           Log.d('音频路径$filePath');
//           Map<String, dynamic> mediaInfo = await FileUtil.getAudioInfo(filePath);
//           uploadAudioToAliYun(LocalMediaInfo.fromJson(mediaInfo), isAttachment: isAttachment);
//         } else if (type.contains("video/")) {
//           showLoading();
//           Log.d('视频路径$filePath');
//           var json = await FileUtil.getVideoInfo(filePath);
//           if (json != null)
//             pushVideoToAliYun(LocalMediaInfo.fromJson(json), isAttachment: isAttachment);
//           else
//             BotToast.closeAllLoading();
//         } else if (type.contains("application/")) {
//           Log.d("文件");
//           if (type == "application/pdf") {
//             uploadFile(filePath, result.files.single.name, result.files.single.size,
//                 bucket: BucketType.pdf, contentType: FileContentType.PDF);
//             Log.d("pdf");
//           } else if (type == "application/vnd.openxmlformats-officedocument.presentationml.presentation" ||
//               "application/vnd.ms-powerpoint" == type) {
//             Log.d("ppt");
//             uploadFile(filePath, result.files.single.name, result.files.single.size,
//                 bucket: BucketType.ppt, contentType: FileContentType.PPT);
//           } else if (type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document" ||
//               "application/msword" == type) {
//             Log.d("word");
//             uploadFile(filePath, result.files.single.name, result.files.single.size, contentType: FileContentType.DOC);
//           } else if (type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" ||
//               "application/vnd.ms-excel" == type) {
//             Log.d("exel");
//             uploadFile(filePath, result.files.single.name, result.files.single.size, contentType: FileContentType.XLS);
//           } else if (type == "application/zip" ||
//               "application/x-zip-compressed" == type ||
//               "application/x-gzip" == type) {
//             Log.d("zip");
//             uploadFile(filePath, result.files.single.name, result.files.single.size,
//                 contentType: FileContentType.COMPRESS);
//           } else {
//             uploadFile(filePath, result.files.single.name, result.files.single.size);
//           }
//         } else if (type.contains("text/")) {
//           Log.d("文件");
//           if (type == "text/html") {
//             uploadFile(filePath, result.files.single.name, result.files.single.size, contentType: FileContentType.HTML);
//             Log.d("html");
//           } else {
//             uploadFile(filePath, result.files.single.name, result.files.single.size, contentType: FileContentType.TEXT);
//           }
//         } else {
//           showToast(text: "不支持的文件类型");
//           Log.d("待定");
//         }
//       } else {
//         uploadFile(filePath, result.files.single.name, result.files.single.size);
//       }
//     } else {
//       // User canceled the picker
//     }
//   }
//
//   /// 上传附件到阿里云
//   Future uploadFile(String filePath, String fileName, int size,
//       {BucketType bucket = BucketType.attachment, FileContentType contentType = FileContentType.NONE}) async {
//     showLoading();
//     try {
//       await Aliyun().upload(bucket.name, StringUtil.newId(), filePath, onProgress: (ProgressResponse progress) {
//         Log.d('上传进度：${progress.value}');
//       }, onComplete: (UploadResponse resp) {
//         BotToast.closeAllLoading();
//         if (resp.success != null && resp.success!) {
//           ResourceBean _file = ResourceBean(
//               ossType: OssType.ALIYUN_OSS,
//               bucket: resp.fileBucket,
//               uri: resp.fileKey,
//               id: resp.fileId,
//               contentType: contentType,
//               title: fileName,
//               size: size,
//               duration: 0,
//               createTime: DateTime.now().millisecondsSinceEpoch,
//               userName: User().userName,
//               departName: Context().departmentName);
//
//           attachmentListener!.attachment(_file, size);
//         } else {
//           showToast(text: "上传失败");
//           Log.error("${resp.message}", action: "onUpload", eventName: Keys.ATTACHMENT);
//         }
//       });
//     } catch (e) {
//       BotToast.closeAllLoading();
//       showToast(text: "上传失败");
//       Log.error("${e.toString()}", action: "onUpload", eventName: "attachment-try");
//     }
//   }
//
//   /// 上传音频到阿里云
//   Future uploadAudioToAliYun(LocalMediaInfo audioInfo, {bool isAttachment = false}) async {
//     showLoading();
//     try {
//       String fileId = StringUtil.newId();
//       await Aliyun().upload(BucketType.audio.name, fileId, "${audioInfo.path}",
//           duration: audioInfo.duration, fileDate: DateTime.now(), onProgress: (ProgressResponse progress) {
//             Log.d("upload==>${progress.id!}==>${progress.value}");
//           }, onComplete: (UploadResponse resp) async {
//             Log.d("upload audio complete==>${resp.fileKey}&==${resp.fileBucket}");
//             Log.d('音频上传完成====>${resp.success}');
//             BotToast.closeAllLoading();
//             if (resp.success != null && resp.success!) {
//               Map<String, dynamic> audioParams = {
//                 Keys.OSS_TYPE: OssType.ALIYUN_OSS.name,
//                 Keys.BUCKET: resp.fileBucket,
//                 Keys.CONTENT_TYPE: FileContentType.AUDIO.name,
//                 Keys.URI: resp.fileKey,
//                 Keys.TITLE: "${audioInfo.title}",
//                 Keys.ID: resp.fileId,
//                 Keys.DURATION: audioInfo.duration,
//                 Keys.SIZE: audioInfo.size,
//                 Keys.USER_NAME: User().userName,
//                 Keys.CREATE_TIME: DateTime.now().millisecondsSinceEpoch,
//                 Keys.DEPART_NAME: Context().departmentName
//               };
//
//               Log.d(audioParams.toString());
//               if (audioListener != null)
//                 audioListener!.singleAudio(audioParams, "${audioInfo.title}", audioInfo.size, isAttachment: isAttachment);
//             } else {
//               Log.error("${resp.message}", action: "onUpload", eventName: Keys.AUDIO);
//               showToast(text: '上传失败！');
//             }
//           });
//     } catch (e) {
//       BotToast.closeAllLoading();
//       Log.error("${e.toString()}", action: "onUpload", eventName: "audio-try");
//       showToast(text: "上传失败");
//     }
//   }
//
//   /// 上传多个音频到阿里云服务器
//   Future submitAudiosToAliYun(List<LocalMediaInfo> audios) async {
//     showLoading();
//     List<Map<String, dynamic>> audioList = [];
//     try {
//       for (int i = 0; i < audios.length; i++) {
//         String fileId = audios[i].id ?? StringUtil.newId();
//         String filePath = audios[i].path!;
//         Log.d("=============>$filePath");
//         await Aliyun().upload(BucketType.audio.name, fileId, filePath,
//             duration: audios[i].duration, fileDate: DateTime.now(), onComplete: (UploadResponse resp) {
//               Log.d("upload AUDIO complete==>${resp.fileKey}&==${resp.fileBucket}");
//               if (resp.success != null && resp.success!) {
//                 audioList.add({
//                   Keys.OSS_TYPE: OssType.ALIYUN_OSS.name,
//                   Keys.BUCKET: resp.fileBucket,
//                   Keys.CONTENT_TYPE: FileContentType.AUDIO.name,
//                   Keys.URI: resp.fileKey,
//                   Keys.TITLE: audios[i].title ?? "音频$fileId",
//                   Keys.ID: fileId,
//                   Keys.DURATION: audios[i].duration,
//                   Keys.SIZE: audios[i].size,
//                   Keys.USER_NAME: User().userName,
//                   Keys.CREATE_TIME: DateTime.now().millisecondsSinceEpoch,
//                   Keys.DEPART_NAME: Context().departmentName
//                 });
//                 if (i == audios.length - 1 && audioList.isNotEmpty) {
//                   if (multipleAudioListener != null) multipleAudioListener!.multipleAudios(audiosParams: audioList);
//                 }
//               } else {
//                 BotToast.closeAllLoading();
//                 showToast(text: "上传失败！");
//                 Log.error("${resp.message}", action: "onUpload", eventName: Keys.AUDIO);
//               }
//             });
//       }
//     } catch (e) {
//       BotToast.closeAllLoading();
//       Log.error("${e.toString()}", action: "onUpload", eventName: "audio-try");
//     }
//   }
//
//   /// 上传语音到阿里云
//   Future uploadVoiceToAliYun(String filePath, int duration, {int size = 0}) async {
//     showLoading();
//     try {
//       String fileId = StringUtil.newId();
//       await Aliyun().upload(BucketType.audio.name, fileId, filePath, duration: duration,
//           onProgress: (ProgressResponse progress) {
//             Log.d("upload==>${progress.id!}==>${progress.value}");
//           }, onComplete: (UploadResponse resp) async {
//             Log.d("upload audio complete==>${resp.fileKey}&==${resp.fileBucket}");
//             Log.d('音频上传完成');
//             BotToast.closeAllLoading();
//             if (resp.success != null && resp.success!) {
//               Map<String, dynamic> audioParams = {
//                 Keys.OSS_TYPE: OssType.ALIYUN_OSS.name,
//                 Keys.BUCKET: resp.fileBucket,
//                 Keys.CONTENT_TYPE: FileContentType.AUDIO.name,
//                 Keys.URI: resp.fileKey,
//                 Keys.TITLE: FileUtil.getFileNameByPathWithSuffix(filePath),
//                 Keys.DURATION: duration,
//                 Keys.ID: resp.fileId,
//                 Keys.USER_NAME: User().userName,
//                 Keys.CREATE_TIME: DateTime.now().millisecondsSinceEpoch,
//                 Keys.DEPART_NAME: Context().departmentName,
//                 Keys.SIZE: size
//               };
//
//               Log.d(audioParams.toString());
//
//               voiceListener!.singleVoice(audioParams);
//             } else {
//               Log.error("${resp.message}", action: "onUpload", eventName: Keys.AUDIO);
//               showToast(text: '上传失败！');
//             }
//           });
//     } catch (e) {
//       BotToast.closeAllLoading();
//       Log.error(e.toString(), action: "onUpload", eventName: "audio-try");
//       showToast(text: "上传失败");
//     }
//   }
//
//   void showLoading() {
//     BotToast.showCustomLoading(
//         crossPage: false, toastBuilder: (CancelFunc cancelFunc) => const SpinKitCircle(color: Colors.white));
//   }
// }
//
// Future<AssetEntity?> _pickFromCamera(BuildContext c, bool enableRecording, bool onlyEnableRecording) {
//   return CameraPicker.pickFromCamera(c,
//       pickerConfig: CameraPickerConfig(enableRecording: enableRecording, onlyEnableRecording: onlyEnableRecording));
// }
