import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final  user;
  
  const HomePage(this.user);
  
  
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
    // final db = FirebaseFirestore.instance;
    // await Firestore.instance.collection("collection").getDocuments();
    // final docRef = db.collection("Menu").get();
    // QuerySnapshot querySnapshot = await docRef.get();
    // final _docData = querySnapshot.docs.map((doc) => doc.data()).toList();
    // final QuerySnapshot snapshot =  FirebaseFirestore.instance.collection("Menu").get();
    // for (var document in snapshot.documents) {
    //   var data = document.data;
    //   print(data);
    // }
    // final _docData = docRef.docs.map((doc) => doc.data()).toList();
    // final allData = docRef.getDocuments();
//         docRef.get().then(
//     (DocumentSnapshot doc) {
//      data = doc.data() as Map<String, dynamic>;
//    print(data);
//   },
//   onError: (e) => print("Error getting document: $e"),
// );

  //   QuerySnapshot querySnapshot =  FirebaseFirestore.instance.collection("collection").get();
    
  // for (int i = 0; i < querySnapshot.documents.length; i++) {
  //   var a = querySnapshot.documents[i];
  //   print(a.documentID);
  // }

    // print(docRef);
  }


  // final _auth = FirebaseAuth.instance;
  // final foodCollection = firestore.collection("food1");
  // final foodDocument2 = db.collection("food1").doc("FSZlmK0OyfPnNLfRypN5");
    // final Stream<QuerySnapshot> _usersStream =FirebaseFirestore.instance.collection('Menu').snapshots();
     final Stream<QuerySnapshot> _MenuStream = FirebaseFirestore.instance.collection('Menu').snapshots();
 var finalMap = Map();
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
            onTap:cartIconPress
            ),
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
            var quantity = {documentId:0};
            finalMap = {...finalMap, ...quantity};
            example = finalMap[documentId];
            // quantity.update(doumentId , (value) => value + 100);
            return Container(
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
                      Text(example.toString()),
                      SizedBox(width: 10),
                      IconButton(icon:Icon(Icons.add_circle_outline),onPressed: ()=>{addItem(documentId)},),
                    ],
                  )
                  ,
                 ElevatedButton(onPressed: ()=>{addToCart()}, child:const Text("Add to cart")),
                  

                ],
              ),
           
            );
            }).toList(),
            );
            
            }),
      ),
    ));

 }
 void minusItem(id){
  if(finalMap[id]>0){
    finalMap[id]-=1;

  }
     
 }
  void addItem(id){
    if(finalMap[id]<5){
      finalMap[id]+=1;
    }
   print(finalMap[id]);
 }
 void addToCart(){
  var newCartVal=0;
   for(var v in finalMap.values){
     if(v>0){
         newCartVal++;      
     }
   }
   if(newCartVal>cartval || newCartVal<cartval){
    setState(() {
      cartval = newCartVal;
    });
   }
   print(finalMap);
 }
//  void setValues(id){
//   finalMap[id]+=1;
//  }
void cartIconPress(){
  Navigator.pushNamed(context, '/userLogin');
}
}