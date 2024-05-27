import '../models/blocked_app.dart';
import 'db_helper.dart';

class BlockService {
  final dbHelper = DatabaseHelper.instance;

  Future<void> blockApp(String name, String packgeName, int blockStartTime, int blockEndTime, List<int> blockDays) async {
    BlockedApp app = BlockedApp(
      id: 0,
      name: name,
      packgeName: packgeName,
      blockStartTime: blockStartTime,
      blockEndTime: blockEndTime,
      blockDays: blockDays,
    );
    await dbHelper.insertBlockedApp(app);
  }

  Future<List<BlockedApp>> getBlockedApps() async {
    return await dbHelper.getBlockedApps();
  }

  Future<void> removeBlockedApp(int id) async {
    await dbHelper.deleteBlockedApp(id);
  }
}
