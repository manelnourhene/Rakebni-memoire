import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Controlleurs pour les champs de texte
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController seatsController = TextEditingController(); // Nouveau contrôleur pour le nombre de places disponibles
  List<TextEditingController> fieldControllers = [];
  List<Contact> contacts = [];
  int selectedIndex = -1;
  String selectedContactId = '';

  final List<String> locations = [
     // Your list of locations
    "Ain Berda",
    "Agence Djezzy-El Bouni",
    "Atmosphère meuble-Chapuis",
    "Avenue Boughazi Said",
    "Avenue Colonel Amirouche",
    "Avenue Mustapha Ben Boulaïd",
    "Avenue AbdelHamid Ben Badis",
    "Berrahal",
    "Beni M'Haffeur",
    "Boukhadra",
    "Boulevard de la Liberté",
    "Boulevard Fellah Rachid-Saint cloud",
    "Boulevard Okba Bnou Nafaa-Centre Ville",
    "Boulevard Rizzi Amor",
    "Boulevard Souidani Boudjemaa",
    "Café Sky Lounge",
    "Cafeteria Belle Vue",
    "Cafeteria Sable D'or",
    "Champ De Mars-Centre Ville",
    "Chetaïbi",
    "Cité Des Orangers",
    "Cité El Abtal",
    "Cité El Hana",
    "Cité Gassiot",
    "Cité PatriceLumumba-Saint cloud",
    "Cité plaisance",
    "Cité Police",
    "Cité Rym",
    "Cité Valmascort",
    "Club Hippique-Aïn Achir",
    "Clinique Belle vue",
    "Clinique Les Jasmins",
    "Croissant Rouge",
    "Draa Errich",
    "Djnenane El Bey",
    "El Hadjar",
    "El Tarf",
    "Faculté de Medecine",
    "Forêt Adventure-Aïn Achir",
    "Gare Ferroviaire",
    "Hassna Event",
    "Hadjar Ed Dis-Sidi Amar",
    "Hôpital El Nouvelle",
    "Hôpital Ibn sina-Caroubiers",
    "Hôpital Iben Rochd",
    "Hôpital Psychiatrique - Aboubaker Er-razi",
    "Hotel El Mouna-Saint cloud",
    "Hotel El Nassim",
    "Hotel El Khalidj-Chapuis",
    "Hotel El Mouna-Saint cloud",
    "Hotel El Mountazah-Seraidi",
    "Hotel Le Majestic",
    "Hotel Milliaire-Boulevard Rizzi Amor",
    "Hotel Rym El Djamil",
    "Hotel Saint cloud 3 étoiles",
    "Hotel Sheraton",
    "Hôtel El Amane-La caroube",
    "Hôtel Mimousa Palace",
    "Hôtel Royal Elisa",
    "Hôtel Seybouse International",
    "Hôtel Soudaif-La caroube",
    "La Cité Joinola",
    "La Colline Rose AADL",
    "La Guitare-La caroube",
    "La Rue Rose",
    "Le cours De La Révolution",
    "Librairie De La Révolution",
    "Méga pizza-Chapuis",
    "Méga pizza-Saint Cloud",
    "Machaoui El Boustane",
    "Mosquée Al Aziz",
    "Mosquée El Forkane",
    "Mosquée Ennor",
    "Mosquée Errahmane",
    "Mosquée Ouhoud",
    "Parc Farouk Land-Sidi Achour",
    "Panaroma-La caroube",
    "Plage Aïn Achir",
    "Plage Belvédère",
    "Plage La caroube",
    "Plage Les Viviers",
    "Plage Militaire",
    "Plage Oued Boukrat",
    "Plage saint cloud",
    "Plage chapuis",
    "Refes Zahouen-Toche",
    "Restaurant Amadeus",
    "Restaurant Crêperie-La caroube",
    "Restaurant La Flambée-Toche",
    "Restaurant La Perle -La caroube",
    "Restaurant La Renaissance",
    "Restaurant Marhaba-La caroube",
    "Restaurant Pacha Corniche",
    "Restaurant The Trone",
    "Rond Point Elisa",
    "Rond Point El Hatab",
    "Rond Point JoannoVille",
    "Rond point du Cap de garde-La caroube",
    "Rue Aoudi-Transformateur",
    "Rue Asla Hocine-El Bouni",
    "Rue Amara Korba",
    "Rue Belaid BelKacem-Pont Blanc",
    "Rue Bichât Youcef-Pont Blanc",
    "Rue B.P-Cefeide",
    "Rue B.K-Cefeide",
    "Rue B.S-Cefeide",
    "Rue De Bougantas",
    "Rue De l'Avant Port",
    "Rue de Aoudi-Transformateur",
    "Rue de Benin_Menadia-",
    "Rue de Cameroun-Saint cloud",
    "Rue de Cirta-Saint cloud",
    "Rue de Cheikh Tahar",
    "Rue de Khremissa-Boulevard",
    "Rue de La Gambie-Transformateur",
    "Rue de La Libération-Saint cloud",
    "Rue de La Mauritanie-Boulevard",
    "Rue de La Menadia",
    "Rue de La Victoire-Menadia",
    "Rue de Libéria-Le beauséjour",
    "Rue de Libye-boulevard",
    "Rue de Madagascar-Boulevard",
    "Rue de Oued Kouba",
    "Rue de Sidi Achour",
    "Rue de Tazoult-Boulevard",
    "Rue de Timgad-Saint cloud",
    "Rue de Zimbabwé-Les crêtes Cité Gassiot",
    "Rue Des Frères Amdour",
    "Rue Du Cameroun-Saint Cloud",
    "Rue El Amir Abd El Kader",
    "Rue Eiffel",
    "Rue Frikh Baghdadi-Centre Ville",
    "Rue Guasmi Amar",
    "Rue Ibn khaldoun",
    "Rue kissoum H'mida",
    "Rue Saouli Abdelkader-Saint Augustin",
    "Rue Seraidi",
    "Rue Sidi Salem",
    "Rue Zighouf Youcef",
    "Salle des fêtes Cristal Bénini",
    "Salle Power Fitness-Transformateur",
    "Salle Power Fitness - Valmascort",
    "Salle Power Fitness - Les allemands",
    "Sidi Amar",
    "Sidi Aissa",
    "Siniet El bey-La caroube",
    "Société Générale-Rizzi Amor",
    "Théâtre Annaba",
    "Taj El Marhaba",
    "Université Badji Mokhtar-El Bouni",
    "Université Badji Mokhtar-Sidi Achour",
    "Université Badji Mokhtar-Sidi Amar",
    "Vieille Ville",
    "Zaafrania",
    "Zaouiat Al Machaoui-La caroube"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Route List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Contact Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: contactController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                  hintText: 'Contact Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: locationController,
                  decoration: const InputDecoration(
                    hintText: 'Location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                suggestionsCallback: (pattern) {
                  return locations.where(
                    (item) => item.toLowerCase().contains(pattern.toLowerCase()),
                  );
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    leading: Icon(Icons.place, color: Colors.red),
                    title: Text(suggestion.toString()),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  locationController.text = suggestion.toString();
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Field'),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.green),
                    onPressed: () {
                      setState(() {
                        fieldControllers.add(TextEditingController());
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: List.generate(
                  fieldControllers.length,
                  (index) => Row(
                    children: [
                      Expanded(
                        child: TypeAheadFormField(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: fieldControllers[index],
                            decoration: InputDecoration(
                              hintText: 'Field ${index + 1}',
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          suggestionsCallback: (pattern) {
                            return locations.where(
                              (item) => item.toLowerCase().contains(pattern.toLowerCase()),
                            );
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              leading: Icon(
                                Icons.place,
                                color: Colors.blue,
                              ),
                              title: Text(suggestion.toString()),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            fieldControllers[index].text = suggestion.toString();
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            fieldControllers.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: destinationController,
                  decoration: const InputDecoration(
                    hintText: 'Destination',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                suggestionsCallback: (pattern) {
                  return locations.where(
                    (item) => item.toLowerCase().contains(pattern.toLowerCase()),
                  );
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    leading: Icon(Icons.place, color: Colors.teal),
                    title: Text(suggestion.toString()),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  destinationController.text = suggestion.toString();
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: seatsController, // Champ pour le nombre de places disponibles
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Number of places available',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  String name = nameController.text.trim();
                  String contact = contactController.text.trim();
                  String location = locationController.text.trim();
                  String destination = destinationController.text.trim();
                  int? availableSeats = int.tryParse(seatsController.text.trim()) ?? 0; // Récupérer le nombre de places disponibles
                  List<String> fields = fieldControllers.map((controller) => controller.text.trim()).toList();
                  DateTime now = DateTime.now(); // Récupérer la date et l'heure actuelles

                  if (selectedIndex == -1) {
                    // Ajouter un nouveau contact
                    if (name.isNotEmpty && contact.isNotEmpty) {
                      Contact newContact = Contact(
                        name: name,
                        contact: contact,
                        location: location,
                        fields: fields,
                        destination: destination,
                        availableSeats: availableSeats, // Enregistrer le nombre de places disponibles
                        timestamp: now,
                      );
                      setState(() {
                        contacts.add(newContact); // Ajouter le contact à la liste
                      });
                      await _saveContactToFirestore(newContact); // Enregistrer le contact dans Firestore
                      nameController.clear();
                      contactController.clear();
                      locationController.clear();
                      destinationController.clear();
                      seatsController.clear(); // Effacer le champ du nombre de places disponibles
                      fieldControllers.clear();
                    }
                  } else {
                    // Mettre à jour un contact existant
                    Contact updatedContact = contacts[selectedIndex];
                    updatedContact.name = name;
                    updatedContact.contact = contact;
                    updatedContact.location = location;
                    updatedContact.fields = fields;
                    updatedContact.destination = destination;
                    updatedContact.availableSeats = availableSeats; // Mettre à jour le nombre de places disponibles
                    updatedContact.timestamp = now;

                    setState(() {
                      contacts[selectedIndex] = updatedContact;
                    });
                    await _updateContactInFirestore(updatedContact); // Mettre à jour le contact dans Firestore

                    setState(() {
                      selectedIndex = -1; // Réinitialiser l'index sélectionné après la mise à jour
                    });
                    nameController.clear();
                    contactController.clear();
                    locationController.clear();
                    destinationController.clear();
                    seatsController.clear(); // Effacer le champ du nombre de places disponibles
                    fieldControllers.clear();
                  }
                },
                child: const Text('Save'),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  var contact = contacts[index];
                  return Card(
                    child: ListTile(
                      title: Text(contact.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(contact.contact),
                          if (contact.location != null) Text('Location: ${contact.location}'),
                          if (contact.fields.isNotEmpty)
                            ...List.generate(contact.fields.length, (fieldIndex) {
                              return Text('Field ${fieldIndex + 1}: ${contact.fields[fieldIndex]}');
                            }),
                          if (contact.destination != null) Text('Destination: ${contact.destination}'),
                          if (contact.availableSeats != null) Text('Available Seats: ${contact.availableSeats}'), // Afficher le nombre de places disponibles
                          _buildDateText(contact.timestamp),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              setState(() {
                                selectedIndex = index;
                                nameController.text = contact.name;
                                contactController.text = contact.contact;
                                locationController.text = contact.location ?? '';
                                fieldControllers = contact.fields.map((field) => TextEditingController(text: field)).toList();
                                destinationController.text = contact.destination ?? '';
                                seatsController.text = contact.availableSeats?.toString() ?? ''; // Pré-remplir le champ du nombre de places disponibles
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateText(DateTime timestamp) {
    return Text('Date: ${DateFormat('dd-MM-yyyy HH:mm').format(timestamp)}');
  }

  Future<void> _saveContactToFirestore(Contact contact) async {
    DocumentReference docRef = await FirebaseFirestore.instance.collection('contacts').add(contact.toMap());
    contact.id = docRef.id; // Enregistrer l'ID généré dans le contact
    setState(() {
      int index = contacts.indexOf(contact);
      if (index != -1) {
        contacts[index] = contact;
      }
    });
  }

  Future<void> _updateContactInFirestore(Contact contact) async {
    if (contact.id != null) {
      await FirebaseFirestore.instance.collection('contacts').doc(contact.id).update(contact.toMap());
    }
  }
}

class Contact {
  String? id;
  String name;
  String contact;
  String? location;
  List<String> fields;
  String? destination;
  int? availableSeats; // Nouvelle propriété pour le nombre de places disponibles
  DateTime timestamp;

  Contact({
    this.id,
    required this.name,
    required this.contact,
    this.location,
    required this.fields,
    this.destination,
    this.availableSeats,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'contact': contact,
      'location': location,
      'fields': fields,
      'destination': destination,
      'availableSeats': availableSeats,
      'timestamp': timestamp,
    };
  }
}
