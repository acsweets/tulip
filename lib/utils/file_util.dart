// import 'dart:io';
// import 'dart:ui' as ui;
//
// import 'package:cses_common/cses_common.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_media_metadata/flutter_media_metadata.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:media_info/media_info.dart';
// import 'package:path/path.dart';
//
// class FileUtil {
//   static Uint8List convert(ByteData data) {
//     var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//     return bytes;
//   }
//
//   static Future<Uint8List?> readFileByte(String filePath) async {
//     Uri myUri = Uri.parse(filePath);
//     File file = File.fromUri(myUri);
//     Uint8List? bytes;
//     await file.readAsBytes().then((value) {
//       bytes = Uint8List.fromList(value);
//       Log.d('reading of bytes is completed');
//     }).catchError((onError) {
//       Log.d('Exception Error while reading audio from path:$onError');
//     });
//     return bytes;
//   }
//
//   static Future<String> cacheFileName(String filePath, String fileKey) async {
//     final directory = await getTemporaryDirectory();
//     return "${directory.path}/$filePath/$fileKey";
//   }
//
//   static Future<bool> checkExist(String fileName) {
//     Uri myUri = Uri.parse(fileName);
//     File file = File.fromUri(myUri);
//     Future<bool> result = file.exists();
//     return result;
//   }
//
//   static deleteFile(String filePath) async {
//     File file = File(filePath);
//     //如果文件存在，删除
//     if (await file.exists()) {
//       file.deleteSync();
//       Log.d('文件删除成功');
//     }
//   }
//
//   static Future<Directory> get tempDirectory async => await getTemporaryDirectory();
//
//   static Future<Directory> get applicationDirectory async => await getApplicationDocumentsDirectory();
//
//   /// 获取本地文档根目录
//   ///
//   static Future<String?> getLocalPath() async {
//     /// 文档目录，该目录用于存储只有自己可以访问的文件。只有当应用程序被卸载时，系统才会清除该目录。在iOS上，这对应于NSDocumentDirectory。在Android上，这是AppData目录。
//     var appDocDir = await applicationDirectory;
//     return "${appDocDir.path}/";
//   }
//
//   /// 获取本地临时根目录
//   ///
//   static Future<String> getTempPath() async {
//     /// 临时目录, 系统可随时清除的临时目录（缓存）。在iOS上，这对应于NSTemporaryDirectory() 返回的值。在Android上，这是getCacheDir()返回的值。
//     Directory tempDir = await tempDirectory;
//     return "${tempDir.path}/";
//   }
//
//   /// 获取SD卡根目录，仅仅在Android平台可以使用
//   ///
//   static Future<String?> getSDCardPath() async {
//     try {
//       var sdDir = await getExternalStorageDirectory();
//       if (sdDir != null) return "${sdDir.path}/";
//     } catch (err) {
//       Log.e(err.toString());
//       return null;
//     }
//     return null;
//   }
//
//   //xiaoming.instrumental.wav
//   static Future<File> copyFileAssets(String assetName, String localName) async {
//     final ByteData assetByteData = await rootBundle.load(assetName);
//
//     final List<int> byteList =
//         assetByteData.buffer.asUint8List(assetByteData.offsetInBytes, assetByteData.lengthInBytes);
//
//     final String fullTemporaryPath = join((await applicationDirectory).path, localName);
//
//     return File(fullTemporaryPath).writeAsBytes(byteList, mode: FileMode.writeOnly, flush: true);
//   }
//
//   static Future<String> assetPath(String assetName) async {
//     return join((await applicationDirectory).path, assetName);
//   }
//
//   static void checkFolder(String path) {
//     Directory dir = Directory(path);
//     var exist = dir.existsSync();
//     if (!exist) {
//       dir.createSync(recursive: true);
//     }
//   }
//
//   /*删除目录*/
//   static void deleteFolder(path) {
//     Directory dir = Directory(path);
//     var exist = dir.existsSync();
//     if (exist) {
//       dir.deleteSync(recursive: true);
//     }
//   }
//
//   static Future<List<int>> fileToUint8List(String path, {bool isLocal = false}) async {
//     Uint8List? bytes;
//
//     if (isLocal) {
//       bytes = await readFileByte(path);
//     } else {
//       var response = await Dio().get(path, options: Options(responseType: ResponseType.bytes));
//       bytes = Uint8List.fromList(response.data);
//     }
//
//     return bytes ?? [];
//   }
//
//   static Future<ByteData> fetchAsset(String fileName) async {
//     return await rootBundle.load('assets/wav/$fileName');
//   }
//
//   static Future<File> fetchToMemory(String fileName) async {
//     String path = "${(await getTemporaryDirectory()).path}/$fileName";
//
//     final file = File(path);
//
//     await file.create(recursive: true);
//
//     return await file.writeAsBytes((await fetchAsset(fileName)).buffer.asUint8List());
//   }
//
//   static Future<List<File>> fetchFilesFromFolder(String path) async {
//     Directory dir = Directory(path);
//     List<FileSystemEntity> fileSystemEntity;
//     fileSystemEntity = dir.listSync(recursive: true, followLinks: false);
//
//     List<File> files = [];
//     for (FileSystemEntity entity in fileSystemEntity) {
//       String filePath = entity.path;
//       Log.d(filePath);
//       files.add(File(filePath));
//     }
//
//     return files;
//   }
//
//   /// 根据文件本地路径获取文件名称
//   ///
//   /// [filePath] 文件路径
//   ///
//   static String getFileNameByPath(String? filePath) {
//     if (filePath == null) return '';
//     return (filePath.lastIndexOf('/') > -1 ? filePath.substring(filePath.lastIndexOf('/') + 1) : filePath)
//         .split(".")
//         .first;
//   }
//
//   /// 根据文件本地路径获取文件名称（带后缀）
//   ///
//   /// [filePath] 文件路径
//   ///
//   static String getFileNameByPathWithSuffix(String? filePath) {
//     if (filePath == null) return '';
//     return filePath.lastIndexOf('/') > -1 ? filePath.substring(filePath.lastIndexOf('/') + 1) : filePath;
//   }
//
//   static Future<Uint8List?> getImageData(GlobalKey globalKey) async {
//     RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     return byteData?.buffer.asUint8List();
//   }
//
//   static Future saveScreenByKey(GlobalKey globalKey) async {
//     Uint8List? uint8list = await getImageData(globalKey);
//     if (uint8list != null) {
//       await saveScreen(uint8list);
//     } else {
//       showToast(text: "保存失败");
//     }
//   }
//
//   static Future saveScreen(Uint8List imageBytes) async {
//     final result = await ImageGallerySaver.saveImage(imageBytes, quality: 100);
//     if (result != null) {
//       showToast(text: "保存成功");
//     } else {
//       showToast(text: "保存失败");
//     }
//   }
//
//   static Future<bool> saveImageFromUrl(String url) async {
//     var response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
//     final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
//     if (result != null) {
//       showToast(text: "保存成功");
//       return true;
//     }
//     return false;
//   }
//
//   static Future<String?> saveFileToLocal(String? url, String saveName) async {
//     if (url == null) return null;
//     Log.d('下载地址：$url-------$saveName');
//     File file = File(saveName);
//     if (await file.exists()) {
//       Log.d("文件已存在");
//       return saveName;
//     } else {
//       try {
//         var response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
//         Uint8List bytes = Uint8List.fromList(response.data);
//         await file.writeAsBytes(bytes);
//         final result = await ImageGallerySaver.saveFile(file.path);
//
//         Log.d(result.toString());
//
//         return saveName;
//       } catch (e) {
//         Log.e('download failed:$e');
//         // 下载失败则将创建的文件删除
//         await file.delete();
//         return null;
//       }
//     }
//   }
//
//   /// 获取音频资源的信息（包括时长毫秒 durationMs，大小 size，文件类型 mimeType）
//   ///
//   /// [audioPath] 音频本地路径
//   ///
//   static Future<Map<String, dynamic>> getAudioInfo(String? audioPath) async {
//     File audioFile = File("$audioPath");
//     String fileName = getFileNameByPathWithSuffix(audioPath);
//     int size = 0;
//     if (audioFile.existsSync()) {
//       size = await audioFile.length();
//       try {
//         if (DeviceUtils.isIOS) {
//           Map<String, dynamic> mediaInfo = await MediaInfo().getMediaInfo("$audioPath");
//           Log.d(mediaInfo.toString());
//
//           return {
//             "duration": mediaInfo["durationMs"],
//             "size": size,
//             "mimeType": mediaInfo["mimeType"],
//             "path": audioPath,
//             "title": fileName
//           };
//         } else if (DeviceUtils.isAndroid) {
//           Metadata metadata = await MetadataRetriever.fromFile(audioFile);
//           Log.d("--------------------->${metadata.toJson()}");
//
//           return {
//             "duration": metadata.trackDuration,
//             "size": size,
//             "mimeType": metadata.mimeType,
//             "path": metadata.filePath,
//             "title": fileName,
//             "bitrate": metadata.bitrate
//           };
//         }
//       } catch (error) {
//         Log.d("----------------->${error.toString()}");
//       }
//     }
//
//     return {"duration": 0, "size": size, "mimeType": "audio/x-m4a", "path": audioPath, "title": fileName};
//   }
//
//   /// 获取本地视频资源的信息（包括时长毫秒 duration，大小 size，文件类型 mimeType）
//   ///
//   /// [videoPath] 视频本地路径
//   ///
//   static Future<Map<String, dynamic>?> getVideoInfo(String? videoPath) async {
//     File videoFile = File("$videoPath");
//     if (videoFile.existsSync()) {
//       try {
//         Map<String, dynamic> mediaInfo = await MediaInfo().getMediaInfo("$videoPath");
//         Log.d("======================>${mediaInfo.toString()}");
//
//         int size = await videoFile.length();
//
//         String target = '${await getTempPath()}${StringUtil.newId()}-${DateTime.now().microsecondsSinceEpoch}.png';
//         if (File(target).existsSync()) {
//           File(target).deleteSync();
//         }
//
//         String path = await MediaInfo()
//             .generateThumbnail("$videoPath", target, mediaInfo["width"] ?? 1080, mediaInfo["height"] ?? 720);
//
//         String fileName = getFileNameByPathWithSuffix(videoPath);
//
//         return {
//           "duration": mediaInfo["durationMs"],
//           "size": size,
//           "mimeType": mediaInfo["mimeType"],
//           "path": videoPath,
//           "snapshotPath": path,
//           "sourceType": SourceType.personal.name,
//           "frameRate": mediaInfo["frameRate"],
//           "numTracks": mediaInfo["numTracks"],
//           "width": mediaInfo["width"],
//           "height": mediaInfo["height"],
//           "title": fileName
//         };
//       } catch (e) {
//         Log.d("----------------->${e.toString()}");
//       }
//     }
//
//     return null;
//   }
// }
