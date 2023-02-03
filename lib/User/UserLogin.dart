import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:online_order/Admin/AdminPage.dart';
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
              Text(err==null?"":err.toString()),
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
      final db = FirebaseFirestore.instance;
       User? user = FirebaseAuth.instance.currentUser;
       if(user!=null){
       Map<String,dynamic> data = {"uid":user.uid,"role":"user"};
        final newUsertoDb = await db.collection("User").doc(user.uid).set(data);
        Navigator.push(context, MaterialPageRoute(
       builder: (context) => HomePage()));

       }
     
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

    if(user!=null){
        final db = FirebaseFirestore.instance;
        final docRef = db.collection("User").doc(user.uid);
        docRef.get().then(
          (DocumentSnapshot doc) {
            final data = doc.data() as Map<String, dynamic>;
            if(data["role"]=="user"){
                 Navigator.push(context, MaterialPageRoute(
                 builder: (context) => HomePage()));

            }
            else if(data["role"]=="admin"){
               Navigator.push(context, MaterialPageRoute(
                 builder: (context) => const AdminPage()));
            }
          },
          onError: (e) => print("Error getting document: $e"),
        );

    }
  
 

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

