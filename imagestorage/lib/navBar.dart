// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imagestorage/Driver/home.dart';
import 'package:imagestorage/taxi.dart';

class NavBarRoots extends StatefulWidget{
  @override
  State<NavBarRoots> createState() => _NavBarRootsState();
}

class _NavBarRootsState extends State<NavBarRoots> {
  
  int  _selectedIndex =0;
  final _screens =[
      // Home Screen 
    
      // Message Screen 
  // HomePage(),
      //Schedule Screen
      // ListeTaxiPage(contacts: [],),
      // Settings Screen 
      // Container(),
  ];

  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body:  _screens[ _selectedIndex],
      bottomNavigationBar: Container(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color.fromARGB(255, 20, 99, 6),
          unselectedItemColor: Colors.black38,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          currentIndex: _selectedIndex,
          onTap: (index){
            setState(() {
              _selectedIndex = index;
            });

          },
          // add items to the navbar 
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled),
            label: "Home",
            ),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.chat_bubble_fill),
            label: "Message",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.add),
            label: "Add",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person),
            label: "Settings",
            ),

            ],
        ),
      ),
    );
     
  }
}
