import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:imagestorage/Driver/faqD.dart';
import 'package:imagestorage/Driver/home.dart';
import 'package:imagestorage/Driver/login_D.dart';
import 'package:imagestorage/Passenger/info_passenger.dart';
import 'package:imagestorage/services/CallTaxPassHome.dart';
import 'package:imagestorage/services/myprofile.dart';
import 'package:imagestorage/services/myprofileD.dart';

class DriverModePage extends StatefulWidget {
  final String userEmail;
  final String userName;

  DriverModePage({required this.userEmail, required this.userName, required String userImageUrl});

  @override
  _DriverModePageState createState() => _DriverModePageState();
}

class _DriverModePageState extends State<DriverModePage> {
  String? _userPhotoUrl;
  @override
  void initState(){
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
  int _selectedIndex =0;

  static List<Widget> _widgetOptions = <Widget>[
     HomePagee(),         // Replace with your actual HomePage widget
    ContactPage(),      // Replace with your actual ContactPage widget
    HomePage(),          // Replace with your actual AddPage widget     
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mode Driver'),
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
                  MaterialPageRoute(builder: (context) => EditProfileDPage()),
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
                  MaterialPageRoute(builder: (context) => FaQD()),
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
                  MaterialPageRoute(builder: (context) => LogInD()),
                );
              },
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}


class HomePagee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('images/homeD.jpg',),
      
      
    );
  }
}

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Contact Page'),
    );
  }
}

