import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FaQP extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  String _selectedUserRole = 'Passenger'; // Default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Help',
                  style: TextStyle(fontSize: 24.0),
                ),
                SizedBox(width: 10.0),
                Icon(Icons.help_outline),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Text(
                  'Your role : ',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(width: 10.0),
                DropdownButton<String>(
                  value: _selectedUserRole,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _selectedUserRole = newValue;
                    }
                  },
                  items: <String>['Passenger', 'Driver']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Who are you?...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: TextField(
                controller: _feedbackController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'To report a problem...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _sendFeedbackToFirestore(context);
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendFeedbackToFirestore(BuildContext context) {
    String email = _emailController.text;
    String feedback = _feedbackController.text;

    if (feedback.isNotEmpty) {
      _firestore.collection('admin').doc('FaQ').update({
        'feedback': FieldValue.arrayUnion([{
          'email': email,
          'feedback': feedback,
          'userRole': _selectedUserRole,
          'timestamp': DateTime.now(),
        }])
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Feedback sent successfully')),
        );
        // Effacer le contenu des champs après l'envoi réussi
        _emailController.clear();
        _feedbackController.clear();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending feedback')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your feedback')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _feedbackController.dispose();
  }
}
