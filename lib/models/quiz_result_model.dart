class QuizResult {
  final String category;
  final int score;
  final DateTime date;
  final int correctCount;
  final int totalQuestions;

  QuizResult({
    required this.category,
    required this.score,
    required this.date,
    required this.correctCount,
    required this.totalQuestions,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      category: json['category'],
      score: json['score'],
      date: DateTime.parse(json['date']),
      correctCount: json['correctCount'],
      totalQuestions: json['totalQuestions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'score': score,
      'date': date.toIso8601String(),
      'correctCount': correctCount,
      'totalQuestions': totalQuestions,
    };
  }
}
