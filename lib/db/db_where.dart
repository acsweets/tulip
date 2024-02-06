// import 'dart:async';
//
// import 'package:cses_saas/cses_saas.dart';
//
// const String MEMBER_ID = 'id';
// const String MEMBER_USER_ID = "userId";
// const String MEMBER_USER_NAME = "userName";
// const String MEMBER_TAG_INDEX = 'tagIndex';
// const String MEMBER_REAL_NAME = "name";
// const String MEMBER_COMPANY_ID = "companyId";
// const String MEMBER_ORG_ID = "orgId";
// const String MEMBER_ORG_NAME = "orgName";
// const String MEMBER_MOBILE = "mobile";
// const String MEMBER_CREATED_AT = "createdAt";
// const String MEMBER_UPDATED_AT = "updatedAt";
// const String MEMBER_URI = "uri";
// const String MEMBER_ORG_TYPE = "orgType";
//
// const String tableMember = 'member';
//
// class MemberDBHelper {
//   /// 增加公司成员
//   static Future<int> insertFromCompany(MemberEntity member) async {
//     var db = await DatabaseHelper().openDb();
//
//     final List<Map<String, dynamic>> maps = await db.query(tableMember,
//         where: '$MEMBER_COMPANY_ID = ? AND $MEMBER_USER_ID = ?', whereArgs: [member.companyId, member.userId]);
//     if (maps.isNotEmpty) {
//       int? _id = maps.first[MEMBER_ID];
//       if (maps.length > 1) {
//         for (var element in maps) {
//           if (element[MEMBER_ID] != _id) await deleteById(element[MEMBER_ID]);
//         }
//       }
//       Log.d("update member from Company @@@@@@@@@@@@@@@@@@@@${member.toDBMap()}");
//       return await db
//           .update(tableMember, member.toDBMap(), where: '$MEMBER_ID = ?', whereArgs: [maps.first[MEMBER_ID]]);
//     } else {
//       Log.d("insert member from Company @@@@@@@@@@@@@@@@@@@@${member.toDBMap()}");
//       return await db.insert(tableMember, member.toDBMap(), conflictAlgorithm: ConflictAlgorithm.replace);
//     }
//   }
//
//   /// 获取公司用户列表
//   static Future<List<MemberEntity>> queryAllByCompanyId(
//       {bool includeMe = false, List<String> excluding = const []}) async {
//     var db = await DatabaseHelper().openDb();
//     final List<Map<String, dynamic>> maps = await db.query(tableMember,
//         where:
//         "$MEMBER_COMPANY_ID = ? AND $MEMBER_USER_ID <> ? AND $MEMBER_USER_ID NOT IN ('${excluding.join("','")}')",
//         whereArgs: [User().companyId, includeMe ? "" : User().userId]);
//     return List.generate(maps.length, (i) {
//       Log.d("queryAllByCompanyId@@@@@@@@@@@@@@@@@@@======${i + 1}=>${maps[i].toString()}");
//       return MemberEntity.fromListDBMap(maps[i]);
//     });
//   }
//
//   /// 删除公司用户列表
//   static Future<int> deleteAllByCompanyId(String companyId) async {
//     Log.d("deleteAllByCompanyId@@@@@@@@@@@@@@@@@@@@$companyId");
//     var db = await DatabaseHelper().openDb();
//     return await db.delete(tableMember, where: "$MEMBER_COMPANY_ID = ?", whereArgs: [companyId]);
//   }
//
//   /// 根据ID删除成员
//   static Future<int> deleteById(int? id) async {
//     Log.d("deleteById@@@@@@@@@@@@@@@@@@@@$id");
//     var db = await DatabaseHelper().openDb();
//     return await db.delete(tableMember, where: '$MEMBER_ID = ?', whereArgs: [id]);
//   }
//
//   /// 根据用户ID删除成员
//   static Future<int> deleteByUserId(String userId) async {
//     Log.d("deleteByUserId@@@@@@@@@@@@@@@@@@@@$userId");
//     var db = await DatabaseHelper().openDb();
//     return await db.delete(tableMember,
//         where: '$MEMBER_USER_ID = ? AND $MEMBER_COMPANY_ID = ?', whereArgs: [userId, User().companyId]);
//   }
//
//   /// 查询最近更新的一个用户
//   static Future<MemberEntity?> queryLastMember() async {
//     Log.d("queryLastMember@@@@@@@@@@@@@@@@@@@@");
//     var db = await DatabaseHelper().openDb();
//     final List<Map<String, dynamic>> maps = await db.query(tableMember,
//         orderBy: '$MEMBER_UPDATED_AT DESC', where: '$MEMBER_COMPANY_ID = ?', whereArgs: [User().companyId]);
//
//     if (maps.isNotEmpty) return MemberEntity.fromListDBMap(maps.first);
//
//     return null;
//   }
//
//   /// 搜索成员
//   ///
//   /// [keyword] 搜索关键字
//   ///
//   static Future<List<MemberEntity>> searchMembersFromCompany({String keyword = ""}) async {
//     var db = await DatabaseHelper().openDb();
//     final List<Map<String, dynamic>> maps = await db.rawQuery(
//         "SELECT * FROM $tableMember WHERE ($MEMBER_USER_NAME LIKE '%$keyword%' OR $MEMBER_ORG_NAME LIKE '%$keyword%' OR $MEMBER_REAL_NAME LIKE '%$keyword%' OR $MEMBER_MOBILE LIKE '%$keyword%') AND $MEMBER_COMPANY_ID = ?",
//         [User().companyId]);
//     return List.generate(maps.length, (i) {
//       return MemberEntity.fromListDBMap(maps[i]);
//     });
//   }
//
//   /// 根据用户ID查询用户
//   static Future<MemberEntity?> queryByUserId({String? userId}) async {
//     var db = await DatabaseHelper().openDb();
//     final List<Map<String, dynamic>> maps = await db.query(tableMember,
//         where: "$MEMBER_USER_ID = ? AND $MEMBER_COMPANY_ID = ?",
//         whereArgs: [userId ?? User().userId, User().companyId]);
//
//     if (maps.isNotEmpty) {
//       return MemberEntity.fromListDBMap(maps.first);
//     } else {
//       return null;
//     }
//   }
//
//   /// 根据用户ID查询用户是否在公司内
//   static Future<bool> queryByUserIdInCompany({String? userId}) async {
//     var db = await DatabaseHelper().openDb();
//     final List<Map<String, dynamic>> maps = await db.query(tableMember,
//         where: "$MEMBER_USER_ID = ? AND $MEMBER_COMPANY_ID = ?",
//         whereArgs: [userId ?? User().userId, User().companyId]);
//
//     return maps.isNotEmpty;
//   }
//
//   static Future<List<MemberEntity>> queryMembersByUserIds({required List<MemberEntity> users}) async {
//     var db = await DatabaseHelper().openDb();
//
//     List<MemberEntity> list = [];
//
//     for (var user in users) {
//       final List<Map<String, dynamic>> maps = await db.query(tableMember,
//           where: "$MEMBER_USER_ID = ? AND $MEMBER_COMPANY_ID = ?", whereArgs: [user.userId, User().companyId]);
//
//       if (maps.isNotEmpty) {
//         MemberEntity member = MemberEntity.fromListDBMap(maps.first);
//         list.add(member);
//       } else {
//         list.add(user);
//       }
//     }
//
//     return list;
//   }
// }
