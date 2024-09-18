import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NumbersMatchingGame extends StatefulWidget {
  @override
  _NumbersMatchingGameState createState() => _NumbersMatchingGameState();
}

class _NumbersMatchingGameState extends State<NumbersMatchingGame> {
  final List<String> numbers = ["ONE", "TWO", "THREE", "FOUR"];
  final List<String> options = ["1", "2", "3", "4"];
  Map<String, String> matchingPairs = {};
  String feedbackMessage = '';

  @override
  void initState() {
    super.initState();
    numbers.shuffle();
    options.shuffle();
  }

  void checkMatch(String number, String option) {
    setState(() {
      if (matchingPairs[number] == null) {
        matchingPairs[number] = option;
        if (matchingPairs.length == numbers.length) {
          bool allCorrect = true;
          matchingPairs.forEach((key, value) {
            if (key == "ONE" && value != "1" ||
                key == "TWO" && value != "2" ||
                key == "THREE" && value != "3" ||
                key == "FOUR" && value != "4") {
              allCorrect = false;
            }
          });
          feedbackMessage = allCorrect ? "All Correct!" : "Try Again!";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matching Numbers', style: GoogleFonts.chewy()),
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
              'Match the numbers!',
              style: GoogleFonts.chewy(fontSize: 24),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: numbers.map((number) {
                      return ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          number,
                          style: GoogleFonts.chewy(fontSize: 32),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
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
                  Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: options.map((option) {
                      return ElevatedButton(
                        onPressed: () {
                          checkMatch(numbers[options.indexOf(option)], option);
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
                        color: feedbackMessage == "All Correct!"
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
                if (feedbackMessage == "All Correct!") {
                  Navigator.pop(context);
                } else {
                  setState(() {
                    feedbackMessage = "Please complete the matching correctly first!";
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
