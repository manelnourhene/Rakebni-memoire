import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FaQD extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  String _selectedUserRole = 'Driver'; // Default value

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
                  'Aide',
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
                  'Votre rôle : ',
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
                _sendFeedbackToFirestore(context); // Appeler la fonction pour envoyer le feedback à Firestore.
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
      // Fonction pour envoyer le feedback à Firestore.
  void _sendFeedbackToFirestore(BuildContext context) {
    String email = _emailController.text;  // Récupérer l'e-mail entré par l'utilisateur.
    String feedback = _feedbackController.text;  // Récupérer le feedback entré par l'utilisateur.

    if (feedback.isNotEmpty) { // Vérifier si le feedback n'est pas vide.
      _firestore.collection('admin').doc('FaQ').update({
        'feedback': FieldValue.arrayUnion([{ // Ajouter le feedback dans un tableau Firestore.
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
          SnackBar(content: Text('Error sending feedback')), // Afficher un message d'erreur.
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your feedback')), // Afficher un message si le feedback est vide.
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose(); // Libérer les ressources utilisées par le contrôleur de l'e-mail.
    _feedbackController.dispose(); // Libérer les ressources utilisées par le contrôleur du feedback.
  }
}
