import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> main() async {
// WidgetsFlutterBinding.ensureInitialized();

//  await Firebase.initializeApp();
//  runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//  const MyApp({Key? key}) : super(key: key);

//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//  return MaterialApp(
//  title: 'Flutter Demo',
//  theme: ThemeData(
//  primarySwatch: Colors.blue,
//  ),
//  home: const MyHomePage(title: 'Flutter Demo Home Page'),
//  );
//  }
// }

// class MyHomePage extends StatefulWidget {
//  const MyHomePage({Key? key, required this.title}) : super(key: key);

//  final String title;

//  @override
//  State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//  final Stream<QuerySnapshot> _usersStream =
//  FirebaseFirestore.instance.collection('users').snapshots();

//  @override
// Widget build(BuildContext context) {
//  return Scaffold(
//  appBar: AppBar(
//  title: Text(widget.title),
//  ),
//  body: SingleChildScrollView(
//  child: Container(
//  margin: EdgeInsets.symmetric(
//   vertical: MediaQuery.of(context).size.height * 0.04,
//   horizontal: MediaQuery.of(context).size.width * 0.04),
//  child: Column(
//   mainAxisAlignment: MainAxisAlignment.start,
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: <Widget>[
//   const Text(
//    'Enter user name',
//   style: TextStyle(fontSize: 16),
//   ),
//   const SizedBox(
//   height: 10,
//   ),
//   TextField(

//   onChanged: (value) {
//   //Do something with the user input.

//   },
//   decoration: const InputDecoration(
//   hintText: 'Enter your password.',
//   contentPadding:
//    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//   border: OutlineInputBorder(
//    borderRadius: BorderRadius.all(Radius.circular(6.0)),
//   ),
//   ),
//   ),

//   , icon: Icon(Icons.add), label: Text('Add user')),
//   const SizedBox(
//   height: 20,
//   ),
//   StreamBuilder<QuerySnapshot>(
//   stream: _usersStream,
//   builder: (BuildContext context,
//    AsyncSnapshot<QuerySnapshot> snapshot) {
//    if (snapshot.hasError) {
//    return const Text('Something went wrong');
//    }
//    if (snapshot.connectionState == ConnectionState.waiting) {
//    return const Text("Loading");
//    }
//    return ListView(
//    shrinkWrap: true,
//    children:
//    snapshot.data!.docs.map((DocumentSnapshot document) {
//    Map<String, dynamic> data =
//     document.data()! as Map<String, dynamic>;
//    return ListTile(
//    title: Text(data['name']),
//    );
//    }).toList(),
//    );
//   })
//   ],
//  ),
//  ),
//  ),
//  );
// }
// }


// ListView(
//             shrinkWrap: true,
//             children:snapshot.data!.docs.map((DocumentSnapshot document) {
//             Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//             return ListTile(
//             title: Text(data['Name']),
//             );
//             }).toList(),
//             );