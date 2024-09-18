import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NumbersPronunciationGame extends StatefulWidget {
  @override
  _NumbersPronunciationGameState createState() => _NumbersPronunciationGameState();
}

class _NumbersPronunciationGameState extends State<NumbersPronunciationGame> {
  static const String locale = "en_US";
  late SpeechRecognition _speech;
  late FlutterTts _flutterTts;
  bool _isListening = false;
  String _recognizedWords = '';
  String correctNumber = "three"; // Example correct answer
  String currentImage = 'assets/learn_numbers/3.png'; // Example image path
  bool _isCorrect = false;

  final List<String> numbers = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "zero"];
  final List<String> imagePaths = [
    'assets/learn_numbers/1.png',
    'assets/learn_numbers/2.png',
    'assets/learn_numbers/3.png',
    'assets/learn_numbers/4.png',
    'assets/learn_numbers/5.png',
    'assets/learn_numbers/6.png',
    'assets/learn_numbers/7.png',
    'assets/learn_numbers/8.png',
    'assets/learn_numbers/9.png',
    'assets/learn_numbers/10.png',
  ];

  @override
  void initState() {
    super.initState();
    _speech = SpeechRecognition();
    _flutterTts = FlutterTts();
    _speech.setAvailabilityHandler((bool result) => setState(() => _isListening = result));
    _speech.setRecognitionStartedHandler(() => setState(() => _isListening = true));
    _speech.setRecognitionResultHandler((String speech) => setState(() => _recognizedWords = speech));
    _speech.setRecognitionCompleteHandler((String result) {
      setState(() {
        _isListening = false;
        if (_recognizedWords.toLowerCase().trim() == correctNumber) {
          _isCorrect = true;
          _showResultDialog(true);
        } else {
          _isCorrect = false;
          _showResultDialog(false);
          _speakCorrectPronunciation(); // Speak the correct pronunciation
        }
      });
    });
    _speech.activate(locale).then((_) => setState(() {}));
    _setRandomNumber();
  }

  void _startListening() {
    if (!_isListening) {
      _speech.listen().then((result) {
        setState(() {
          _isListening = result;
        });
      });
    } else {
      _speech.stop().then((_) => setState(() => _isListening = false));
    }
  }

  void _setRandomNumber() {
    final random = Random();
    int index = random.nextInt(numbers.length);
    setState(() {
      correctNumber = numbers[index];
      currentImage = imagePaths[index];
    });
  }

  void _speakCorrectPronunciation() async {
    await _flutterTts.speak(correctNumber);
  }

  void _showResultDialog(bool isCorrect) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isCorrect ? 'Correct!' : 'Try Again!'),
        content: Text(isCorrect
            ? 'You pronounced the number correctly.'
            : 'You didn\'t pronounce the number correctly.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _recognizedWords = '';
                _isCorrect = false;
              });
              _setRandomNumber();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _resetGame() {
    setState(() {
      _recognizedWords = '';
      _isCorrect = false;
      _setRandomNumber();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Pronunciation', style: GoogleFonts.chewy()),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pronounce the number:',
              style: GoogleFonts.chewy(fontSize: 24),
            ),
            SizedBox(height: 20),
            Image.asset(currentImage, height: 150), // Display the current random image
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startListening,
              child: Text(_isListening ? 'Stop' : 'Start'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
                textStyle: GoogleFonts.chewy(fontSize: 24),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Recognized: $_recognizedWords',
              style: GoogleFonts.chewy(fontSize: 24, color: Colors.black),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetGame,
              child: Text('Reset'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
                textStyle: GoogleFonts.chewy(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: NumbersPronunciationGame()));
