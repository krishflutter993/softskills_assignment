import 'dart:io';

void main() {
  final Map<String, int> categoryCounts = {
    'Science': 50,
    'Mathematics': 50,
    'History': 50,
    'Technology': 50,
    'Geography': 50,
    'General Knowledge': 100,
    'Flutter': 100,
    'Dart': 100,
    'Programming': 100,
    'SQL': 100,
    'Firebase': 75,
    'UIUX': 75,
    'Aptitude': 150,
    'Logical Reasoning': 100,
    'HR': 100,
    'Communication': 50,
    'Interview': 150,
  };

  final Map<String, String> fileNames = {
    'Science': 'science_questions.dart',
    'Mathematics': 'mathematics_questions.dart',
    'History': 'history_questions.dart',
    'Technology': 'technology_questions.dart',
    'Geography': 'geography_questions.dart',
    'General Knowledge': 'general_knowledge_questions.dart',
    'Flutter': 'flutter_questions.dart',
    'Dart': 'dart_questions.dart',
    'Programming': 'programming_questions.dart',
    'SQL': 'sql_questions.dart',
    'Firebase': 'firebase_questions.dart',
    'UIUX': 'uiux_questions.dart',
    'Aptitude': 'aptitude_questions.dart',
    'Logical Reasoning': 'logical_reasoning_questions.dart',
    'HR': 'hr_questions.dart',
    'Communication': 'communication_questions.dart',
    'Interview': 'interview_questions.dart',
  };

  final dir = Directory('lib/data/categories');
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }

  int globalId = 1;
  int categoryId = 1;

  final List<String> allImports = [];
  final List<String> allLists = [];

  categoryCounts.forEach((categoryName, count) {
    String fileName = fileNames[categoryName]!;
    String varName = fileName.replaceAll('.dart', '');
    allImports.add("import '$fileName';");
    allLists.add("...$varName,");

    StringBuffer sb = StringBuffer();
    sb.writeln("import 'package:rto_assmant/models/question_model.dart';");
    sb.writeln("");
    sb.writeln("final List<QuestionModel> $varName = [");

    for (int i = 1; i <= count; i++) {
      String difficulty = i % 4 == 0 ? "Expert" : (i % 3 == 0 ? "Hard" : (i % 2 == 0 ? "Medium" : "Easy"));
      sb.writeln('''
  QuestionModel(
    id: $globalId,
    categoryId: $categoryId,
    quizId: 1,
    question: "Sample $categoryName Question $i",
    options: [
      "Option A",
      "Option B",
      "Option C",
      "Option D"
    ],
    correctAnswer: "Option A",
    difficulty: "$difficulty",
    rewardCoins: 20,
    rewardXP: 10,
    explanation: "This is a detailed explanation for $categoryName question $i.",
  ),''');
      globalId++;
    }
    sb.writeln("];");

    File('${dir.path}/$fileName').writeAsStringSync(sb.toString());
    categoryId++;
  });

  // Create all_questions.dart
  StringBuffer allSb = StringBuffer();
  for (String imp in allImports) {
    allSb.writeln(imp);
  }
  allSb.writeln("import 'package:rto_assmant/models/question_model.dart';");
  allSb.writeln("");
  allSb.writeln("final List<QuestionModel> allQuestions = [");
  for (String list in allLists) {
    allSb.writeln("  $list");
  }
  allSb.writeln("];");

  File('${dir.path}/all_questions.dart').writeAsStringSync(allSb.toString());
  print("Successfully generated all category dart files with ${globalId - 1} questions.");
}
