import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rto_assmant/models/quiz_result_model.dart';
import 'package:rto_assmant/models/question_model.dart';
import 'package:rto_assmant/data/categories/all_questions.dart';
import 'package:provider/provider.dart';
import 'package:rto_assmant/providers/app_state_provider.dart';
import 'package:rto_assmant/widgets/glass_card.dart';
import 'package:rto_assmant/widgets/character_showcase.dart';
import 'package:rto_assmant/services/audio_service.dart';

class QuizPlayingScreen extends StatefulWidget {
  final String category;

  const QuizPlayingScreen({super.key, required this.category});

  @override
  State<QuizPlayingScreen> createState() => _QuizPlayingScreenState();
}

class _QuizPlayingScreenState extends State<QuizPlayingScreen> {
  List<QuestionModel> _questions = [];
  int _currentIndex = 0;
  int _correctCount = 0;
  bool _isLoading = true;
  
  Timer? _timer;
  int _timeLeft = 15;
  bool _isAnswered = false;
  int? _selectedOptionIndex;
  
  String _owlMood = 'neutral'; // 'neutral', 'happy', 'sad'

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      setState(() {
        _questions = allQuestions.where((q) => q.category == widget.category).toList();
        _questions.shuffle();
        if (_questions.length > 10) {
          _questions = _questions.sublist(0, 10);
        }
        _isLoading = false;
      });
      _startTimer();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _startTimer() {
    _timeLeft = 15;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer?.cancel();
        if (!_isAnswered) {
          _handleAnswer(-1); // Time out
        }
      }
    });
  }

  void _handleAnswer(int selectedIndex) {
    if (_isAnswered) return;
    
    _timer?.cancel();
    
    final question = _questions[_currentIndex];
    final correctIndex = question.options.indexOf(question.correctAnswer);
    final isCorrect = selectedIndex == correctIndex;
    
    setState(() {
      _isAnswered = true;
      _selectedOptionIndex = selectedIndex;
      if (isCorrect) {
        _correctCount++;
        _owlMood = 'happy';
        AudioService.instance.playSoundEffect('correct');
      } else {
        _owlMood = 'sad';
        AudioService.instance.playSoundEffect('wrong');
      }
    });
    
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      if (_currentIndex < _questions.length - 1) {
        setState(() {
          _currentIndex++;
          _isAnswered = false;
          _selectedOptionIndex = null;
          _owlMood = 'neutral';
        });
        _startTimer();
      } else {
        _finishQuiz();
      }
    });
  }

  void _finishQuiz() {
    final result = QuizResult(
      category: widget.category,
      score: _correctCount * 10,
      date: DateTime.now(),
      correctCount: _correctCount,
      totalQuestions: _questions.length,
    );
    
    final appState = Provider.of<AppStateProvider>(context, listen: false);
    appState.recordQuizResult(result);
    
    final int xpEarned = _correctCount * 15 + (_correctCount == _questions.length ? 50 : 0);
    final int coinsEarned = _correctCount * 10;
    
    Navigator.pushReplacementNamed(context, '/result', arguments: {
      'score': result.score,
      'correctCount': _correctCount,
      'totalQuestions': _questions.length,
      'xpEarned': xpEarned,
      'coinsEarned': coinsEarned,
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    if (_questions.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: const Center(child: Text("No questions found for this category.", style: TextStyle(color: Colors.white))),
      );
    }

    final question = _questions[_currentIndex];
    final options = question.options;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.category, style: const TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Question ${_currentIndex + 1}/${_questions.length}', style: const TextStyle(color: Colors.white70, fontSize: 16)),
                  Row(
                    children: [
                      const Icon(Icons.timer, color: Colors.cyanAccent, size: 18),
                      const SizedBox(width: 4),
                      Text('$_timeLeft s', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: (_currentIndex + 1) / _questions.length,
                backgroundColor: Colors.white10,
                color: const Color(0xFF8A4FFF),
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 40),
              
              // Owl mood representation (placeholder for actual asset)
              Center(
                child: CharacterShowcase(
                  imagePath: Provider.of<AppStateProvider>(context).equippedSkinImagePath,
                  width: 100,
                  height: 100,
                  border: Border.all(
                    color: _owlMood == 'happy' ? Colors.green : 
                           _owlMood == 'sad' ? Colors.red : const Color(0xFF6A4C93),
                    width: 3,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              Text(
                question.question,
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              Expanded(
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final isCorrectOption = index == question.options.indexOf(question.correctAnswer);
                    final isSelected = index == _selectedOptionIndex;
                    
                    Color? bgColor;
                    Color borderColor = Colors.white.withOpacity(0.15);
                    
                    if (_isAnswered) {
                      if (isCorrectOption) {
                        bgColor = Colors.green.withOpacity(0.2);
                        borderColor = Colors.green;
                      } else if (isSelected) {
                        bgColor = Colors.red.withOpacity(0.2);
                        borderColor = Colors.red;
                      }
                    }

                    return GestureDetector(
                      onTap: () => _handleAnswer(index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: GlassCard(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                          borderRadius: BorderRadius.circular(16),
                          color: bgColor,
                          border: Border.all(color: borderColor, width: 2),
                          child: Text(
                            options[index],
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
