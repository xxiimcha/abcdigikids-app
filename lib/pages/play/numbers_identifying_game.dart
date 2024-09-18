import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NumbersIdentifyingGame extends StatefulWidget {
  @override
  _NumbersIdentifyingGameState createState() => _NumbersIdentifyingGameState();
}

class _NumbersIdentifyingGameState extends State<NumbersIdentifyingGame> {
  final String correctAnswer = "THREE";
  final List<String> options = ["T", "H", "R", "E", "O", "N", "W"];
  List<String> selectedLetters = [];
  String feedbackMessage = '';

  void handleLetterSelection(String letter) {
    setState(() {
      if (selectedLetters.length < correctAnswer.length) {
        selectedLetters.add(letter);
        feedbackMessage = '';
      }

      if (selectedLetters.length == correctAnswer.length) {
        if (selectedLetters.join() == correctAnswer) {
          feedbackMessage = 'Correct! Well done!';
        } else {
          feedbackMessage = 'Try again!';
          selectedLetters.clear();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Identifying Numbers', style: GoogleFonts.chewy()),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Which number is this?',
              style: GoogleFonts.chewy(fontSize: 24),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/learn_numbers/three.png', height: 150),
                  SizedBox(height: 20),
                  Text(
                    selectedLetters.join(),
                    style: GoogleFonts.chewy(fontSize: 48, letterSpacing: 8),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: options.map((option) {
                      return ElevatedButton(
                        onPressed: () {
                          handleLetterSelection(option);
                        },
                        child: Text(
                          option,
                          style: GoogleFonts.chewy(fontSize: 32),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Text(
                    feedbackMessage,
                    style: GoogleFonts.chewy(
                        fontSize: 24,
                        color: feedbackMessage == 'Correct! Well done!'
                            ? Colors.green
                            : Colors.red),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (feedbackMessage == 'Correct! Well done!') {
                  Navigator.pop(context);
                } else {
                  setState(() {
                    feedbackMessage = 'Please complete the correct answer first!';
                  });
                }
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
