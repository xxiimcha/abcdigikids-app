import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helpers/database_helper.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> profile;

  EditProfileScreen({required this.profile});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _pinController;
  String _selectedAvatar = 'assets/default_avatar.jpg'; // default avatar

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile['name']);
    _pinController = TextEditingController(text: widget.profile['pin']);
    _selectedAvatar = widget.profile['avatar'];
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> updatedProfile = {
        'id': widget.profile['id'],
        'name': _nameController.text.trim(),
        'pin': _pinController.text.trim(),
        'avatar': _selectedAvatar,
      };

      DatabaseHelper dbHelper = DatabaseHelper();
      await dbHelper.updateProfile(updatedProfile);

      Navigator.of(context).pop(true); // Return to the previous screen
    }
  }

  void _selectAvatar(String avatarPath) {
    setState(() {
      _selectedAvatar = avatarPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: GoogleFonts.chewy()),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pinController,
                decoration: InputDecoration(labelText: 'PIN'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a PIN';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text('Select Avatar', style: GoogleFonts.chewy(fontSize: 18)),
              SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: 6, // number of available avatars
                  itemBuilder: (context, index) {
                    String avatarPath = 'assets/avatars/${index + 1}.png';
                    return GestureDetector(
                      onTap: () => _selectAvatar(avatarPath),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedAvatar == avatarPath
                                ? Colors.blue
                                : Colors.transparent,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(avatarPath),
                          radius: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Save', style: GoogleFonts.chewy()),
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
        ),
      ),
    );
  }
}
