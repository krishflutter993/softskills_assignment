class QuestionModel {
  final int id;
  final int categoryId;
  final String? category;
  final int quizId;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String difficulty;
  final int rewardCoins;
  final int rewardXP;
  final String explanation;
  final bool isBookmark;
  final bool isFavorite;

  QuestionModel({
    required this.id,
    required this.categoryId,
    this.category,
    required this.quizId,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.difficulty,
    required this.rewardCoins,
    required this.rewardXP,
    required this.explanation,
    this.isBookmark = false,
    this.isFavorite = false,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'],
      categoryId: map['categoryId'],
      category: map['category'],
      quizId: map['quizId'],
      question: map['question'],
      options: [
        map['optionA'],
        map['optionB'],
        map['optionC'],
        map['optionD'],
      ],
      correctAnswer: map['correctAnswer'],
      difficulty: map['difficulty'],
      rewardCoins: map['rewardCoins'] ?? 20,
      rewardXP: map['rewardXP'] ?? 10,
      explanation: map['explanation'] ?? '',
      isBookmark: map['isBookmark'] == 1,
      isFavorite: map['isFavorite'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'category': category,
      'quizId': quizId,
      'question': question,
      'optionA': options[0],
      'optionB': options[1],
      'optionC': options[2],
      'optionD': options[3],
      'correctAnswer': correctAnswer,
      'difficulty': difficulty,
      'rewardCoins': rewardCoins,
      'rewardXP': rewardXP,
      'explanation': explanation,
      'isBookmark': isBookmark ? 1 : 0,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }
}
