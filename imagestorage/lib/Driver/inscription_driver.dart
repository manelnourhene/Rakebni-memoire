import 'package:flutter/material.dart';
import 'package:imagestorage/Driver/carinfo.dart';
import 'package:imagestorage/Driver/driver.dart';
import 'package:imagestorage/Driver/info_driver.dart';
import 'package:imagestorage/Driver/login_D.dart';
import 'package:imagestorage/Driver/permisD_screen.dart';

class InscriptionDScreen extends StatefulWidget {
  @override
  _InscriptionDScreenState createState() => _InscriptionDScreenState();
}

class _InscriptionDScreenState extends State<InscriptionDScreen> {
  // Des indicateurs qui verifie si toutes les informations sont complétées.
  bool _isBasicInfoCompleted = false;
  bool _isIdentityCompleted = false;
  bool _isVehicleInfoCompleted = false;

  // methode pour mettre a jour l'etat de completion
  void _updateCompletionStatus(String step, bool completed) {
    setState(() {
      if (step == 'basic_info') {
        _isBasicInfoCompleted = completed;
      } else if (step == 'identity') {
        _isIdentityCompleted = completed;
      } else if (step == 'vehicle_info') {
        _isVehicleInfoCompleted = completed;
      }
    });
  }

  // Méthode pour mettre à jour l'état de complétion des informations sur le véhicule
  void _updateVehicleInfoCompletion(bool completed) {
  setState(() {
    _isVehicleInfoCompleted = completed;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
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
        child: Column(
          children: [
            _buildStep(
              title: 'Base informations',
              completed: _isBasicInfoCompleted,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfoDriver()),
                );
                if (result != null && result['completed']) {
                  _updateCompletionStatus('basic_info', true);
                }
              },
            ),
            SizedBox(height: 16),
            _buildStep(
              title: 'Driving license',
              completed: _isIdentityCompleted,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PermisDScreen()),
                );
                if (result != null && result['completed']) {
                  _updateCompletionStatus('identity', true);
                }
              },
            ),
            SizedBox(height: 16),
            _buildStep(
              title: 'Vehicle info',
              completed: _isVehicleInfoCompleted,
              onTap: () async {
              final result = await Navigator.push(
                 context,
               MaterialPageRoute(builder: (context) => MyHomePage(title: 'Info Car')),
           );
                if (result != null && result['completed']) {
                   _updateVehicleInfoCompletion(true);
               }
              },
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isBasicInfoCompleted && _isIdentityCompleted && _isVehicleInfoCompleted
                  ? () {
                      // Navigate to the next screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogInD()),
                      );
                    }
                  : null,
              child: Text('Complete'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // full width button
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Widget pour afficher chaque étape de l'inscription
  Widget _buildStep({required String title, required bool completed, required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(title),
        trailing: completed ? Icon(Icons.check, color: Colors.green) : Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}

class VehicleInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vehicle info')),
      body: Center(
        child: Text('Enter vehicle information here'),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Success')),
      body: Center(child: Text('Registration completed successfully!')),
    );
  }
}
