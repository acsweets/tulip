// import 'dart:convert' as convert;
//
// import 'package:cses_common/config/index.dart';
// import 'package:cses_common/net/http_manager.dart';
// import 'package:cses_common/net/socket/socket_factory.dart';
// import 'package:flutter/foundation.dart';
//
// /// 输出Log工具类
// class Log {
//   static d(Object msg, {eventName = 'WHY-LOG', action = '   d   '}) {
//     _print(msg, eventName: eventName, action: action);
//   }
//
//   static i(String msg, {eventName = 'WHY-LOG', action = '   i   '}) {
//     _print(msg, eventName: eventName, action: action);
//   }
//
//   static e(String msg, {eventName = 'WHY-LOG', action = '   e   '}) {
//     _print(msg, eventName: eventName, action: action);
//   }
//
//   static json(Map<String, dynamic> msg, {eventName = 'WHY-LOG', action = '   json   '}) {
//     _print(convert.json.encode(msg), eventName: eventName, action: action);
//   }
//
//   static _print(Object? msg, {eventName = 'X-LOG', action = '   v   '}) {
//     /// 单元测试不必初始化Log工具类，直接使用print输出。
//     if (kDebugMode && msg != null) {
//       String message = msg.toString();
//       if (message.isNotEmpty && message.length > 512) {
//         debugPrint("$eventName $action ${message.substring(0, 512)}");
//         message = message.substring(512, message.length);
//         while (message.isNotEmpty) {
//           if (message.length > 512) {
//             debugPrint(message.substring(0, 512));
//             message = message.substring(512, message.length);
//           } else {
//             debugPrint(message.toString());
//             message = "";
//           }
//         }
//       } else {
//         debugPrint("$eventName $action $message");
//       }
//     }
//   }
//
//   static info(String info, {String eventName = 'INFO-LOG', String action = '', Map<String, dynamic>? properties}) {
//     d(info, eventName: eventName, action: action);
//
//     postLogService(info, eventName: eventName, action: action, properties: properties, level: 'INFO');
//   }
//
//   static error(String error, {String eventName = 'ERROR-LOG', String action = '', Map<String, dynamic>? properties}) {
//     e(error, eventName: eventName, action: action);
//
//     postLogService(error, eventName: eventName, action: action, properties: properties, level: 'ERROR');
//   }
//
//   static void postLogService(String error,
//       {String eventName = '', String action = '', Map<String, dynamic>? properties, String? level}) {
//     properties ??= {};
//     properties['level'] = level;
//     properties['eventName'] = eventName;
//     properties['action'] = action;
//     properties['content'] = error;
//     properties['userId'] = User().userId;
//     properties['userName'] = User().userName;
//     properties['cookieId'] = Context().cookieId;
//     properties['companyId'] = User().companyId;
//     properties['datetime'] = DateTime.now().toString();
//     properties['socketState'] = SocketFactory().status().name;
//
//     if (Context().trace) HttpManager().post('/Diagnostic/tracelog', params: properties);
//   }
// }
