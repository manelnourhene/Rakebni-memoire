import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:imagestorage/admin/authAd.dart';

class HouseAd extends StatefulWidget {
  const HouseAd({Key? key}) : super(key: key);

  @override
  State<HouseAd> createState() => _HouseAdState();
}

class _HouseAdState extends State<HouseAd> {
  List<Contact> contacts = []; // Liste des contacts.
  int selectedIndex = -1; // Indice du contact sélectionné.
  List<Color> iconColors = [Colors.red];
  List<Color> fieldIconColors = [Colors.blue, Colors.teal];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Usesrs List'),
        actions: [
          IconButton(
            onPressed: () {
              logout(context); // Appelle la fonction de déconnexion.
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('contacts').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}')); // Affiche une erreur si elle se produit.
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final contacts = snapshot.data!.docs; // Récupère les documents de la collection 'contacts'.

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      var data = contacts[index].data() as Map<String, dynamic>;

                      return Card(
                        child: ListTile(
                          title: Text(data['name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data['contact']),
                              if (data['location'] != null) Text('Location: ${data['location']}'), 
                              if (data['location'] != null) Text('Location: ${data['location']}'), 
                              if (data['fields'] != null)
                                ...List.generate(data['fields'].length, (fieldIndex) {
                                  return Text('Field ${fieldIndex + 1}: ${data['fields'][fieldIndex]}'); // Affiche les champs supplémentaires.
                                }),
                              if (data['destination'] != null) Text('Destination: ${data['destination']}'),
                              if (data['timestamp'] != null) _buildDateText(data['timestamp']),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    FirebaseFirestore.instance.collection('contacts').doc(contacts[index].id).delete(); // Supprime le contact de la base de données.
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateText(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return Text('Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(date)}');
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AuthAd(),
      ),
    );
  }
}

class Contact {
  final String id;
  final String name;
  final String contact;
  final String location;
  final List<String> fields;
  final String destination;
  final DateTime timestamp;

  Contact({
    this.id = '',
    required this.name,
    required this.contact,
    required this.location,
    required this.fields,
    required this.destination,
    required this.timestamp,
  });
}

class SavedContactsPage extends StatelessWidget {
  final List<Contact> savedContacts;

  const SavedContactsPage({Key? key, required this.savedContacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Contacts'),
      ),
      body: ListView.builder(
        itemCount: savedContacts.length,
        itemBuilder: (context, index) {
          final contact = savedContacts[index];
          return Card(
            child: ListTile(
              title: Text(contact.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contact.contact),
                  if (contact.location.isNotEmpty) Text('Location: ${contact.location}'),
                  if (contact.fields.isNotEmpty)
                    ...List.generate(contact.fields.length, (fieldIndex) {
                      return Text('Field ${fieldIndex + 1}: ${contact.fields[fieldIndex]}');
                    }),
                  if (contact.destination.isNotEmpty) Text('Destination: ${contact.destination}'),
                  Text('Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(contact.timestamp)}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

