import 'package:rto_assmant/database/database_helper.dart';

class RewardService {
  final DatabaseHelper _dbHelper;

  RewardService({DatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  /// Helper to calculate the ISO week string (e.g., '2026-W29') for a given date.
  String getIsoWeekString(DateTime date) {
    // Find Thursday of this week (ISO 8601 standard week starts on Monday)
    final thursday = date.add(Duration(days: 3 - ((date.weekday - 1) % 7)));
    final jan1 = DateTime(thursday.year, 1, 1);
    final weekNum = ((thursday.difference(jan1).inDays) / 7).floor() + 1;
    return "${thursday.year}-W${weekNum.toString().padLeft(2, '0')}";
  }

  /// Distributes weekly rewards if they haven't been distributed for the given [weekDate].
  /// Returns a Map containing:
  /// - 'rewarded': bool (whether the reward was newly granted)
  /// - 'rank': int (the user's weekly rank at the time of reset)
  /// - 'diamondsAdded': int (amount of diamonds added)
  Future<Map<String, dynamic>> checkAndDistributeWeeklyReward({
    required DateTime weekDate,
    required int userRank,
  }) async {
    final db = await _dbHelper.database;
    final weekStr = getIsoWeekString(weekDate);

    // Retrieve user details
    final List<Map<String, dynamic>> users = await db.query('Users', limit: 1);
    if (users.isEmpty) {
      return {'rewarded': false, 'rank': 0, 'diamondsAdded': 0};
    }

    final user = users.first;
    final lastRewardWeek = user['last_reward_week'] as String? ?? '';
    final currentDiamonds = user['diamonds'] as int? ?? 0;
    final currentGems = user['gems'] as int? ?? 0;

    // Check if reward was already processed/distributed for this week
    if (lastRewardWeek == weekStr) {
      return {
        'rewarded': false,
        'rank': user['weekly_rank'] as int? ?? 0,
        'diamondsAdded': 0
      };
    }

    bool isTop10 = userRank >= 1 && userRank <= 10;
    int diamondsToAdd = isTop10 ? 100 : 0;

    // Update database
    await db.update(
      'Users',
      {
        'diamonds': currentDiamonds + diamondsToAdd,
        'gems': currentGems + diamondsToAdd, // Keep gems and diamonds synced/updated
        'last_reward_week': weekStr,
        'weekly_rank': userRank,
        'reward_claimed': isTop10 ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [1],
    );

    return {
      'rewarded': isTop10,
      'rank': userRank,
      'diamondsAdded': diamondsToAdd,
    };
  }
}
