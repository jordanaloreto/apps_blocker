import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/blocked_app.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;

  DatabaseHelper._instance();

  String blockedAppsTable = 'blocked_app_table';
  String colId = 'id';
  String colAppName = 'app_name';
  String colPackageName = 'package_name';
  String colBlockStartTime = 'block_start_time';
  String colBlockEndTime = 'block_end_time';
  String colBlockDays = 'block_days';

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'app_blocker.db');
    final appBlockerDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return appBlockerDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $blockedAppsTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colAppName TEXT, $colPackageName TEXT, $colBlockStartTime INTEGER, $colBlockEndTime INTEGER, $colBlockDays TEXT)',
    );
  }

  Future<int> insertBlockedApp(BlockedApp app) async {
    Database? db = await this.db;
    final int result = await db!.insert(blockedAppsTable, app.toMap());
    return result;
  }

  Future<List<BlockedApp>> getBlockedApps() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(blockedAppsTable);
    return result.map((item) => BlockedApp(
      id: item['id'],
      name: item['app_name'],
      packgeName: item['package_name'],
      blockStartTime: item['block_start_time'],
      blockEndTime: item['block_end_time'],
      blockDays: item['block_days'].split(',').map((e) => int.parse(e)).toList(),
    )).toList();
  }

  Future<int> deleteBlockedApp(int id) async {
    Database? db = await this.db;
    final int result = await db!.delete(blockedAppsTable, where: '$colId = ?', whereArgs: [id]);
    return result;
  }
}
