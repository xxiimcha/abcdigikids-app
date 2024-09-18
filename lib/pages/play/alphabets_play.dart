import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' show rootBundle;

class AlphabetsPlayPage extends StatefulWidget {
  @override
  _AlphabetsPlayPageState createState() => _AlphabetsPlayPageState();
}

class _AlphabetsPlayPageState extends State<AlphabetsPlayPage> {
  List<String> _allLetters = [];
  List<String> _selectedLetters = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizCompleted = false;
  List<String> _choices = [];

  String get _currentImagePath => 'assets/play_letters/${_selectedLetters[_currentQuestionIndex]}';
  String get _correctAnswer => _selectedLetters[_currentQuestionIndex].split('.').first;

  @override
  void initState() {
    super.initState();
    _loadAllLetters().then((_) {
      _loadRandomLetters();
      _generateChoices();
    });
  }

  Future<void> _loadAllLetters() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final imagePaths = manifestMap.keys
        .where((String key) => key.startsWith('assets/play_letters/'))
        .toList();
    setState(() {
      _allLetters = imagePaths.map((path) => path.split('/').last).toList();
    });
  }

  void _loadRandomLetters() {
    final random = Random();
    _selectedLetters = List.generate(5, (_) {
      String letter;
      do {
        letter = _allLetters[random.nextInt(_allLetters.length)];
      } while (_selectedLetters.contains(letter));
      return letter;
    });
  }

  void _generateChoices() {
    final random = Random();
    _choices = List.generate(4, (_) {
      String choice;
      do {
        choice = _allLetters[random.nextInt(_allLetters.length)].split('.').first;
      } while (_choices.contains(choice) || choice == _correctAnswer);
      return choice;
    });
    _choices[random.nextInt(4)] = _correctAnswer; // Insert the correct answer at a random position
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _selectedLetters.length - 1) {
        _currentQuestionIndex++;
        _generateChoices(); // Generate new choices for the next question
      } else {
        _quizCompleted = true; // Mark quiz as completed
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_allLetters.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...', style: GoogleFonts.chewy()),
          backgroundColor: Colors.pinkAccent,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson 12', style: GoogleFonts.chewy()),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // Handle close action
            },
          ),
        ],
      ),
      body: _quizCompleted
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz Completed!',
              style: GoogleFonts.chewy(fontSize: 32, color: Colors.green),
            ),
            SizedBox(height: 20),
            Text(
              'Your score: $_score / ${_selectedLetters.length}',
              style: GoogleFonts.chewy(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentQuestionIndex = 0;
                  _score = 0;
                  _quizCompleted = false;
                  _loadRandomLetters();
                  _generateChoices();
                });
              },
              child: Text('Restart'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
                textStyle: GoogleFonts.chewy(fontSize: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Return to Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
                textStyle: GoogleFonts.chewy(fontSize: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Which letter is this?',
              style: GoogleFonts.chewy(fontSize: 24),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(_currentImagePath, height: 150),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: _choices.map((choice) {
                      return ElevatedButton(
                        onPressed: () {
                          if (choice == _correctAnswer) {
                            _score++;
                          }
                          _nextQuestion();
                        },
                        child: Text(
                          choice,
                          style: GoogleFonts.chewy(fontSize: 32),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _quizCompleted = true;
                });
              },
              child: Text(
                'FINISH',
                style: GoogleFonts.chewy(fontSize: 24),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
