import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helpers/database_helper.dart';
import 'add_profile_screen.dart';
import 'home_screen.dart';
import 'edit_profile_screen.dart';

class ProfileSelectionScreen extends StatefulWidget {
  @override
  _ProfileSelectionScreenState createState() => _ProfileSelectionScreenState();
}

class _ProfileSelectionScreenState extends State<ProfileSelectionScreen> {
  List<Map<String, dynamic>> _profiles = [];

  @override
  void initState() {
    super.initState();
    _loadProfiles();
  }

  void _loadProfiles() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    List<Map<String, dynamic>> profiles = await dbHelper.getProfiles();
    print(profiles); // Debug print to check if profiles are being fetched
    setState(() {
      _profiles = profiles;
    });
  }

  void _addProfile() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddProfileScreen()),
    ).then((value) => _loadProfiles());
  }

  void _editProfile(Map<String, dynamic> profile) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EditProfileScreen(profile: profile)),
    ).then((value) => _loadProfiles());
  }

  void _showPinDialog(Map<String, dynamic> profile) {
    showDialog(
      context: context,
      builder: (context) {
        final _pinController = TextEditingController();
        return AlertDialog(
          title: Text('Enter PIN'),
          content: TextField(
            controller: _pinController,
            decoration: InputDecoration(hintText: 'PIN'),
            keyboardType: TextInputType.number,
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_pinController.text.trim() == profile['pin'].toString().trim()) {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen(profile: profile)),
                  );
                } else {
                  // Show an error message or feedback
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Incorrect PIN'),
                  ));
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _onProfileTap(Map<String, dynamic> profile) {
    if (profile['pin'] != null && profile['pin'].isNotEmpty) {
      _showPinDialog(profile);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => HomeScreen(profile: profile)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent, // Set a colorful background
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Choose a profile',
                  style: GoogleFonts.chewy(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Who's using the app right now?",
                  style: GoogleFonts.chewy(fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: _profiles.isEmpty
                ? Center(
              child: Text(
                'No profiles available.',
                style: GoogleFonts.chewy(fontSize: 18),
              ),
            ) // Show message if no profiles
                : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _profiles.length,
              itemBuilder: (context, index) {
                final profile = _profiles[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => _onProfileTap(profile),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(profile['avatar']),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      profile['name'],
                      style: GoogleFonts.chewy(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () => _editProfile(profile),
                      icon: Icon(Icons.edit),
                      label: Text('EDIT'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        textStyle: GoogleFonts.chewy(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    // Implement add kid functionality
                  },
                  child: Row(
                    children: [
                      Text(
                        'Add a kid in Parent settings',
                        style: GoogleFonts.chewy(fontSize: 16),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.lock),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProfile,
        child: Icon(Icons.add),
        tooltip: 'Add Profile',
        backgroundColor: Colors.teal, // Set a colorful background for the FAB
      ),
    );
  }
}
