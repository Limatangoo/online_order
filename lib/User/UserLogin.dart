import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'HomePage.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  String ?_email, _password,err;
  final emailData = TextEditingController();
  final pwdData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: <String,WidgetBuilder>{
      //   "/Homepage":(context) => const HomePage()
      // },
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (input) {
                  if(input!.isEmpty){
                    return 'Please enter an email';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: const InputDecoration(labelText: 'Email'),
                controller: emailData,
              ),
              TextFormField(
                validator: (input) {
                  if(input!.length < 6){
                    return 'Your password needs to be at least 6 characters';
                  }
                },
                onSaved: (input) => _password = input,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                controller: pwdData,
              ),
              SizedBox(height: 25.0,),
              Text(err.toString()),
              ElevatedButton(
                onPressed: (){userLogIn();},
                child: const Text('Sign in'),
              ),
              ElevatedButton(
                onPressed: ()=>{signIn()},
                child: const Text('Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
    Future<void> signIn () async{
    
      try {
  final newUser = await _auth.createUserWithEmailAndPassword(
      email: emailData.text, password: pwdData.text);
  if (newUser != null) {
        Navigator.push(context, MaterialPageRoute(
       builder: (context) => HomePage()));
  }
  } on FirebaseAuthException catch (e) {
       print(e);
  }

}
  Future<void> userLogIn () async{
    
      try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailData.text,
      password: pwdData.text
    );
    final user = credential.user;
    //  return HomePage();
    // print("authenticated");
    Navigator.push(context, MaterialPageRoute(
       builder: (context) => HomePage()));

  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      setState(() {
        err = 'No user found for that email.';
      });
      
    
    } else if (e.code == 'wrong-password') {
      setState(() {
        err = 'Wrong password provided for that user.';
      });
      
      
    }
  }

}

}

