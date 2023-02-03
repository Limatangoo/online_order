import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier, DiagnosticableTreeMixin { 
     List items = [];
     int ? cartVal;
      

void addToCart (productId,productCount,price,name){


  if(items.isEmpty){
    items = [{
  "name":name,
  "productId":productId,
  "productCount":productCount,
  "price":price
  }];
  }
  else{
    bool found = false;
   for(var v in items){
    if(v["productId"]==productId){
      v["productCount"]+= productCount;
      found = true;
     
    }
   }
   if(found==false){
      final Map _newItems = {
      "name":name,
      "productId":productId,
      "productCount":productCount,
      "price":price
      };

      items = [...items,_newItems];

   }

    
  

    

  

  }


// if(user?.uid != null){
//   await db.collection("Orders").doc(user?.uid).set(data)
// }
print(items);
cartVal = items.length;
notifyListeners();

}

void purchase(){
  final db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  
  try{
   if(user != null){
  String userID = user.uid;
  Map<String,dynamic> data = {"uid":userID,"items":items,"status":"paid"};
  db.collection("Orders").add(data);
  items.clear();
  cartVal = items.length;
 
  notifyListeners();

  }
 

  }
  catch(e){
    print(e);
  }

}

}