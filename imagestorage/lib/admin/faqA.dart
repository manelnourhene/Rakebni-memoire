import 'package:flutter/material.dart'; // Importation de la bibliothèque Flutter pour créer l'interface utilisateur.
import 'package:cloud_firestore/cloud_firestore.dart'; // Importation de la bibliothèque Firestore pour interagir avec la base de données Firestore.

class FaQDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),  // Titre de la barre d'application.
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('admin').doc('FaQ').snapshots(), // Écoute en temps réel des modifications du document 'FaQ' dans la collection 'admin' de Firestore.
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) { // Vérifie si les données n'ont pas encore été chargées.
            return Center(
              child: CircularProgressIndicator(), // Affiche un indicateur de progression circulaire.
            );
          }
          var faqData = snapshot.data!.data(); // Récupère les données du snapshot.
          return ListView.builder(
            itemCount: faqData!.length, // Nombre d'éléments dans la FAQ.
            itemBuilder: (BuildContext context, int index) {
              var question = faqData.keys.elementAt(index); // Récupère la question à l'index actuel.
              var answer = faqData.values.elementAt(index); // Récupère la réponse correspondante à la question.
              return ListTile(
                title: Text(question),
                subtitle: Text(answer.toString()), // Affiche la réponse convertie en chaîne de caractères.
              );
            },
          );
        },
      ),
    );
  }
}
