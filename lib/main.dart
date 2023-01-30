import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'Admin/AdminLogin.dart';
import 'User/UserLogin.dart';
import 'firebase_options.dart';
// import 'package:online_order/Screens/FoodPage.dart';

Future<void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    routes: {
        '/adminLogin':(context) => const AdminLogin(),
        '/userLogin':(context) => const UserLogin(),
      },
    debugShowCheckedModeBanner: false,
    home:LoginPage()));
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

 
  adminLogin(){
      Navigator.pushNamed(context, '/adminLogin');
    }
  userLogin(){
      Navigator.pushNamed(context, '/userLogin');
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(
          title: Text('Select Your Role'),
        ),
        body: Center(
          child:Column(
      
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 25.0,),
            ElevatedButton(onPressed: adminLogin, 
            child: const Text('Admin')),
            ElevatedButton(onPressed: userLogin, 
            child: const Text('User')),
          ],
        ),
        )
      );
    
  }





}



