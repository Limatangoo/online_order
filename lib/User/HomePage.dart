import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:online_order/User/UserLogin.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

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
            badgeContent: Text(cartval.toString()),
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
               mainAxisSpacing: 50,
               crossAxisCount: 2,
               children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            var documentId = document.id;
            // var quantity = {documentId:0};
            // itemVal = {...itemVal, ...quantity};
            
            // quantity.update(doumentId , (value) => value + 100);
            return GestureDetector(
              //  onTap:()=>{navigateToProduct(documentId)},
              child: Container(
                child: Column(
                  children: <Widget>[
                    Image.asset('Assets/${data['Name']}.jpg',width: 70.0,height: 70.0,),
                    Text(data['Name']),
                    Text(data['Price'].toString()),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(icon:Icon(Icons.remove_circle_outline),onPressed: ()=>{minusItem(documentId)},),
                        SizedBox(width: 10),
                        Text("0"),
                        SizedBox(width: 10),
                        IconButton(icon:Icon(Icons.add_circle_outline),onPressed: ()=>{addItem(documentId)},),
                      ],
                    )
                    ,
                   ElevatedButton(onPressed: ()=>{addToCart()}, child:const Text("Add to cart")),
                    
            
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
void minusItem(id){
  final db = FirebaseFirestore.instance;
  final docRef = db.collection("Menu").doc(id);

  docRef.get().then(
  (DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
      itemVal.map((val)=>{
      if(val[id]==id){
        //increment the qty;
      
        }
      });
   
  },
  onError: (e) => print("Error getting document: $e"),
);
  


     
 }
  void addItem(id){
  itemVal.map((val){
    val[id] ??= 0;
    if(val[id]<5){
      val[id]+=1;
    }
  });
   print(itemVal[id]);
 }
 void addToCart(){
  var newCartVal=0;
   for(var v in itemVal){
     if(v>0){
         newCartVal++;      
     }
   }
   if(newCartVal>cartval || newCartVal<cartval){
    setState(() {
      cartval = newCartVal;
    });
   }
   print(itemVal);
 }

// void cartIconPress(){
//    Navigator.push(context, MaterialPageRoute(
//        builder: (context) => Checkout(itemVal)));
// }
}