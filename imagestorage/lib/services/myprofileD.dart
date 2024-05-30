import 'package:flutter/material.dart';

class EditProfileDPage extends StatefulWidget {
  final String initialName;
  final String initialEmail;
  final String initialPhoneNumber;

  EditProfileDPage({
    this.initialName = '',
    this.initialEmail = '',
    this.initialPhoneNumber = '',
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfileDPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _emailController = TextEditingController(text: widget.initialEmail);
    _phoneNumberController = TextEditingController(text: widget.initialPhoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          SizedBox(width: 16.0),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _bioController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Bio'),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                _saveProfileChanges();
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfileChanges() {
    // Perform save operation here, e.g., update Firebase or local storage
    String newName = _nameController.text.trim();
    String newEmail = _emailController.text.trim();
    String newPhoneNumber = _phoneNumberController.text.trim();
    String newBio = _bioController.text.trim();

    // Implement your logic to save changes here

    // Optionally, you can show a snackbar or navigate to a new page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _bioController.dispose();
    super.dispose();
  }
}
