import 'package:cloud_firestore/cloud_firestore.dart'; // Importation de la bibliothèque Firestore pour interagir avec la base de données Firestore.
import 'package:flutter/material.dart'; // Importation de la bibliothèque Flutter pour créer l'interface utilisateur.

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});  // Constructeur de la classe AdminPanel.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rakebni"), // Titre de la barre d'application.
      ),
      body: StreamBuilder(
        // Récupération en temps réel des documents de la collection "user" dans Firestore.
        stream: FirebaseFirestore.instance.collection("user").snapshots(), 
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            // Vérifie si les données sont disponibles.
            return ListView.builder(
              itemCount: snapshot.data!.docs.length, // Nombre d'éléments dans la liste égale au nombre de documents dans la collection.
              itemBuilder: (context, i) {
                 // Construit chaque élément de la liste.
                return Container(
                  width: 200,
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Marge autour du conteneur.
                  color: Colors.green.shade200, // Couleur de fond du conteneur.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // Alignement des enfants de la colonne au centre horizontalement.
                    children: [
                      Text("Name : " + snapshot.data!.docs[i]['name']), // Affichage du nom de l'utilisateur à partir des données Firestore.
                      SizedBox(height: 10), // Espace vertical de 10 pixels.
                    ],
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator(); // Affiche un indicateur de progression circulaire en attendant les données.
          }
        },
      ),
    );
  }
}
