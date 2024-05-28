class BlockedApp {
  final int id;
  final String name;
  final String packgeName;
  final int blockStartTime;
  final int blockEndTime;
  final List<int> blockDays;

  BlockedApp({
    required this.id,
    required this.name,
    required this.packgeName,
    required this.blockStartTime,
    required this.blockEndTime,
    required this.blockDays,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'packgeName': packgeName,
      'blockStartTime': blockStartTime,
      'blockEndTime': blockEndTime,
      'blockDays': blockDays.join(','),
    };
  }
}
