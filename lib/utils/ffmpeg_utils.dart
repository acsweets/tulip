// import 'dart:io';
//
// import 'package:cses_common/config/enum_util.dart';
// import 'package:cses_common/utils/utils.dart';
// import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
// import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
// import 'package:ffmpeg_kit_flutter/media_information.dart';
// import 'package:ffmpeg_kit_flutter/media_information_session.dart';
// import 'package:ffmpeg_kit_flutter/return_code.dart';
// import 'package:ffmpeg_kit_flutter/session.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
//
// class FfmpegUtils {
//   /// 获取视频的封面
//   ///
//   /// [videoPath] 视频路径
//   ///
//   /// return [videoBean]
//   ///
//   static Future<Map<String, dynamic>?> getCoverFromVideo(String? videoPath) async {
//     String coverPath;
//
//     coverPath = '${await FileUtil.getTempPath()}${DateTime.now().microsecondsSinceEpoch}.png';
//     await FileUtil.deleteFile(coverPath);
//
//     /// 生成图片
//     return FFmpegKit.execute('-i $videoPath -r 1 -frames:v 1 $coverPath').then((Session session) async {
//       final returnCode = await session.getReturnCode();
//
//       if (ReturnCode.isSuccess(returnCode)) {
//         Log.d("SUCCESS@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//         MediaInformationSession session = await FFprobeKit.getMediaInformation(videoPath!);
//
//         final information = session.getMediaInformation()!;
//
//         Map<String, dynamic> params = {};
//
//         params["duration"] = (double.parse(information.getDuration()!) * 1000).toInt();
//         params["localPath"] = videoPath;
//         params["localSnapshotUrl"] = coverPath;
//         params["sourceType"] = SourceType.personal.name;
//         params["size"] = StringUtil.isNotEmpty(information.getSize()) ? int.tryParse(information.getSize()!) : 0;
//
//         return params;
//       } else if (ReturnCode.isCancel(returnCode)) {
//         Log.d("CANCEL@@@@@@@@@@@@@@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//         return null;
//       } else {
//         Log.d("ERROR@@@@@@@@@@2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//         return null;
//       }
//     });
//   }
//
//   /// 获取视频的封面
//   ///
//   /// [videoPath] 视频路径
//   ///
//   /// return [coverPath]
//   ///
//   static Future<String> getCoverPathFromVideo(String videoPath) async {
//     String coverPath;
//
//     coverPath = '${await FileUtil.getTempPath()}${DateTime.now().millisecondsSinceEpoch}.png';
//     await FileUtil.deleteFile(coverPath);
//
//     /// 生成图片
//     return FFmpegKit.execute('-i $videoPath -r 1 -frames:v 1 $coverPath').then((Session session) async {
//       final returnCode = await session.getReturnCode();
//
//       if (ReturnCode.isSuccess(returnCode)) {
//         // SUCCESS
//         return coverPath;
//       } else if (ReturnCode.isCancel(returnCode)) {
//         // CANCEL
//         return '';
//       } else {
//         // ERROR
//         return '';
//       }
//     });
//   }
//
//   /// 获取音频的时长
//   ///
//   /// [audioPath] 音频路径
//   ///
//   /// return [duration]
//   ///
//   static Future<int> getDurationFromAudio(String audioPath) async {
//     final information = await getMediaInformation(audioPath);
//     return (double.tryParse(information?.getDuration() ?? '0')! * 1000).toInt();
//   }
//
//   /// 获取多媒体文件信息
//   ///
//   /// [path] 文件路径
//   ///
//   /// return [MediaInformation]
//   ///
//   static Future<MediaInformation?> getMediaInformation(String path) async {
//     MediaInformationSession session = await FFprobeKit.getMediaInformation(path);
//
//     return session.getMediaInformation();
//   }
//
//   /// 抽取视频的音频
//   ///
//   /// [videoPath] 视频路径
//   ///
//   /// return [coverPath]
//   ///
//   static Future<List<dynamic>> getAudioFromVideo(String videoPath) async {
//     String audioPath;
//
//     audioPath = '${await FileUtil.getTempPath()}/${DateTime.now().microsecondsSinceEpoch}.aac';
//     await FileUtil.deleteFile(audioPath);
//
//     /// 抽取音频
//     return FFmpegKit.execute('-i $videoPath -vn -y -acodec copy $audioPath').then((Session session) async {
//       final returnCode = await session.getReturnCode();
//
//       if (ReturnCode.isSuccess(returnCode)) {
//         Log.d("SUCCESS@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//         MediaInformationSession mediaInformationSession = await FFprobeKit.getMediaInformation(videoPath);
//
//         final information = mediaInformationSession.getMediaInformation()!;
//
//         return [audioPath, (double.parse(information.getDuration()!) * 1000).toInt()];
//       } else if (ReturnCode.isCancel(returnCode)) {
//         Log.d("CANCEL@@@@@@@@@@@@@@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//         return [];
//       } else {
//         Log.d("ERROR@@@@@@@@@@2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//         return [];
//       }
//     });
//   }
//
//   /// 合并多个音频文件
//   ///
//   /// [audiosPath] 输入文件数组
//   /// [outPutPath] 输出文件路径
//   ///
//   static Future<int> copyAudios(List<String> audiosPath, String outPutPath) async {
//     String command = '-i "concat:${audiosPath.map((e) => e).toList().join("|")}" -acodec copy $outPutPath';
//
//     // command =
//     //     "${audiosPath.map((e) => '-i $e').toList().join(" ")} -filter_complex amix=inputs=${audiosPath.length}:duration=first:dropout_transition=2 -f m4a $outPutPath";
//
//     Log.d(command);
//
//     return await FFmpegKit.execute(command).then((session) async {
//       int s = await getDurationFromAudio(outPutPath);
//       Log.d("------------->$s");
//       return s;
//     });
//   }
//
//   /// 合并媒体文件
//   ///
//   /// [audioPath] 音频文件
//   /// [bgAudioPath]
//   /// [comAudioPath]
//   /// [localPath]
//   /// [dubbingVideoPath]
//   ///
//   static Future<bool> mergeMediaFiles(
//       String audioPath, String bgAudioPath, String comAudioPath, String localPath, String dubbingVideoPath) async {
//     /// 先合并两个音频-f mp3   -c:a libmp3lame
//     return FFmpegKit.execute(
//             '-y -i $audioPath -i $bgAudioPath  -filter_complex "[0:0][1:0] amix=inputs=2:duration=longest" $comAudioPath')
//         .then((Session session) async {
//       final returnCode = await session.getReturnCode();
//
//       if (ReturnCode.isSuccess(returnCode)) {
//         Log.d("SUCCESS@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//         int videoRes = (await FFmpegKit.execute(
//                 '-i $localPath -i $comAudioPath -c:v copy -c:a aac -strict experimental  -map 0:v:0 -map 1:a:0 $dubbingVideoPath'))
//             as int;
//         Log.d('音视频合并结果 = $videoRes');
//         if (videoRes == 0) {
//           showToast(text: "配音完成");
//           Log.d('合并音视频成功');
//           return true;
//         } else {
//           showToast(text: "配音失败");
//           Log.e('合并音视频失败');
//           return false;
//         }
//       } else if (ReturnCode.isCancel(returnCode)) {
//         Log.d("CANCEL@@@@@@@@@@@@@@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//         showToast(text: "配音失败");
//         Log.e('合并音频失败');
//         return false;
//       } else {
//         Log.d("ERROR@@@@@@@@@@2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//         showToast(text: "配音失败");
//         Log.e('合并音频失败');
//         return false;
//       }
//     });
//   }
//
//   /// 获取视频多帧图片列表
//   ///
//   /// [context] 上下文
//   /// [videoPath] 视频路径
//   /// [count] 视频帧数
//   /// [duration] 视频时长
//   ///
//   static Future<List<String>> getCoverListFromVideo(
//       BuildContext context, String videoPath, int duration, int count) async {
//     List<String> pictureList = [];
//     int s = duration ~/ count;
//     try {
//       for (int i = 0; i < count; i++) {
//         String localSnapshotUrl = '${await FileUtil.getTempPath()}/cover_$i.png';
//         await FileUtil.deleteFile(localSnapshotUrl);
//         int startSecond = s * (i + 1);
//         String startSecondStr = '';
//         int seconds = startSecond ~/ 1000;
//         if (seconds < 60) {
//           if (seconds < 10) {
//             startSecondStr = '00:00:0$seconds';
//           } else {
//             startSecondStr = '00:00:$seconds';
//           }
//         } else {
//           int min = seconds ~/ 60;
//           if (min < 60) {
//             if (min < 10) {
//               startSecondStr = '00:00:0$min';
//             } else {
//               startSecondStr = '00:$min:00';
//             }
//           }
//         }
//         Log.d('时间：$startSecondStr');
//
//         FFmpegKit.execute('-i $videoPath -r 1 -ss $startSecondStr -frames:v 1 $localSnapshotUrl')
//             .then((Session session) async {
//           final returnCode = await session.getReturnCode();
//
//           if (ReturnCode.isSuccess(returnCode)) {
//             // SUCCESS
//             pictureList.add(localSnapshotUrl);
//           } else if (ReturnCode.isCancel(returnCode)) {
//             // CANCEL
//             showToast(text: "选择出错");
//           } else {
//             // ERROR
//             showToast(text: "选择出错");
//           }
//         });
//       }
//
//       if (pictureList.isEmpty) {
//         String path = await getCoverPathFromVideo(videoPath);
//         if (path.isEmpty) {
//           showToast(text: "选择出错");
//           return [];
//         } else {
//           return [path];
//         }
//       } else {
//         return pictureList;
//       }
//     } catch (error) {
//       String path = await getCoverPathFromVideo(videoPath);
//       if (path.isEmpty) {
//         showToast(text: "选择出错");
//         return [];
//       } else {
//         return [path];
//       }
//     }
//   }
//
//   static Future<String> saveTrimmedVideo(String videoPath,
//       {required double startValue,
//       required double endValue,
//       bool applyVideoEncoding = false,
//       FileFormat? outputFormat,
//       String? ffmpegCommand,
//       String? customVideoFormat,
//       int? fpsGIF,
//       int? scaleGIF,
//       String? videoFolderName,
//       String? videoFileName,
//       StorageDir? storageDir}) async {
//     final String videoName = basename(videoPath).split('.')[0];
//
//     // Formatting Date and Time
//     String dateTime = DateTime.now().microsecondsSinceEpoch.toString();
//
//     Log.d("DateTime: $dateTime");
//
//     videoFolderName ??= "Trimmer";
//
//     videoFileName ??= "${videoName}_trimmed:$dateTime";
//
//     videoFileName = videoFileName.replaceAll(' ', '_');
//
//     String path = await _createFolderInAppDocDir(videoFolderName, storageDir)
//         .whenComplete(() => Log.d("Retrieved Trimmer folder"));
//
//     Duration startPoint = Duration(milliseconds: startValue.toInt());
//     Duration endPoint = Duration(milliseconds: endValue.toInt());
//
//     // Checking the start and end point strings
//     Log.d("Start: ${startPoint.toString()} & End: ${endPoint.toString()}");
//
//     Log.d(path);
//
//     String? outputFormatString;
//
//     if (outputFormat == null) {
//       outputFormat = FileFormat.mp4;
//       outputFormatString = outputFormat.toString();
//       Log.d('OUTPUT: $outputFormatString');
//     } else {
//       outputFormatString = outputFormat.toString();
//     }
//
//     String trimLengthCommand =
//         ' -ss $startPoint -i "$videoPath" -t ${endPoint - startPoint} -avoid_negative_ts make_zero ';
//
//     String command;
//
//     if (ffmpegCommand == null) {
//       command = '$trimLengthCommand -c:a copy ';
//
//       if (!applyVideoEncoding) {
//         command += '-c:v copy ';
//       }
//
//       if (outputFormat == FileFormat.gif) {
//         fpsGIF ??= 10;
//         scaleGIF ??= 480;
//         command =
//             '$trimLengthCommand -vf "fps=$fpsGIF,scale=$scaleGIF:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 ';
//       }
//     } else {
//       command = '$trimLengthCommand $ffmpegCommand ';
//       outputFormatString = customVideoFormat;
//     }
//
//     String outputPath = '$path$videoFileName$outputFormatString';
//
//     command += '"$outputPath"';
//
//     await FFmpegKit.execute(command).whenComplete(() {
//       Log.d('Got value');
//       Log.d('Video successfuly saved');
//     });
//
//     return outputPath;
//   }
//
//   static Future<String> _createFolderInAppDocDir(String folderName, StorageDir? storageDir) async {
//     Directory? directory;
//
//     if (storageDir == null) {
//       directory = await getApplicationDocumentsDirectory();
//     } else {
//       switch (storageDir.toString()) {
//         case 'temporaryDirectory':
//           directory = await getTemporaryDirectory();
//           break;
//
//         case 'applicationDocumentsDirectory':
//           directory = await getApplicationDocumentsDirectory();
//           break;
//
//         case 'externalStorageDirectory':
//           directory = await getExternalStorageDirectory();
//           break;
//       }
//     }
//
//     // Directory + folder name
//     final Directory directoryFolder = Directory('${directory!.path}/$folderName/');
//
//     if (await directoryFolder.exists()) {
//       // If folder already exists return path
//       Log.d('Exists');
//       return directoryFolder.path;
//     } else {
//       Log.d('Creating');
//       // If folder does not exists create folder and then return its path
//       final Directory directoryNewFolder = await directoryFolder.create(recursive: true);
//       return directoryNewFolder.path;
//     }
//   }
// }
