import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ColorsScreen extends StatefulWidget {
  final List<String> imagePaths;

  ColorsScreen({required this.imagePaths});

  @override
  _ColorsScreenState createState() => _ColorsScreenState();
}

class _ColorsScreenState extends State<ColorsScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.5);
    flutterTts.setStartHandler(() {
      print("TTS started");
    });
    flutterTts.setCompletionHandler(() {
      print("TTS completed");
    });
    flutterTts.setErrorHandler((msg) {
      print("TTS error: $msg");
    });
    _speakCurrentWord(); // Speak the first word initially
  }

  @override
  void dispose() {
    _pageController.dispose();
    flutterTts.stop(); // Stop TTS when disposing
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < widget.imagePaths.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      _speakCurrentWord(); // Speak the word when the page changes
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      _speakCurrentWord(); // Speak the word when the page changes
    }
  }

  Future<void> _speakCurrentWord() async {
    String imagePath = widget.imagePaths[_currentPage];
    String word = imagePath.split('/').last.split('.').first;
    print("Speaking: $word");
    await flutterTts.speak(word);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text(
          'Colors',
          style: GoogleFonts.chewy(), // Apply Chewy font
        ),
        backgroundColor: Colors.redAccent, // Match the background color
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/default_avatar.jpg'), // example avatar, you can replace it with the user's avatar
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imagePaths.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
                _speakCurrentWord(); // Speak the word when the page changes
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: Image.asset(
                  widget.imagePaths[index],
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            },
          ),
          Positioned(
            left: 10,
            top: MediaQuery.of(context).size.height / 2 - 25,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 50),
              onPressed: _previousPage,
            ),
          ),
          Positioned(
            right: 10,
            top: MediaQuery.of(context).size.height / 2 - 25,
            child: IconButton(
              icon: Icon(Icons.arrow_forward, color: Colors.white, size: 50),
              onPressed: _nextPage,
            ),
          ),
        ],
      ),
    );
  }
}
