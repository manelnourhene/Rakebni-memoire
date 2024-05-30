import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class InfoPassenger extends StatefulWidget {
  @override
  _InfoPassengerState createState() => _InfoPassengerState();
}

class _InfoPassengerState extends State<InfoPassenger> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final _prenomController = TextEditingController();
  final _nomController = TextEditingController();
  final _dateController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  DateTime? _selectedDate;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child('passengers');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
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
    if (_formKey.currentState!.validate() && _image != null) {
      try {
        // Upload image to Firebase Storage
        String fileName = 'images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
        UploadTask uploadTask = _firebaseStorage.ref().child(fileName).putFile(_image!);
        TaskSnapshot snapshot = await uploadTask;
        String imageUrl = await snapshot.ref.getDownloadURL();

        // Save data to Firebase Realtime Database
        User? user = _auth.currentUser;
        if (user != null) {
          await _databaseReference.child(user.uid).set({
            'prenom': _prenomController.text,
            'nom': _nomController.text,
            'date_naissance': _selectedDate!.toIso8601String(),
            'email': _emailController.text,
            'phone': _phoneController.text,
            'image_url': imageUrl,
          });

          // Save additional details to Firestore
          await _firestore.collection('users').doc(user.uid).set({
            'prenom': _prenomController.text,
            'nom': _nomController.text,
            'date_naissance': _selectedDate!.toIso8601String(),
            'email': _emailController.text,
            'phone': _phoneController.text,
            'image_url': imageUrl,
          });
        }

        // Clear form after saving
        _prenomController.clear();
        _nomController.clear();
        _emailController.clear();
        _dateController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
        _phoneController.clear();
        setState(() {
          _image = null;
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
    } else if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Add a picture')),
      );
    }
  }

  Future<void> signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        User? user = userCredential.user;
        if (user != null) {
          // Upload image to Firebase Storage
          String fileName = 'images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
          UploadTask uploadTask = _firebaseStorage.ref().child(fileName).putFile(_image!);
          TaskSnapshot snapshot = await uploadTask;
          String imageUrl = await snapshot.ref.getDownloadURL();

          // Save additional details to Firestore
          await _firestore.collection('users').doc(user.uid).set({
            'prenom': _prenomController.text,
            'nom': _nomController.text,
            'date_naissance': _selectedDate!.toIso8601String(),
            'email': _emailController.text,
            'phone': _phoneController.text,
            'image_url': imageUrl,
          });

          // Save data to Firebase Realtime Database
          await _databaseReference.child(user.uid).set({
            'prenom': _prenomController.text,
            'nom': _nomController.text,
            'date_naissance': _selectedDate!.toIso8601String(),
            'email': _emailController.text,
            'phone': _phoneController.text,
            'image_url': imageUrl,
          });

          // Inform user about successful signup
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Signup successful')),
          );

          // Navigate or perform any other necessary actions
        }
      } catch (e) {
        // Handle errors
        print('Error signing up: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error signing up')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Base informations'),
        actions: [
          TextButton(
            onPressed: () {
              // Add close functionality if needed
            },
            child: Text(
              '',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  child: _image == null
                      ? Icon(Icons.camera_alt, color: Colors.white, size: 50)
                      : null,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                ),
              ),
              Center(child: Text('Add a picture')),
              SizedBox(height: 16),
              TextFormField(
                controller: _prenomController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Date of birth',
                      hintText: _selectedDate == null
                          ? 'Select date'
                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    ),
                    validator: (value) {
                      if (_selectedDate == null) {
                        return 'Please select your date of birth';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your E-mail';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone number',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (value.length != 10) {
                    return 'Phone number must be 10 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  await signUp(_emailController.text, _passwordController.text);
                  await _saveDataToFirebase();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

