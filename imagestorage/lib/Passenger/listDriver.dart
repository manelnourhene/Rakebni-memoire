// import 'package:flutter/material.dart';
// import 'package:imagestorage/Driver/home.dart';
// // import 'package:imagestorage/taxi.dart';
// import 'package:intl/intl.dart';

// class SavedContactsPage extends StatefulWidget {
//   final List<Contact> savedContacts;

//   const SavedContactsPage({Key? key, required this.savedContacts}) : super(key: key);

//   @override
//   _SavedContactsPageState createState() => _SavedContactsPageState();
// }

// class _SavedContactsPageState extends State<SavedContactsPage> {
//   late List<Contact> _filteredContacts;

//   @override
//   void initState() {
//     super.initState();
//     _filteredContacts = widget.savedContacts;
//   }

//   void _filterContacts(String query) {
//     setState(() {
//       _filteredContacts = widget.savedContacts.where((contact) {
//         final name = contact.name.toLowerCase();
//         final contactInfo = contact.contact.toLowerCase();
//         final location = contact.location?.toLowerCase();
//         final destination = contact.destination?.toLowerCase();
//         final fields = contact.fields.join(" ").toLowerCase();
//         final formattedDate = DateFormat('yyyy-MM-dd').format(contact.timestamp);
//         final searchLower = query.toLowerCase();

//         return name.contains(searchLower) ||
//             contactInfo.contains(searchLower) ||
//             location!.contains(searchLower) ||
//             destination!.contains(searchLower) ||
//             fields.contains(searchLower) ||
//             formattedDate.contains(searchLower);
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Saved Contacts'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               showSearch(
//                 context: context,
//                 delegate: _ContactSearchDelegate(savedContacts: widget.savedContacts),
//               );
//             },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: _filteredContacts.length,
//         itemBuilder: (context, index) {
//           Contact contact = _filteredContacts[index];
//           return Card(
//             elevation: 4,
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: ListTile(
//               title: Text(
//                 contact.name,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 4),
//                   Text(
//                     'Contact: ${contact.contact}',
//                     style: TextStyle(
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     'Location: ${contact.location}',
//                     style: TextStyle(
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     'Fields: ${contact.fields.join(", ")}',
//                     style: TextStyle(
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     'Destination: ${contact.destination}',
//                     style: TextStyle(
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     'Date: ${contact.timestamp}',
//                     style: TextStyle(
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                 ],
//               ),
//               onTap: () {
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


// class _ContactSearchDelegate extends SearchDelegate<Contact> {
//   final List<Contact> savedContacts;

//   _ContactSearchDelegate({required this.savedContacts});

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }












  

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         // close(context, Contact.empty()); // Retourne un objet Contact vide
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return _buildSearchResults();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return _buildSearchResults();
//   }

//   Widget _buildSearchResults() {
//     final filteredContacts = savedContacts.where((contact) {
//       final name = contact.name.toLowerCase();
//       final contactInfo = contact.contact.toLowerCase();
//       final location = contact.location?.toLowerCase();
//       final destination = contact.destination?.toLowerCase();
//       final fields = contact.fields.join(" ").toLowerCase();
//       final formattedDate =
//           DateFormat('yyyy-MM-dd').format(contact.timestamp);
//       final searchLower = query.toLowerCase();

//       return name.contains(searchLower) ||
//           contactInfo.contains(searchLower) ||
//           location!.contains(searchLower) ||
//           destination!.contains(searchLower) ||
//           fields.contains(searchLower) ||
//           formattedDate.contains(searchLower);
//     }).toList();

//     return ListView.builder(
//       itemCount: filteredContacts.length,
//       itemBuilder: (context, index) {
//         Contact contact = filteredContacts[index];
//         return Card(
//           elevation: 2,
//           margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           child: ListTile(
//             title: Text(
//               contact.name,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//                 color: Colors.blue, // Couleur du texte
//               ),
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Contact: ${contact.contact}',
//                   style: TextStyle(
//                     color: Colors.grey[700], // Couleur du texte
//                   ),
//                 ),
//                 Text(
//                   'Location: ${contact.location}',
//                   style: TextStyle(
//                     color: Colors.grey[700], // Couleur du texte
//                   ),
//                 ),
//                 Text(
//                   'Fields: ${contact.fields.join(", ")}',
//                   style: TextStyle(
//                     color: Colors.grey[700], // Couleur du texte
//                   ),
//                 ),
//                 Text(
//                   'Destination: ${contact.destination}',
//                   style: TextStyle(
//                     color: Colors.grey[700], // Couleur du texte
//                   ),
//                 ),
//                 Text(
//                   'Date: ${DateFormat('yyyy-MM-dd').format(contact.timestamp)}',
//                   style: TextStyle(
//                     color: Colors.grey[700], // Couleur du texte
//                   ),
//                 ),
//               ],
//             ),
//             onTap: () {
//               close(context, contact);
//             },
//           ),
//         );
//       },
//     );
//   }
// }
