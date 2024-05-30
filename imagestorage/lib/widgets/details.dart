import 'package:flutter/material.dart';
import 'package:imagestorage/Driver/home.dart';
// import 'package:imagestorage/taxi.dart';
import 'package:intl/intl.dart';
 // Replace with your actual package if needed

class ContactDetailsPage extends StatelessWidget {
  final Contact contact;

  const ContactDetailsPage({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${contact.name}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Contact: ${contact.contact}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Location: ${contact.location}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            ...contact.fields.map((field) => Text('Field: $field', style: TextStyle(fontSize: 18))).toList(),
            SizedBox(height: 8),
            Text('Destination: ${contact.destination}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Date: ${DateFormat.yMd().add_jm().format(contact.timestamp)}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
