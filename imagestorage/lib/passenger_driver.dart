import 'package:flutter/material.dart';
import 'package:imagestorage/admin/authAd.dart';
import 'package:imagestorage/Passenger/login_P.dart';
import 'package:imagestorage/Driver/login_D.dart';


class MyChoice extends StatefulWidget {
  const MyChoice({Key? key});

  @override
  State<MyChoice> createState() => _MyChoiceState();
}

class _MyChoiceState extends State<MyChoice> {
  String selectedSnack = 'None selected';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Are you a passenger or driver?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'You can change the mode later.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 135, 135, 135),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40), // Ajouter un borderRadius
              ),
              child: Image.asset(
                'images/imgcar.png', // Chemin de l'image
                width: 340, // Largeur de l'image
                height: 260, // Hauteur de l'image
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Couleur du cadre
                    width: 1, // Largeur du cadre
                  ),
                  borderRadius: BorderRadius.circular(10), // Bord arrondi du cadre
                ),
                child: RadioListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/traveler.png', // Chemin de l'image
                            width: 30, // Largeur de l'image
                            height: 30, // Hauteur de l'image
                          ),
                          const SizedBox(width: 10),
                          const Text('A passenger'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'You want to use ride sharing services as a passenger',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  value: ' A passenger ',
                  groupValue: selectedSnack,
                  onChanged: (selectedValue) {
                    setState(() => selectedSnack = selectedValue.toString());
                  },
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Couleur du cadre
                    width: 1, // Largeur du cadre
                  ),
                  borderRadius: BorderRadius.circular(10), // Bord arrondi du cadre
                ),
                child: RadioListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/taxi-driver.png', // Chemin de l'image
                            width: 30, // Largeur de l'image
                            height: 30, // Hauteur de l'image
                          ),
                          const SizedBox(width: 10),
                          const Text('A driver'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'You want to use ride sharing services as a driver',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  value: ' A driver ',
                  groupValue: selectedSnack,
                  onChanged: (selectedValue) {
                    setState(() => selectedSnack = selectedValue.toString());
                  },
                ),
              ),
            ),
            const SizedBox(height: 30), // Espace avant le bouton "Continuer"
            ElevatedButton(
              onPressed: () {
                if (selectedSnack == ' A passenger ') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogInP()),
                  );
                } else if (selectedSnack == ' A driver ') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogInD()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 111, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20), // Espace avant le texte "Admin Login"
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthAd()),
                );
              },
              child: const Text(
                'Admin Login',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
