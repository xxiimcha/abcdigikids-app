import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'dart:io';

class TracingLettersPage extends StatefulWidget {
  @override
  _TracingLettersPageState createState() => _TracingLettersPageState();
}

class _TracingLettersPageState extends State<TracingLettersPage> {
  List<String> _allLetters = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];
  int _currentLetterIndex = 0;
  List<Offset> _points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracing Letters', style: GoogleFonts.chewy()),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Trace the letter:',
              style: GoogleFonts.chewy(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              _allLetters[_currentLetterIndex],
              style: GoogleFonts.chewy(fontSize: 150, color: Colors.grey.withOpacity(0.5)),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  _points.add(renderBox.globalToLocal(details.globalPosition));
                });
              },
              onPanEnd: (details) {
                _points.add(Offset.zero);
              },
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height / 2),
                painter: TracingPainter(_points),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_currentLetterIndex < _allLetters.length - 1) {
                  setState(() {
                    _currentLetterIndex++;
                    _points.clear();
                  });
                }
              },
              child: Text('Next Letter'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                textStyle: GoogleFonts.chewy(fontSize: 18),
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
                textStyle: GoogleFonts.chewy(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TracingPainter extends CustomPainter {
  final List<Offset> points;

  TracingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blueAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.zero && points[i + 1] != Offset.zero) {
        canvas.drawLine(points[i], points[i + 1], paint);
      } else if (points[i] != Offset.zero && points[i + 1] == Offset.zero) {
        canvas.drawPoints(ui.PointMode.points, [points[i]], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
