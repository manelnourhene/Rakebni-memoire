import 'package:firebase_auth/firebase_auth.dart'; // Importation de la bibliothèque Firebase Auth pour l'authentification.
import 'package:flutter/material.dart'; // Importation de la bibliothèque Flutter pour créer l'interface utilisateur.
import 'package:cloud_firestore/cloud_firestore.dart'; // Importation de la bibliothèque Firestore pour interagir avec la base de données Firestore.
import 'package:imagestorage/admin/House.dart'; // Importation de la classe HouseAd (assurez-vous que le chemin est correct).

class AuthAd extends StatefulWidget {
  @override
  _AuthAdState createState() => _AuthAdState(); // Création de l'état associé au widget AuthAd.
}

class _AuthAdState extends State<AuthAd> {
  bool _isObscure3 = true; // Variable pour gérer la visibilité du mot de passe.
  bool visible = false; // Variable pour gérer la visibilité de l'indicateur de progression.
  final _formkey = GlobalKey<FormState>(); // Clé globale pour le formulaire.
  final TextEditingController emailController = TextEditingController(); // Contrôleur pour le champ email.
  final TextEditingController passwordController = TextEditingController(); // Contrôleur pour le champ mot de passe.

  final _auth = FirebaseAuth.instance; // Instance de FirebaseAuth.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Color.fromARGB(255, 200, 191, 10), // Couleur de fond du conteneur.
              width: MediaQuery.of(context).size.width, // Largeur du conteneur.
              height: MediaQuery.of(context).size.height * 0.70, // Hauteur du conteneur.
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(12), // Marge autour du conteneur.
                  child: Form(
                    key: _formkey, // Assignation de la clé de formulaire
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Alignement vertical centré.
                      crossAxisAlignment: CrossAxisAlignment.center, // Alignement horizontal centré.
                      children: [
                        SizedBox(height: 30), // Espace vertical de 30 pixels.
                        Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40,
                          ), // Style du texte "Login".
                        ),
                        SizedBox(height: 20), // Espace vertical de 20 pixels.
                        TextFormField(
                          controller: emailController, // Contrôleur pour le champ email.
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email', // Texte indicatif pour l'email.
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0), // Marges internes du champ.
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),// Bordure en cas de focus.
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ), // Bordure quand activé
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email cannot be empty"; // Message d'erreur si le champ est vide.
                            }
                            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return "Please enter a valid email"; // Message d'erreur si l'email n'est pas valide.
                            }
                            return null;
                          },
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                          keyboardType: TextInputType.emailAddress, // Type de clavier pour email.

                        ),
                        SizedBox(height: 20),  // Espace vertical de 20 pixels.
                        TextFormField( 
                          controller: passwordController, // Contrôleur pour le champ mot de passe.
                          obscureText: _isObscure3,  // Masque le texte si _isObscure3 est vrai.
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                  _isObscure3 ? Icons.visibility : Icons.visibility_off), // Icône de visibilité.
                              onPressed: () {
                                setState(() {
                                  _isObscure3 = !_isObscure3;  // Inverse la visibilité du mot de passe.
                                });
                              },
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',  // Texte indicatif pour le mot de passe.
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 15.0), // Marges internes du champ.
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ), // Bordure en cas de focus.
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),// Bordure quand activé.
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password cannot be empty"; // Message d'erreur si le champ est vide.
                            }
                            if (value.length < 6) {
                              return "Please enter a valid password with at least 6 characters"; // Message d'erreur si le mot de passe est trop court.
                            }
                            return null;
                          },
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                        ),
                        SizedBox(height: 20), // Espace vertical de 20 pixels.
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0))), // Forme du bouton.
                          elevation: 5.0,
                          height: 40,
                          onPressed: () {
                            setState(() {
                              visible = true; // Affiche l'indicateur de progression.
                            });
                            signIn(emailController.text, passwordController.text); // Appelle la fonction de connexion.
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20),  // Style du texte du bouton.
                          ),
                          color: Colors.white, // Couleur du bouton.
                        ),
                        SizedBox(height: 10), // Espace vertical de 10 pixels.
                        Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: visible, // Gère la visibilité de l'indicateur de progression.
                          child: Container(
                            child: CircularProgressIndicator(color: Colors.white), // Indicateur de progression.
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white, // Couleur de fond du conteneur.
              width: MediaQuery.of(context).size.width, // Largeur du conteneur.
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Alignement vertical centré.
                  crossAxisAlignment: CrossAxisAlignment.center, // Alignement horizontal centré.
                  children: [
                    SizedBox(height: 20), // Espace vertical de 20 pixels.
                    Text(
                      "Made by",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40), // Style du texte.
                    ),
                    SizedBox(height: 5), // Espace vertical de 5 pixels.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Alignement centré.
                      children: [
                        Text(
                          "MN",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color.fromARGB(255, 24, 1, 7)), // Style du texte.
                        ),
                        Text(
                          "S",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color.fromARGB(255, 24, 1, 7)), // Style du texte.
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void route() async {
    User? user = FirebaseAuth.instance.currentUser; // Récupère l'utilisateur actuellement connecté.
    if (user != null) {
      var documentSnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .doc('adminLogin')
          .get(); // Récupère le document de connexion admin dans Firestore.
      if (documentSnapshot.exists) {
           // Vérifie si le document existe.
        if (documentSnapshot['adminEmail'] == emailController.text &&
            documentSnapshot['adminPassword'] == passwordController.text) {
                // Vérifie les informations d'identification de l'admin.
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HouseAd()), // Redirige vers la page d'accueil de l'admin.
          );
        } else {
          print('Invalid admin credentials'); // Affiche un message d'erreur si les informations sont invalides.
          setState(() {
            visible = false; // Cache l'indicateur de progression.
          });
        }
      } else {
        print('Document does not exist in the database'); // Affiche un message si le document n'existe pas.
        setState(() {
          visible = false; // Cache l'indicateur de progression.
        });
      }
    }
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
       // Vérifie si le formulaire est valide.
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        ); // Tente de se connecter avec l'email et le mot de passe.
        route(); // Appelle la fonction de routage.
      } on FirebaseAuthException catch (e) {
        setState(() {
          visible = false; // Cache l'indicateur de progression.
        });
        if (e.code == 'user-not-found') {
          print('No user found for that email.');  // Affiche un message si l'utilisateur n'est pas trouvé.
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.'); // Affiche un message si le mot de passe est incorrect.
        }
      }
    }
  }
}

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder(); // Widget de remplacement pour la page d'inscription.
  }
}



