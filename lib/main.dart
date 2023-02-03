import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:online_order/User/HomePage.dart';
import 'package:provider/provider.dart';
import 'Providers/Cart.dart';
import 'User/UserLogin.dart';
import 'firebase_options.dart';
// import 'package:online_order/Screens/FoodPage.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child:  MaterialApp(

    debugShowCheckedModeBanner: false,
    home:LoginPage()),
    ),
  );
  //   runApp(
  //   DevicePreview(
  //     enabled: true,
  //     tools: [
  //       ...DevicePreview.defaultTools,
  //       const CustomPlugin(),
  //     ],
  //     builder: (context) => const BasicApp(),
  //   ),
  // );

}

  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     tools: [
  //       ...DevicePreview.defaultTools,
  //       const CustomPlugin(),
  //     ],
  //     home:LoginPage(),
  //   ),
  // );


class LoginPage extends StatelessWidget {
 final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
           
            return const UserLogin();
          }
          return const HomePage();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
  }










