

// import 'package:flutter/src/widgets/container.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

// class Checkout extends StatefulWidget {
//   var itemVal = new Map();
//   Checkout(itemVal){
//     this.itemVal = itemVal;
//   }
//   @override
//   State<Checkout> createState() => _CheckoutState();
// }

// class _CheckoutState extends State<Checkout> {
//   // void initState() {
//   //   super.initState();
//   // }
//   // int final;
//  Future<DocumentSnapshot> CartVal()async{
//  for(var docId in widget.itemVal.keys){
//   final db = FirebaseFirestore.instance;
//   final docRef = db.collection("Menu").doc(docId);
//   docRef.get().then(
//   (DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//   },
//   onError: (e) => print("Error getting document: $e"),
// );

     
//    }
// }

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference Menu = FirebaseFirestore.instance.collection('Menu');
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Checkout"),
//         ),
//         body: FutureBuilder<Widget>(
//        future: CartVal(),
//        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot){
//          if(snapshot.hasData){
//             children: <Widget>[
//         Image.asset('Assets/${snapshot.data["Name"]}.jpg',width: 70.0,height: 70.0,),
//         Text(data['Name']),
//         Text(data['Price'].toString()),
        

//       ],
//          }
//          return Container(child: CircularProgressIndicator());
//        }
//       ),
//       ),
//     );
//   }
// }