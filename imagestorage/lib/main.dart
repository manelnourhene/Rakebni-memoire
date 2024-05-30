
import 'package:firebase_core/firebase_core.dart';
// import 'package:imagestorage/home.dart';
// import 'package:imagestorage/login_P.dart';
// import 'package:imagestorage/passenger_driver.dart';
// import 'package:imagestorage/services/Passenger.dart';
// import 'package:imagestorage/services/CallTaxPassHome.dart';
// import 'package:imagestorage/services/get_started.dart';
// import 'package:imagestorage/services/info_driver.dart';
// import 'package:imagestorage/services/inscriptionP_screen.dart';
// import 'package:imagestorage/services/login_D.dart';
import 'package:flutter/material.dart';
import 'package:imagestorage/Start/get_started.dart';

// import 'package:flutter_stripe/flutter_stripe.dart';

// import 'package:home/constants/theme.dart';

// import 'package:admin/provider/app_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

// // ...
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    // return changeNotfierProvider( create :(context)=> AppProvider(), child Material )
    return MaterialApp(
        title: 'Rakebni',
        debugShowCheckedModeBanner: false,
        home: WelcomePage(userEmail: '', name: '', email: '', phone: '',),
      
      );
    
  }
}






























// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:imagestorage/admin/HelperAd.dart';
// import 'package:imagestorage/admin/House.dart';
// import 'package:imagestorage/admin/authAd.dart';
// import 'package:imagestorage/firebase_options.dart';

// final auth = FirebaseAuth.instance;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(
//     MaterialApp(
//       home: auth.currentUser == null ? Login() : HouseAd(),
//     ),
//   );
// }

// class Login extends StatelessWidget {
//   final AuthService authService = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Login to admin Account",
//               style: TextStyle(
//                   color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 15),
//             TextField(
//               controller: authService.email,
//               decoration: InputDecoration(
//                 labelText: "E-mail",
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//             SizedBox(height: 15),
//             TextField(
//               controller: authService.password,
//               decoration: InputDecoration(
//                 labelText: "Password",
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//             SizedBox(height: 15),
//             ElevatedButton(
//               style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 70)),
//               onPressed: () {
//                 if (authService.email.text != "" && authService.password.text != "") {
//                   authService.loginUser(context);
//                 }
//               },
//               child: Text("Login"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => AdminLogin()));
//               },
//               child: Text("Not Admin"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AdminLogin extends StatelessWidget {
//   final AuthService authService = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Login to admin Account",
//               style: TextStyle(
//                   color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 15),
//             TextField(
//               controller: authService.adminEmail,
//               decoration: InputDecoration(
//                 labelText: "E-mail",
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//             SizedBox(height: 15),
//             TextField(
//               controller: authService.adminPassword,
//               decoration: InputDecoration(
//                 labelText: "Password",
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//             SizedBox(height: 15),
//             ElevatedButton(
//               style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 70)),
//               onPressed: () {
//                 if (authService.adminEmail.text != "" && authService.adminPassword.text != "") {
//                   authService.adminLogin(context);
//                 }
//               },
//               child: Text("Login"),
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => AdminLogin()));
//                 },
//                 child: Text("Go To Admin Account"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}




