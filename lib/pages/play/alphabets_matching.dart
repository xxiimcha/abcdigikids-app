import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlphabetsMatchingPage extends StatefulWidget {
  @override
  _AlphabetsMatchingPageState createState() => _AlphabetsMatchingPageState();
}

class _AlphabetsMatchingPageState extends State<AlphabetsMatchingPage> {
  final List<String> _allLetters = [
    'assets/play_letters/A.png', 'assets/play_letters/B.png', 'assets/play_letters/C.png',
    'assets/play_letters/D.png', 'assets/play_letters/E.png', 'assets/play_letters/F.png',
    'assets/play_letters/G.png', 'assets/play_letters/H.png', 'assets/play_letters/I.png',
    'assets/play_letters/J.png', 'assets/play_letters/K.png', 'assets/play_letters/L.png',
    'assets/play_letters/M.png', 'assets/play_letters/N.png', 'assets/play_letters/O.png',
    'assets/play_letters/P.png', 'assets/play_letters/Q.png', 'assets/play_letters/R.png',
    'assets/play_letters/S.png', 'assets/play_letters/T.png', 'assets/play_letters/U.png',
    'assets/play_letters/V.png', 'assets/play_letters/W.png', 'assets/play_letters/X.png',
    'assets/play_letters/Y.png', 'assets/play_letters/Z.png'
  ];

  List<String> _selectedLetters = [];
  List<String> _shuffledLetters = [];
  List<bool> _flippedCards = [];
  int _score = 0;
  bool _quizCompleted = false;
  int? _firstIndex;
  int? _secondIndex;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    final random = Random();
    _selectedLetters = List.generate(5, (_) {
      String letter;
      do {
        letter = _allLetters[random.nextInt(_allLetters.length)];
      } while (_selectedLetters.contains(letter));
      return letter;
    });
    _shuffledLetters = [..._selectedLetters, ..._selectedLetters];
    _shuffledLetters.shuffle(random);
    _flippedCards = List.generate(_shuffledLetters.length, (_) => false);

    Timer(Duration(seconds: 3), () {
      setState(() {
        _flippedCards = List.generate(_shuffledLetters.length, (_) => true);
      });
    });
  }

  void _checkMatch(int index1, int index2) {
    if (_shuffledLetters[index1] == _shuffledLetters[index2]) {
      setState(() {
        _score++;
        _shuffledLetters[index1] = '';
        _shuffledLetters[index2] = '';
        if (_score == _selectedLetters.length) {
          _quizCompleted = true;
        }
      });
    } else {
      Timer(Duration(seconds: 1), () {
        setState(() {
          _flippedCards[index1] = true;
          _flippedCards[index2] = true;
          _isProcessing = false;
        });
      });
    }
  }

  void _handleTap(int index) {
    if (_isProcessing || !_flippedCards[index]) return;

    setState(() {
      _flippedCards[index] = false;
      if (_firstIndex == null) {
        _firstIndex = index;
      } else {
        _secondIndex = index;
        _isProcessing = true;
        _checkMatch(_firstIndex!, _secondIndex!);
        _firstIndex = null;
        _secondIndex = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_allLetters.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...', style: GoogleFonts.chewy()),
          backgroundColor: Colors.redAccent,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Matching Letters', style: GoogleFonts.chewy()),
        backgroundColor: Colors.redAccent,
      ),
      body: _quizCompleted
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Game Completed!',
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
                  _score = 0;
                  _quizCompleted = false;
                  _startGame();
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
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Match the letters!',
              style: GoogleFonts.chewy(fontSize: 24),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _shuffledLetters.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _handleTap(index),
                    child: Card(
                      color: _flippedCards[index] ? Colors.blueAccent : Colors.white,
                      child: Center(
                        child: _flippedCards[index]
                            ? Container()
                            : Image.asset(
                          _shuffledLetters[index],
                          fit: BoxFit.cover,
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
    );
  }
}
