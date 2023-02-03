
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../Providers/Cart.dart';
import 'Checkout.dart';

class Product extends StatefulWidget {
  final String ?productId;
  final String ?name;
  final String ?price;
  

 const Product({super.key,this.productId,this.price,this.name});
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
int _productCount = 1;

     
   
// }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Product data"),
          actions: [
            badges.Badge(
            badgeContent:  Text(context.watch<Cart>().cartVal.toString()),
            onTap:null,
            child: IconButton(icon:const Icon(Icons.shopping_cart),onPressed:cartIconPress),
            
            ),
            // IconButton(onPressed:cartIconPress, icon:const Icon(Icons.shopping_cart))
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Image.asset('Assets/${widget.name}.jpg',width: 70.0,height: 70.0,),
              Text(widget.name.toString()),
              Text(widget.price.toString()),
               Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon:Icon(Icons.remove_circle_outline),onPressed: ()=>{minusItem()},),
                  SizedBox(width: 10),
                  Text(_productCount.toString()),
                  SizedBox(width: 10),
                  IconButton(icon:Icon(Icons.add_circle_outline),onPressed: ()=>{addItem()},),
                ],
               ),
                 ElevatedButton(onPressed: () => context.read<Cart>().addToCart(widget.productId,_productCount,widget.price,widget.name), 
                 child:const Text("Add to cart"),
                    
                    ),
                    
                    
              
            ],
          ),
        ),
      ),
    );
  }

  void cartIconPress(){
   Navigator.push(context, MaterialPageRoute(
       builder: (context) => const Checkout()));
}

  void minusItem() {
    if(_productCount>1){
      setState(() {
        _productCount--;
      });
      

    }
    
    
  }
  

  void addItem() {
    if(_productCount<5){
      setState(() {
        _productCount++;
      });

    }
   
    
  }
}

