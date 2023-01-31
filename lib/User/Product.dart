
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:badges/badges.dart' as badges;
// import 'package:provider/provider.dart';

// import '../Providers/Cart.dart';
// import 'Checkout.dart';

// class Product extends StatefulWidget {
//   var productId;
//   Product(productId){
//     this.productId = productId;
//   }

//   @override
//   State<Product> createState() => _ProductState();
// }

// class _ProductState extends State<Product> {
//   Future<String> Product()async{
//   final db = FirebaseFirestore.instance;
//   final docRef = db.collection("Menu").doc(widget.productId);
//   docRef.get().then(
//   (DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//   },
//   onError: (e) => print("Error getting document: $e"),
// );

     
   
// }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Product data"),
//           actions: [
//             badges.Badge(
//             badgeContent: Text('${context.watch<Cart>().count}',),
//             child: Icon(Icons.shopping_cart),
//             onTap:cartIconPress
//             ),
//             // IconButton(onPressed:cartIconPress, icon:const Icon(Icons.shopping_cart))
//           ],
//         ),
//         body: Container(
//           child: Column(
//             children: [
//               Image.asset('Assets/${data['Name']}.jpg',width: 70.0,height: 70.0,),
//                Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(icon:Icon(Icons.remove_circle_outline),onPressed: ()=>{minusItem(documentId)},),
//                   SizedBox(width: 10),
//                   Text("0"),
//                   SizedBox(width: 10),
//                   IconButton(icon:Icon(Icons.add_circle_outline),onPressed: ()=>{addItem(documentId)},),
//                 ],
//                  ElevatedButton(onPressed: () => context.read<Cart>().add(), child:const Text("Add to cart")),
//                     )
              
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void cartIconPress(){
//    Navigator.push(context, MaterialPageRoute(
//        builder: (context) => Checkout(itemVal)));
// }
// }

