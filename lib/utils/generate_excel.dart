// import 'dart:typed_data';
//
// import 'package:cses_common/utils/toast_util.dart';
// import 'package:document_file_save_plus/document_file_save_plus.dart';
// import 'package:syncfusion_flutter_xlsio/xlsio.dart';
//
// /// 生成EXCEL表并切保存到本地，Android 保存到本地/Download/的文件夹下
// Future<void> generateExcel(
//   String excelName,
//   List<List<String>> dataList,
//   List<String> columnList,
// ) async {
//   // 创建一个Excel
//   final Workbook workbook = Workbook();
//   final Worksheet sheet = workbook.worksheets[0];
//
//   /// 设置标题
//   for (int i = 0; i < columnList.length; i++) {
//     sheet.getRangeByName(excelHeader[i]).columnWidth = 20.0;
//     sheet.getRangeByName(excelHeader[i]).setText(columnList[i]);
//   }
//
//   /// 循环取数据
//   for (int i = 0; i < dataList.length; i++) {
//     int index = 1;
//
//     for (var element in dataList[i]) {
//       sheet.getRangeByIndex(i + 2, index).setText(element);
//       index++;
//     }
//   }
//
//   List<int> bytes = workbook.saveAsStream();
//
//   // Save single Excel file
//   await DocumentFileSavePlus().saveFile(Uint8List.fromList(bytes), excelName, "application/xlsx").then((value) async {
//     showToast(text: '保存成功');
//   });
//   workbook.dispose();
// }
//
// List excelHeader = [
//   'A1',
//   'B1',
//   'C1',
//   'D1',
//   'E1',
//   'F1',
//   'G1',
//   'H1',
//   'I1',
//   'J1',
//   'K1',
//   'L1',
//   'M1',
//   'N1',
//   'O1',
//   'P1',
//   'Q1',
//   'R1',
//   'S1',
//   'T1',
//   'U1',
//   'V1',
//   'W1',
//   'X1',
//   'Y1',
//   'Z1'
// ];
