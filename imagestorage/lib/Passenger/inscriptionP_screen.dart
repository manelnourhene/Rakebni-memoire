import 'package:flutter/material.dart';
import 'package:imagestorage/Driver/driver.dart';
import 'package:imagestorage/Passenger/info_passenger.dart';
import 'package:imagestorage/Passenger/home_screen.dart';
import 'package:imagestorage/Passenger/login_P.dart';

class InscriptionPScreen extends StatefulWidget {
  @override
  _InscriptionPScreenState createState() => _InscriptionPScreenState();
}

class _InscriptionPScreenState extends State<InscriptionPScreen> {
  bool _isBasicInfoCompleted = false;
  bool _isIdentityCompleted = false;

 void _updateCompletionStatus(String step, bool completed) {
  setState(() {
    if (step == 'basic_info') {
      _isBasicInfoCompleted = completed;
    } else if (step == 'identity') {
      _isIdentityCompleted = completed;
    }
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
                  MaterialPageRoute(builder: (context) => InfoPassenger()),
                );
                if (result != null && result['completed']) {
                  _updateCompletionStatus('basic_info', true);

                }
              },
            ),
            SizedBox(height: 16),
            _buildStep(
              title: 'ID Card',
              completed: _isIdentityCompleted,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IdentiteScreen()),
                );
                if (result != null && result['completed']) {
                  _updateCompletionStatus('identity', true);
                }
              },
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isBasicInfoCompleted && _isIdentityCompleted
                  ? () {
                      // Navigate to the next screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogInP()),
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

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Success')),
      body: Center(child: Text('Registration completed successfully!')),
    );
  }
}
