import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchPagePass extends StatefulWidget {
  const SearchPagePass({Key? key, required List savedContacts}) : super(key: key);

  @override
  State<SearchPagePass> createState() => _SearchPagePassState();
}

class _SearchPagePassState extends State<SearchPagePass> {
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterContacts);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterContacts() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredContacts = contacts.where((contact) {
        final allInfo = '${contact.name.toLowerCase()} ${contact.contact.toLowerCase()} ${contact.location.toLowerCase()} ${contact.fields.join(' ').toLowerCase()} ${contact.destination.toLowerCase()}';
        return allInfo.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('List drivers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (_) => _filterContacts(),
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('contacts').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  contacts = snapshot.data!.docs.map((doc) {
                    var data = doc.data() as Map<String, dynamic>;
                    return Contact(
                      id: doc.id,
                      name: data['name'],
                      contact: data['contact'],
                      location: data['location'] ?? '',
                      fields: List<String>.from(data['fields'] ?? []),
                      destination: data['destination'] ?? '',
                      timestamp: (data['timestamp'] as Timestamp).toDate(),
                      availableSeats: data['availableSeats'] ?? 0,
                    );
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredContacts.length,
                    itemBuilder: (context, index) {
                      var contact = filteredContacts[index];
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
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Available Seats: ${contact.availableSeats}'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
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
  final int availableSeats;

  Contact({
    required this.id,
    required this.name,
    required this.contact,
    required this.location,
    required this.fields,
    required this.destination,
    required this.timestamp,
    required this.availableSeats,
  });
}













