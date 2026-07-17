import 'dart:convert';
import 'dart:io';

void main() {
  List<Map<String, dynamic>> categories = [
    {"id": 1, "name": "Science", "iconName": "science_outlined", "colorHex": "FF00E5FF"},
    {"id": 2, "name": "Mathematics", "iconName": "calculate_outlined", "colorHex": "FFE040FB"},
    {"id": 3, "name": "History", "iconName": "history_edu", "colorHex": "FFFF4081"},
    {"id": 4, "name": "Technology", "iconName": "computer", "colorHex": "FF18FFFF"},
    {"id": 5, "name": "Geography", "iconName": "public", "colorHex": "FF64FFDA"},
    {"id": 6, "name": "General Knowledge", "iconName": "lightbulb_outline", "colorHex": "FFFFD740"}
  ];

  List<Map<String, dynamic>> questions = [];
  int qId = 1;

  for (var cat in categories) {
    for (int i = 1; i <= 50; i++) {
      questions.add({
        "id": qId,
        "categoryId": cat["id"],
        "quizId": 1,
        "question": "Sample \${cat['name']} Question \$i",
        "optionA": "Option A \${100 + i}",
        "optionB": "Option B \${200 + i}",
        "optionC": "Option C \${300 + i}",
        "optionD": "Option D \${400 + i}",
        "correctAnswer": "optionA",
        "explanation": "This is the explanation for \${cat['name']} question \$i.",
        "difficulty": i % 3 == 0 ? "hard" : (i % 2 == 0 ? "medium" : "easy"),
        "rewardCoins": 20,
        "rewardXP": 10
      });
      qId++;
    }
  }

  Map<String, dynamic> data = {
    "categories": categories,
    "questions": questions
  };

  File('assets/data/questions.json').writeAsStringSync(jsonEncode(data));
  print("Generated 300 questions in assets/data/questions.json");
}
