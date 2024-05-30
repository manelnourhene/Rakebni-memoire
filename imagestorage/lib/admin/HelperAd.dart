import 'package:cloud_firestore/cloud_firestore.dart'; // Importation de la bibliothèque Firestore pour interagir avec la base de données Firestore.
import 'package:flutter/material.dart'; // Importation de la bibliothèque Flutter pour créer l'interface utilisateur.
import 'package:firebase_auth/firebase_auth.dart'; // Importation de la bibliothèque Firebase Auth pour l'authentification.
import 'package:imagestorage/admin/House.dart'; // Importation de la classe HouseAd (assurez-vous que le chemin est correct).
import 'package:imagestorage/admin/adminPanel.dart'; // Importation de la classe AdminPanel 

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance; // Instance de FirebaseAuth.
  final TextEditingController email = TextEditingController(); // Contrôleur pour le champ email.
  final TextEditingController adminEmail = TextEditingController(); // Contrôleur pour le champ email de l'admin.
  final TextEditingController adminPassword = TextEditingController(); // Contrôleur pour le champ mot de passe de l'admin.
  final TextEditingController password = TextEditingController();  // Contrôleur pour le champ mot de passe.

  final FirebaseFirestore firestore = FirebaseFirestore.instance; // Instance de FirebaseFirestore.

  void loginUser(BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email.text,  // Récupère l'email depuis le champ de texte.
        password: password.text, // Récupère le mot de passe depuis le champ de texte.
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HouseAd()), // Redirige vers la page d'accueil de l'utilisateur.
        (route) => false, // Supprime toutes les autres routes de la pile de navigation.
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error Message"), // Titre de la boîte de dialogue d'erreur.
            content: Text(e.toString()), // Affiche le message d'erreur.
          );
        },
      );
    }
  }

  void adminLogin(BuildContext context) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: CircularProgressIndicator(), // Affiche un indicateur de progression dans une boîte de dialogue.
            ),
          );
        },
      );

      await auth.signInWithEmailAndPassword(
        email: adminEmail.text, // Récupère l'email de l'admin depuis le champ de texte.
        password: adminPassword.text, // Récupère le mot de passe de l'admin depuis le champ de texte.
      );

      firestore.collection("admin").doc("adminLogin").snapshots().listen((event) {
        final adminData = event.data(); // Récupère les données de l'admin.
        if (adminData != null && adminData['adminEmail'] == adminEmail.text && adminData['adminPassword'] == adminPassword.text) {
           // Vérifie les informations d'identification de l'admin.
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AdminPanel()),
            (route) => false, // Supprime toutes les autres routes de la pile de navigation.
          );
        }
      });
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error Message"),
            content: Text(e.toString()), // Affiche le message d'erreur.
          );
        },
      );
    }
  }
}
