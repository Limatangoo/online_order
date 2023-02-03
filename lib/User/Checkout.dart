import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import '../Providers/Cart.dart';


class Checkout extends StatefulWidget {
  

  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int totalAmount=0;
  @override
  Widget build(BuildContext context) {
    
    return  context.watch<Cart>().cartVal==null?
     SafeArea(child:Scaffold(
      body: const Text("No items in the cart")
     ))
    :SafeArea(
      
      child: Scaffold(
        body: Column(
          children: [ListView.builder(
           padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
           shrinkWrap: true,
           itemCount: context.watch<Cart>().cartVal,
           itemBuilder: (context, index) {
            // if(context.watch<Cart>().items[index]["price"]!=null){
            //   for(int v=0; v < int.parse(context.watch<Cart>().cartVal); v++){
            //     totalAmount += int.parse(context.watch<Cart>().items[index]["price"]);

            //   }
             
              
            // }
            
           return Card(
             color: Colors.blueGrey.shade200,
             elevation: 5.0,
             child: Padding(
               padding: const EdgeInsets.all(4.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 mainAxisSize: MainAxisSize.max,
                 children: [
                 
                  Image.asset('Assets/${context.watch<Cart>().items[index]["name"]}.jpg',width: 80.0,height: 80.0,),
                   
                   SizedBox(
                     width: 130,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const SizedBox(
                           height: 5.0,
                         ),
                         RichText(
                           overflow: TextOverflow.ellipsis,
                           maxLines: 1,
                           text: TextSpan(
                               text: 'Name: ',
                               style: TextStyle(
                                   color: Colors.blueGrey.shade800,
                                   fontSize: 16.0),
                               children: [
                                 TextSpan(
                                     text:
                                         '${context.watch<Cart>().items[index]["name"]}\n',
                                     style: const TextStyle(
                                         fontWeight: FontWeight.bold)),
                               ]),
                         ),
                         RichText(
                           maxLines: 1,
                           text: TextSpan(
                               text: 'Qty: ',
                               style: TextStyle(
                                   color: Colors.blueGrey.shade800,
                                   fontSize: 16.0),
                               children: [
                                 TextSpan(
                                     text:
                                         '${context.watch<Cart>().items[index]["productCount"]}\n',
                                     style: const TextStyle(
                                         fontWeight: FontWeight.bold)),
                               ]),
                         ),
                         RichText(
                           maxLines: 1,
                           text: TextSpan(
                               text: 'Price: ' r"LKR",
                               style: TextStyle(
                                   color: Colors.blueGrey.shade800,
                                   fontSize: 16.0),
                               children: [
                                 TextSpan(
                                     text:
                                         '${context.watch<Cart>().items[index]["price"]}\n',
                                     style: const TextStyle(
                                         fontWeight: FontWeight.bold)),
                               ]),
                         ),
                       ],
                     ),
                   ),
                   ElevatedButton(
                       style: ElevatedButton.styleFrom(
                           primary: Colors.blueGrey.shade900),
                       onPressed: null,
                       child: const Text('Remove')),
                       
                 ],
               ),
             ),
           );
           }), 
           Flexible(flex: 1,child: Container(),),
           
           Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
           height: 35,
           color: Colors.blueGrey.shade200,
           width: double.infinity,
           child: Text(totalAmount.toString(),style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.w300),),
    
           ),
            ElevatedButton(onPressed:() => context.read<Cart>().purchase(), child: Text("Pay Now"))
    ]
        ),
      ),
    );
    
   
  }
}