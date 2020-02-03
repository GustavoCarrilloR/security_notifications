import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:security_notifications/model/notification_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database _database;

  static final DatabaseHelper db = DatabaseHelper._();

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "security_notifications.db";
    return await openDatabase(path, version: 1, onOpen: (_db) {},
        onCreate: (Database _db, int version) async {
      await _db.execute("CREATE TABLE notifications ("
          "notificationId TEXT PRIMARY KEY,"
          "notificationType TEXT,"
          "notificationTitle TEXT,"
          "notificationBody TEXT,"
          "seen INTEGER,"
          "status INTEGER"
          ")");
    });
  }

  void closeDatabase() async {
    await _database.close();
  }

  Future<int> addNewNotification(NotificationModel notificationModel) async {
    final _db = await database;
    var res;
    if (_db != null && _db.isOpen) {
      try {
        await _db.transaction((Transaction txn) async {
          res = await txn.rawInsert(
              'INSERT Into notifications (notificationId,notificationType,notificationTitle,notificationBody,seen, status) '
              'VALUES ("${notificationModel.notificationId}","${notificationModel.notificationType}","${notificationModel.notificationTitle}","${notificationModel.notificationBody}",${notificationModel.seen ? 1 : 0},${notificationModel.status})');
        });
      } catch (e) {
        print("Error while performing transaction $e");
      }
    }
    return res;
  }

  Future<int> countNotifications(String notificationType) async {
    final _db = await database;
    int count = 0;
    try {
      if (_db != null && _db.isOpen) {
        count = Sqflite.firstIntValue(await _db.rawQuery(
            'SELECT COUNT(*) FROM notifications WHERE notificationType == "$notificationType" AND status != 0 AND seen == 0'));
      }
    } catch (e) {
      print("Error while searching notifications $e");
    }
    return count;
  }

  Future<List<Map<String, dynamic>>> getRecords(String notificationType) async {
    final _db = await database;
    List<Map<String, dynamic>> maps = [];

    if (_db != null && _db.isOpen) {
      try {
        await _db.transaction((Transaction txn) async {
          maps = await txn.rawQuery(
              'SELECT * FROM notifications WHERE notificationType == "$notificationType" AND status != 0');
        });
      } catch (e) {
        print("Error while performing selection of records");
      }
    }
    return maps;
  }

  Future<bool> existRecord(String notificationId) async {
    final _db = await database;

    if (_db != null && _db.isOpen) {
      int count = 0;
      try {
        if (_db != null && _db.isOpen) {
          count = Sqflite.firstIntValue(await _db.rawQuery(
              'SELECT COUNT(*) FROM notifications WHERE notificationId == "$notificationId"'));
        }
        return count > 0;
      } catch (e) {
        print("Error while searching notification $e");
      }
    }

    return false;
  }

  void updateNotification(NotificationModel notificationModel) async {
    final _db = await database;
    if (_db != null && _db.isOpen) {
      try {
        await _db.update("notifications", notificationModel.toMap(),
            where: "notificationId = ?",
            whereArgs: [notificationModel.notificationId]);
      } catch (e) {
        print("Error while updating record");
      }
    }
  }
}
