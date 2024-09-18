import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShapeDrawingGame extends StatefulWidget {
  @override
  _ShapeDrawingGameState createState() => _ShapeDrawingGameState();
}

class _ShapeDrawingGameState extends State<ShapeDrawingGame> {
  List<Point> points = [];
  String feedbackMessage = '';

  void _resetDrawing() {
    setState(() {
      points = [];
      feedbackMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shape Drawing Game', style: GoogleFonts.chewy()),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Draw a Circle!',
              style: GoogleFonts.chewy(fontSize: 24),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  points.add(Point(details.localPosition.dx, details.localPosition.dy));
                });
              },
              onPanEnd: (details) {
                setState(() {
                  feedbackMessage = 'Drawing complete! Well done!';
                });
              },
              child: CustomPaint(
                painter: ShapePainter(points),
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              feedbackMessage,
              style: GoogleFonts.chewy(fontSize: 24, color: feedbackMessage == "Drawing complete! Well done!" ? Colors.green : Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _resetDrawing,
                  child: Text(
                    'Restart',
                    style: GoogleFonts.chewy(fontSize: 24),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final List<Point> points;
  ShapePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i].toOffset(), points[i + 1].toOffset(), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Point {
  final double x;
  final double y;
  Point(this.x, this.y);

  Offset toOffset() {
    return Offset(x, y);
  }
}
