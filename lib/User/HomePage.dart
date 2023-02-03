import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:online_order/User/UserLogin.dart';
import 'package:online_order/main.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../Providers/Cart.dart';
import 'Checkout.dart';
import 'Product.dart';

class HomePage extends StatefulWidget {
const HomePage({Key? key}) : super(key: key);
  
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 int example = 0;
 int cartval=0;
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  // final _auth = FirebaseAuth.instance;
  // final foodCollection = firestore.collection("food1");
  // final foodDocument2 = db.collection("food1").doc("FSZlmK0OyfPnNLfRypN5");
    // final Stream<QuerySnapshot> _usersStream =FirebaseFirestore.instance.collection('Menu').snapshots();
     final Stream<QuerySnapshot> _MenuStream = FirebaseFirestore.instance.collection('Menu').snapshots();
 var itemVal = [];
  @override
  Widget build(BuildContext context) {

    return(MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title: const Text("Home page"),
          actions: [
            badges.Badge(
            badgeContent: Text(context.watch<Cart>().cartVal.toString()),
            child: Icon(Icons.shopping_cart),
            // onTap:cartIconPress
            ),
            IconButton(icon:Icon(Icons.logout),onPressed: ()=>{_signOut()},),
            // IconButton(onPressed:cartIconPress, icon:const Icon(Icons.shopping_cart))
          ],

        ),
        body:   StreamBuilder<QuerySnapshot>(
            stream: _MenuStream,
            builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
            return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
            }
            return GridView.count(
               crossAxisSpacing: 10,
               mainAxisSpacing: 20,
               crossAxisCount: 2,
               children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            var documentId = document.id;
           
            return GestureDetector(
              onTap:()=>{ Navigator.push(context, MaterialPageRoute(
              builder: (context) =>Product(productId:documentId,price:data['Price'].toString(),name:data['Name'])))},
              child: Container(
                child: Column(
                  children: <Widget>[
                    Image.asset('Assets/${data['Name']}.jpg',width: 70.0,height: 70.0,),
                    Text(data['Name']),
                    Text(data['Price'].toString()),
                    
                    
                  
                    
            
                  ],
                ),
                       
              ),
            );
            }).toList(),
            );
            
            }),
      ),
    ));

 }
//  navigateToProduct(documentId){
//    Navigator.push(context, MaterialPageRoute(
//        builder: (context) => Product(documentId)));
   
//  }
Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(
       builder: (context) => const UserLogin()));
}



// void cartIconPress(){
//    Navigator.push(context, MaterialPageRoute(
//        builder: (context) => Checkout(itemVal)));
// }
}