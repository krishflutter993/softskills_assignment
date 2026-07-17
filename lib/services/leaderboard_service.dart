class LeaderboardService {
  LeaderboardService();

  /// Returns the current list of players sorted by weekly score.
  /// Dynamically updates the current user's entry using [currentUserWeeklyScore]
  /// and their equipped skin details.
  List<Map<String, dynamic>> calculateWeeklyLeaderboard({
    required int currentUserWeeklyScore,
    required String equippedSkinPath,
    required String equippedBgPath,
  }) {
    final List<Map<String, dynamic>> weeklyPlayers = [
      {
        'name': 'Arjun',
        'score': 2150,
        'image': 'assets/images/owl.png',
        'background': 'assets/Theme/screen.png',
        'isCurrentUser': false
      },
      {
        'name': 'Priya',
        'score': 2100,
        'image': 'assets/images/owl.png',
        'background': 'assets/Theme/screen.png',
        'isCurrentUser': false
      },
      {
        'name': 'Rohan',
        'score': 1950,
        'image': 'assets/images/owl.png',
        'background': 'assets/Theme/screen.png',
        'isCurrentUser': false
      },
      {
        'name': 'Sneha',
        'score': 1700,
        'image': 'assets/images/owl.png',
        'background': 'assets/Theme/screen.png',
        'isCurrentUser': false
      },
      {
        'name': 'Karan',
        'score': 1500,
        'image': 'assets/images/owl.png',
        'background': 'assets/Theme/screen.png',
        'isCurrentUser': false
      },
      {
        'name': 'Meera',
        'score': 1200,
        'image': 'assets/images/owl.png',
        'background': 'assets/Theme/screen.png',
        'isCurrentUser': false
      },
      {
        'name': 'Player (You)',
        'score': currentUserWeeklyScore,
        'image': equippedSkinPath,
        'background': equippedBgPath,
        'isCurrentUser': true
      },
    ];

    // Sort by score descending
    weeklyPlayers.sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));

    // Assign 1-based rank
    for (int i = 0; i < weeklyPlayers.length; i++) {
      weeklyPlayers[i]['rank'] = i + 1;
    }

    return weeklyPlayers;
  }

  /// Calculates the user's rank on the weekly leaderboard
  int calculateUserWeeklyRank({
    required int currentUserWeeklyScore,
    required String equippedSkinPath,
    required String equippedBgPath,
  }) {
    final players = calculateWeeklyLeaderboard(
      currentUserWeeklyScore: currentUserWeeklyScore,
      equippedSkinPath: equippedSkinPath,
      equippedBgPath: equippedBgPath,
    );

    final userEntry = players.firstWhere((p) => p['isCurrentUser'] == true);
    return userEntry['rank'] as int;
  }
}
