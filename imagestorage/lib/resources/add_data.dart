import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'; 



final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
class StoreData{
  
 Future<String> uploadImageToStorage(String childName, Uint8List file) async {
  String imageName = '${DateTime.now().millisecondsSinceEpoch}.jpg'; // Nom de fichier unique
  Reference ref = _storage.ref().child(childName).child(imageName);
  UploadTask uploadTask = ref.putData(file);
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}

  
  Future<String> saveData({
    required String Carname,
    required String Model, 
    required String Year, 
     required String Type, 
    required String Milleage, 
    required String Registrationnumber, 
    required String Insurancenumber, 
    required Uint8List file,
    }) async{
      String resp ="Some Error Occured";
      try{
        if(Carname.isNotEmpty || Model.isNotEmpty || Year.isNotEmpty ||  Type.isNotEmpty || Milleage.isNotEmpty 
        || Registrationnumber.isNotEmpty || Insurancenumber.isNotEmpty)
        {

      String imageUrl = await uploadImageToStorage('CarImage', file);
      await _firestore.collection('InfoCars').add({
      'Carname': Carname,
      'Model' : Model,
      'Year' : Year,
      'Milleage' : Milleage,
      'Type' : Type,
      'Registration number': Registrationnumber,
      'Insurance number' : Insurancenumber,
      'ImageLink' : imageUrl,

      });
      }
      resp = 'success';
      }
      catch(err){
        resp =err.toString();
      }
      return resp;
    }
}