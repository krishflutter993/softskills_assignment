class UserModel {
  final int? id;
  final String name;
  final String email;
  final String avatar;
  final int coins;
  final int gems;
  final int xp;
  final int currentLevel;
  final int highestLevel;
  final String selectedCharacter;
  final String selectedSkin;
  final int dailyStreak;
  final int longestStreak;
  final int quizScore;
  final int highestScore;

  UserModel({
    this.id,
    required this.name,
    this.email = '',
    this.avatar = '',
    this.coins = 0,
    this.gems = 0,
    this.xp = 0,
    this.currentLevel = 1,
    this.highestLevel = 1,
    this.selectedCharacter = 'owl',
    this.selectedSkin = 'default',
    this.dailyStreak = 0,
    this.longestStreak = 0,
    this.quizScore = 0,
    this.highestScore = 0,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'] ?? '',
      avatar: map['avatar'] ?? '',
      coins: map['coins'] ?? 0,
      gems: map['gems'] ?? 0,
      xp: map['xp'] ?? 0,
      currentLevel: map['currentLevel'] ?? 1,
      highestLevel: map['highestLevel'] ?? 1,
      selectedCharacter: map['selectedCharacter'] ?? 'owl',
      selectedSkin: map['selectedSkin'] ?? 'default',
      dailyStreak: map['dailyStreak'] ?? 0,
      longestStreak: map['longestStreak'] ?? 0,
      quizScore: map['quizScore'] ?? 0,
      highestScore: map['highestScore'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'coins': coins,
      'gems': gems,
      'xp': xp,
      'currentLevel': currentLevel,
      'highestLevel': highestLevel,
      'selectedCharacter': selectedCharacter,
      'selectedSkin': selectedSkin,
      'dailyStreak': dailyStreak,
      'longestStreak': longestStreak,
      'quizScore': quizScore,
      'highestScore': highestScore,
    };
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? avatar,
    int? coins,
    int? gems,
    int? xp,
    int? currentLevel,
    int? highestLevel,
    String? selectedCharacter,
    String? selectedSkin,
    int? dailyStreak,
    int? longestStreak,
    int? quizScore,
    int? highestScore,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      coins: coins ?? this.coins,
      gems: gems ?? this.gems,
      xp: xp ?? this.xp,
      currentLevel: currentLevel ?? this.currentLevel,
      highestLevel: highestLevel ?? this.highestLevel,
      selectedCharacter: selectedCharacter ?? this.selectedCharacter,
      selectedSkin: selectedSkin ?? this.selectedSkin,
      dailyStreak: dailyStreak ?? this.dailyStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      quizScore: quizScore ?? this.quizScore,
      highestScore: highestScore ?? this.highestScore,
    );
  }
}
