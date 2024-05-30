import 'package:flutter/material.dart';
import 'package:imagestorage/Passenger/contact.dart';
import 'package:imagestorage/Passenger/searchD.dart';
import 'package:imagestorage/Passenger/listDriver.dart';
import 'package:imagestorage/services/myprofileD.dart';
 // Importez votre nouvelle page ici

class CallTaxi extends StatefulWidget {
  final String userEmail;

  CallTaxi({required this.userEmail});

  @override
  State<CallTaxi> createState() => _CallTaxiState();
}

class _CallTaxiState extends State<CallTaxi> {
   int _selectedIndex =0;

  static List<Widget> _widgetOptions = <Widget>[
   
    Itisal(),     
    SearchPagePass(savedContacts: [],),        
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20), // Espacement sous le texte "Welcome Amal"
          Divider(
            color: Colors.grey, // couleur de la ligne de séparation
            thickness: 2, // épaisseur de la ligne de séparation
            indent: 20, // indentation à gauche de la ligne de séparation
            endIndent: 20, // indentation à droite de la ligne de séparation
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(216, 171, 88, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(30),
            constraints: BoxConstraints(
              minWidth: 200,
              minHeight: 150,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Book Taxi Now ?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            // Naviguer vers la nouvelle page lorsque "Call a Taxi" est cliqué
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SearchPagePass(savedContacts: [],)),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 249, 237, 237),
                              borderRadius: BorderRadius.circular(10), // Bord arrondi
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Call a Taxi',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.arrow_forward),
                                  onPressed: () {
                                    // Ajoutez ici la logique pour gérer le clic sur la flèche
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/call.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15), // Espacement sous le conteneur existant
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5), // Espacement entre les textes
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5), // Espacement sous le conteneur existant
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20.0, top: 20.0), // Marge à gauche et en haut
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0), // Marge à gauche et en haut
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
         currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}

