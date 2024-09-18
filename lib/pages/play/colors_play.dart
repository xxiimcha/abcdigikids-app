import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorsPlayPage extends StatefulWidget {
  @override
  _ColorsPlayPageState createState() => _ColorsPlayPageState();
}

class _ColorsPlayPageState extends State<ColorsPlayPage> {
  final String correctAnswer = "RED";
  final List<String> options = ["R", "E", "D", "G", "B", "L", "O"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson 2', style: GoogleFonts.chewy()),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Which color is this?',
              style: GoogleFonts.chewy(fontSize: 24),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/learn_colors/red.png', height: 150),
                  SizedBox(height: 20),
                  Text(
                    correctAnswer,
                    style: GoogleFonts.chewy(fontSize: 48, letterSpacing: 8),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: options.map((option) {
                      return ElevatedButton(
                        onPressed: () {
                          // Handle letter selection
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle finish action
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
