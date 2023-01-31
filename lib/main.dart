import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:online_order/User/HomePage.dart';
import 'Admin/AdminLogin.dart';
import 'User/UserLogin.dart';
import 'firebase_options.dart';
// import 'package:online_order/Screens/FoodPage.dart';

Future<void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(

    debugShowCheckedModeBanner: false,
    home:LoginPage()));
}

class LoginPage extends StatelessWidget {
 final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
 Widget build(BuildContext context){
        return FutureBuilder<User>(
            future: Future.value(FirebaseAuth.instance.currentUser),
            builder: (BuildContext context, AsyncSnapshot<User> snapshot){
                       if (snapshot.hasData){
                           final user = snapshot.data; // this is your user instance
                           /// is because there is user already logged
                           return const HomePage();
                        }
                         /// other way there is no user logged.
                         return UserLogin();
             }
          );
    }
    
  






}


