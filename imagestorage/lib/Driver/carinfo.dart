import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagestorage/resources/add_data.dart';
import 'package:imagestorage/utils.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uint8List? _image; // Liste d'octets pour stocker l'image sélectionnée.
  // Contrôleurs pour les champs
  final TextEditingController _carnameController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _mileageController = TextEditingController();
  final TextEditingController _registrationNumberController = TextEditingController();
  final TextEditingController _insuranceNumberController = TextEditingController();

  Future<void> _selectImage() async {
    final Uint8List? img = await pickImage(ImageSource.gallery); // Sélectionne une image depuis la galerie.
    if (img != null) {
      setState(() {
        _image = img; // Met à jour l'image sélectionnée.
      });
    }
  }

  Future<void> _saveInfo() async {
    // Récupèrations
    final String carName = _carnameController.text;
    final String model = _modelController.text;
    final String year = _yearController.text;
    final String type = _typeController.text;
    final String mileage = _mileageController.text;
    final String registrationNumber = _registrationNumberController.text;
    final String insuranceNumber = _insuranceNumberController.text;

    try {
      final String resp = await StoreData().saveData(  // Appelle la méthode pour sauvegarder les données.
        Carname: carName,
        Model: model,
        Year: year,
        Type: type,
        Milleage: mileage,
        Registrationnumber: registrationNumber,
        Insurancenumber: insuranceNumber,
        file: _image!, // Image sélectionnée.
      );

      // Informe l'utilisateur de la sauvegarde réussie.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data saved successfully')),
      );

      // Retourne à l'écran précédent avec le statut de complétion.
      Navigator.pop(context, {'completed': true});
    } catch (e) {
       // Gère les erreurs.
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Stack(
                children: [
                  _image != null
                      ? Container(
                          width: 128, // Largeur du carré
                          height: 128, // Hauteur du carré
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12), // Bords arrondis du carré
                            image: DecorationImage(
                              image: MemoryImage(_image!), // Image à afficher
                              fit: BoxFit.cover, // Adapter l'image pour remplir le carré
                            ),
                          ),
                        )
                      : Container(
                          width: 128, // Largeur du carré
                          height: 128, // Hauteur du carré
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12), // Bords arrondis du carré
                            color: Colors.grey[300], // Couleur de fond si aucune image n'est disponible
                          ),
                          child: Icon(Icons.add_a_photo, size: 64, color: Colors.grey), // Icône à afficher si aucune image n'est disponible
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: _selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _carnameController,
                decoration: const InputDecoration(
                  hintText: 'Car Name...',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _modelController,
                decoration: const InputDecoration(
                  hintText: 'Model...',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _yearController,
                decoration: const InputDecoration(
                  hintText: 'Year...',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _typeController,
                decoration: const InputDecoration(
                  hintText: 'Type...',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _mileageController,
                decoration: const InputDecoration(
                  hintText: 'Mileage...',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _registrationNumberController,
                decoration: const InputDecoration(
                  hintText: 'Registration Number...',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _insuranceNumberController,
                decoration: const InputDecoration(
                  hintText: 'Insurance Number...',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveInfo,
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
