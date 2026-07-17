import 'package:rto_assmant/database/database_helper.dart';
import 'package:rto_assmant/services/leaderboard_service.dart';
import 'package:rto_assmant/services/reward_service.dart';

class WeeklyResetService {
  final DatabaseHelper _dbHelper;
  final LeaderboardService _leaderboardService;
  final RewardService _rewardService;

  WeeklyResetService({
    DatabaseHelper? dbHelper,
    LeaderboardService? leaderboardService,
    RewardService? rewardService,
  })  : _dbHelper = dbHelper ?? DatabaseHelper.instance,
        _leaderboardService = leaderboardService ?? LeaderboardService(),
        _rewardService = rewardService ?? RewardService();

  /// Checks if a weekly reset is needed.
  /// If the current week is different from [last_reward_week] stored in DB,
  /// it calculates the rank, distributes rewards, resets the weekly score to 0,
  /// and updates the week identifier.
  Future<bool> checkAndProcessWeeklyReset() async {
    final db = await _dbHelper.database;
    final now = DateTime.now();
    final currentWeekStr = _rewardService.getIsoWeekString(now);

    final List<Map<String, dynamic>> users = await db.query('Users', limit: 1);
    if (users.isEmpty) return false;

    final user = users.first;
    final lastRewardWeek = user['last_reward_week'] as String? ?? '';
    final weeklyScore = user['weekly_score'] as int? ?? 0;

    // First launch setup: initialize last_reward_week without rewarding
    if (lastRewardWeek.isEmpty) {
      await db.update(
        'Users',
        {
          'last_reward_week': currentWeekStr,
          'weekly_score': 0,
          'weekly_rank': 0,
          'reward_claimed': 0,
        },
        where: 'id = ?',
        whereArgs: [1],
      );
      return true;
    }

    // If it's a new week
    if (lastRewardWeek != currentWeekStr) {
      // 1. Calculate user's final rank based on the score they accumulated
      final userRank = _leaderboardService.calculateUserWeeklyRank(
        currentUserWeeklyScore: weeklyScore,
        equippedSkinPath: 'assets/images/owl.png', // Fallback defaults
        equippedBgPath: 'assets/Theme/screen.png',
      );

      // 2. Distribute rewards (updates weekly_rank, reward_claimed, last_reward_week, and diamonds)
      // Note: we pass a representative date from the previous week (e.g. now minus 7 days)
      final pastWeekDate = now.subtract(const Duration(days: 7));
      await _rewardService.checkAndDistributeWeeklyReward(
        weekDate: pastWeekDate,
        userRank: userRank,
      );

      // 3. Reset weekly score for the new week, while keeping reward/rank info
      await db.update(
        'Users',
        {
          'weekly_score': 0,
          'last_reward_week': currentWeekStr, // Update to the current week
        },
        where: 'id = ?',
        whereArgs: [1],
      );

      return true;
    }

    return false;
  }
}
