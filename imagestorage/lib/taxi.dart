// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'contact.dart'; // Ensure the correct path based on your project structure
// import 'Driver/home.dart'; // Ensure this import path is correct based on your project structure

// class ListeTaxiPage extends StatelessWidget {
//   final List<Contact> contacts;

//   const ListeTaxiPage({Key? key, required this.contacts}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Liste des Taxis'),
//       ),
//       body: contacts.isEmpty
//           ? const Center(
//               child: Text('Aucun contact trouvé'),
//             )
//           : ListView.builder(
//               itemCount: contacts.length,
//               itemBuilder: (context, index) {
//                 Contact contact = contacts[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                   child: ListTile(
//                     title: Row(
//                       children: [
//                         Text(contact.name),
//                         const SizedBox(width: 10),
//                         Text(
//                           contact.contact,
//                           style: const TextStyle(color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         if (contact.location.isNotEmpty)
//                           Row(
//                             children: [
//                               const Icon(Icons.place, color: Colors.red),
//                               const SizedBox(width: 5),
//                               Text('Location: ${contact.location}'),
//                             ],
//                           ),
//                         if (contact.fields.isNotEmpty)
//                           ...List.generate(contact.fields.length, (fieldIndex) {
//                             return Row(
//                               children: [
//                                 const Icon(Icons.place, color: Colors.blue),
//                                 const SizedBox(width: 5),
//                                 Text('Field ${fieldIndex + 1}: ${contact.fields[fieldIndex]}'),
//                               ],
//                             );
//                           }),
//                         if (contact.destination.isNotEmpty)
//                           Row(
//                             children: [
//                               const Icon(Icons.place, color: Colors.teal),
//                               const SizedBox(width: 5),
//                               Text('Destination: ${contact.destination}'),
//                             ],
//                           ),
//                         Row(
//                           children: [
//                             const Icon(Icons.date_range, color: Colors.orange),
//                             const SizedBox(width: 5),
//                             Text('Date: ${DateFormat.yMd().add_jm().format(contact.timestamp)}'),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

// // // Example navigation to ListeTaxiPage
// // Navigator.push(
// //   context,
// //   MaterialPageRoute(builder: (context) => ListeTaxiPage(contacts: contacts)),
// // );
// class Contact {
//   final String name;
//   final String contact;
//   final String location;
//   final List<String> fields;
//   final String destination;
//   final DateTime timestamp;

//   Contact({
//     required this.name,
//     required this.contact,
//     required this.location,
//     required this.fields,
//     required this.destination,
//     required this.timestamp,
//   });
// }
