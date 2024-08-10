import 'package:app/Food/payment_succesful.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'cart_provider.dart';
class CartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'CART',
          style: TextStyle(
              color: Colors.red, fontSize: 25, fontFamily: "Ethnocentric"),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.items.isEmpty) {
            return _buildEmptyCart(context);
          } else {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: cartProvider.items.map((item) {
                        return _buildCartItem(context, item);
                      }).toList(),
                    ),
                  ),
                ),
                _buildSummary(cartProvider,context),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty cart.png',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'LOOKS LIKE YOU HAVEN\'T ADDED ANYTHING TO YOUR CART YET.',
            style: TextStyle(
                color: Colors.white70, fontSize: 16, fontFamily: "Inter"),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'ORDER SOMETHING',
                  style: TextStyle(
                      fontFamily: "Inter", color: Colors.white, fontSize: 16),
                ),
                SizedBox(width: 8.0),
                Icon(Icons.arrow_forward, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getConditionalIcon(bool condition) {
    if (condition) {
      return Row(
        children: [
          Card(child: Icon(Icons.circle_sharp, color: Colors.green, size: 10)),
          SizedBox(width: 2,),
          Container(width: 1,height: 10,color: Colors.white,),
          SizedBox(width: 4,),
          Text("PURE VEG",style: TextStyle(color: Colors.white,fontFamily: "Inter",fontSize: 12),)
        ],
      );
    } else {
      return Row(
        children: [
          Card(child: Icon(Icons.circle_sharp, color: Colors.red, size: 10)),
          SizedBox(width: 2,),
          Container(width: 1,height: 10,color: Colors.white,),
          SizedBox(width: 4,),
          Text("NON-VEG",style: TextStyle(color: Colors.white,fontFamily: "Inter",fontSize: 12),)
        ],
      );
    }
  }

  Widget _buildCartItem(BuildContext context, CartItem item) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Card(
      elevation: 10,
      shadowColor: Colors.red,
      color: Colors.black,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 15,left: 10),
        child: Row(
          children: [
            Container(
              width: 210,
              height: 140,
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getConditionalIcon(item.isVeg),
                  Text(
                    item.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Each: ₹${item.price}',
                    style: TextStyle(color: Colors.white70,fontFamily: "Inter",fontSize: 15),
                  ),
                  Text(
                    'No. of sub-items: ${item.quantity}',
                    style: TextStyle(color: Colors.white70,fontFamily: "Inter",fontSize: 15),
                  ),
                  Text(
                    'Subtotal: ₹${item.subtotal}',
                    style: TextStyle(color: Colors.white70,fontFamily: "Inter",fontSize: 15),
                  ),
                ],
              ),
            ),
           SizedBox(width: 25,),
           Container(
             width: 120,
             height: 140,
             child: Stack(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        clipBehavior: Clip.antiAlias,
                        width: 120,
                          height: 120,
                          child: Image.asset(item.image,fit: BoxFit.cover,)),
                      Positioned(
                        right: 5,
                        top: 2,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 15,
                          child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.white,size: 15,),
                            onPressed: () => cartProvider.removeItem(item),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 106,
                    left: 20,
                    child: Container(
                      width: 85,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: Icon(Icons.remove, color: Colors.white,size: 18,),
                            onTap: (){
                              return cartProvider.decrementQuantity(item);
                            },
                          ),
                          Text(
                            item.quantity.toString(),
                            style: TextStyle(color: Colors.white,fontSize: 16),
                          ),
                          InkWell(
                            child: Icon(Icons.add, color: Colors.white,size: 18,),
                            onTap: (){
                              return cartProvider.incrementQuantity(item);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
           ),
          ],
        ),
      ),
    );
  }
  Widget _buildSummary(CartProvider cartProvider,BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0,left: 8,right:8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'NO. OF ITEMS:',
                  style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: "Inter"),
                ),
                Text(
                  cartProvider.totalItems.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: "Inter"),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TOTAL:',
                  style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: "Inter"),
                ),
                Text(
                  '₹${cartProvider.totalPrice}',
                  style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: "Inter"),
                ),
              ],
            ),
            SizedBox(height: 25.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              ),
              onPressed: () {
                Navigator.push(context , MaterialPageRoute(builder: (_)=>PaymentSuccesful()));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: "Inter"),
                  ),
                  SizedBox(width: 8.0),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}