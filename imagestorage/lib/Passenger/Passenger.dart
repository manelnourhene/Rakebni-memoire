
// import 'package:flutter/material.dart';
// import 'package:imagestorage/Passenger/info_passenger.dart';
// import 'package:imagestorage/Passenger/login_P.dart';
// import 'package:imagestorage/Passenger/faqP.dart';
// import 'package:imagestorage/services/CallTaxPassHome.dart';
// import 'package:imagestorage/services/myprofile.dart'; // Import de la classe FaQ pour la page d'aide

// class PassengerModePage extends StatelessWidget {
//   final String userEmail;
//   final String userName;

//   PassengerModePage({required this.userEmail, required this.userName});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mode Passenger'),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     radius: 30,
//                     // You can add a profile picture here if available
//                     // backgroundImage: AssetImage('assets/profile_picture.jpg'),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     userEmail,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.person),
//               title: Text(userEmail),
//               onTap: () {
//                 // Redirection vers la page de profil
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => EditProfilePage()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.help), // Ajout de l'icône d'aide
//               title: Text('Help'), // Texte du bouton d'aide
//               onTap: () {
//                 // Redirection vers la page d'aide (FAQ)
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => FaQP()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.logout), // Ajout de l'icône de déconnexion
//               title: Text('Logout'), // Texte du bouton de déconnexion
//               onTap: () {
//                 // Déconnectez l'utilisateur et revenez à la page de connexion
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => LogInP()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: CallTaxi(userEmail: userEmail,),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imagestorage/Passenger/info_passenger.dart';
import 'package:imagestorage/Passenger/login_P.dart';
import 'package:imagestorage/Passenger/faqP.dart';
import 'package:imagestorage/services/CallTaxPassHome.dart';
import 'package:imagestorage/services/myprofile.dart'; // Import de la classe FaQ pour la page d'aide

class PassengerModePage extends StatefulWidget {
  final String userEmail;
  final String userName;

  PassengerModePage({required this.userEmail, required this.userName});

  @override
  _PassengerModePageState createState() => _PassengerModePageState();
}

class _PassengerModePageState extends State<PassengerModePage> {
  String? _userPhotoUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      // Fetch user data from Firestore based on email
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.userEmail)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>?;
        setState(() {
          _userPhotoUrl = userData?['image_url']; // Assuming 'image_url' is the field name in Firestore
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mode Passenger'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: _userPhotoUrl != null
                        ? NetworkImage(_userPhotoUrl!)
                        : null,
                    child: _userPhotoUrl == null
                        ? Icon(Icons.person, color: Colors.white, size: 30)
                        : null,
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.userEmail,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(widget.userEmail),
              onTap: () {
                // Redirection vers la page de profil
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.help), // Ajout de l'icône d'aide
              title: Text('Help'), // Texte du bouton d'aide
              onTap: () {
                // Redirection vers la page d'aide (FAQ)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FaQP()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout), // Ajout de l'icône de déconnexion
              title: Text('Logout'), // Texte du bouton de déconnexion
              onTap: () {
                // Déconnectez l'utilisateur et revenez à la page de connexion
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LogInP()),
                );
              },
            ),
          ],
        ),
      ),
      body: CallTaxi(userEmail: widget.userEmail),
    );
  }
}

