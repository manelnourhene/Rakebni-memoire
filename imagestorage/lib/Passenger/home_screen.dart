import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class IdentiteScreen extends StatefulWidget {
  @override
  _IdentiteScreenState createState() => _IdentiteScreenState();
}

class _IdentiteScreenState extends State<IdentiteScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _frontImage;
  File? _backImage;
  final _licenseNumberController = TextEditingController();
  final _dateController = TextEditingController();

  DateTime? _selectedDate;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child('carte d\identitéPass');

  Future<void> _pickImage(bool isFrontImage) async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        if (isFrontImage) {
          _frontImage = File(pickedImage.path);
        } else {
          _backImage = File(pickedImage.path);
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _saveDataToFirebase() async {
    if (_formKey.currentState!.validate() && _frontImage != null && _backImage != null) {
      try {
        // Upload images to Firebase Storage
        String frontFileName = 'IdentitePass/front_${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
        String backFileName = 'IdentitePass/back_${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
        
        UploadTask frontUploadTask = _firebaseStorage.ref().child(frontFileName).putFile(_frontImage!);
        UploadTask backUploadTask = _firebaseStorage.ref().child(backFileName).putFile(_backImage!);

        TaskSnapshot frontSnapshot = await frontUploadTask;
        TaskSnapshot backSnapshot = await backUploadTask;

        String frontImageUrl = await frontSnapshot.ref.getDownloadURL();
        String backImageUrl = await backSnapshot.ref.getDownloadURL();

        // Save data to Firebase Realtime Database
        await _databaseReference.push().set({
          'license_number': _licenseNumberController.text,
          'Expiration_Date': _selectedDate!.toIso8601String(),
          'front_image_url': frontImageUrl,
          'back_image_url': backImageUrl,
        });

        // Clear form after saving
        _licenseNumberController.clear();
        _dateController.clear();
        setState(() {
          _frontImage = null;
          _backImage = null;
          _selectedDate = null;
        });

        // Inform user about successful save
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data saved successfully')),
        );

        // Pop and return completion status
        Navigator.pop(context, {'completed': true});
      } catch (e) {
        // Handle errors
        print('Error saving data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving data')),
        );
      }
    } else if (_frontImage == null || _backImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please add photos on both sides')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ID card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _licenseNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Identity card number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ID card number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text('Front of the identity card', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () => _pickImage(true),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _frontImage == null
                      ? Center(child: Text('Add a picture', style: TextStyle(color: Colors.grey[700])))
                      : Image.file(_frontImage!, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 16),
              Text('Back of the identity card', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () => _pickImage(false),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _backImage == null
                      ? Center(child: Text('Add a picture', style: TextStyle(color: Colors.grey[700])))
                      : Image.file(_backImage!, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Expiration date',
                      hintText: _selectedDate == null
                          ? 'Select date'
                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    ),
                    validator: (value) {
                      if (_selectedDate == null) {
                        return 'Please select expiration date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveDataToFirebase,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
