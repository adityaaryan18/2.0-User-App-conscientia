import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:app/Food/Verify_details_food.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isLoading = false; // This will control the loading screen
  Future<void> _checkout(
      BuildContext context, CartProvider cartProvider) async {
    setState(() {
      _isLoading = true;
    });

    // Prepare the data to be sent in the API request
    List<Map<String, dynamic>> foodItems = cartProvider.items.map((item) {
      return {
        '_id': item.productId,
        'name': item.name,
        'itemId': item.itemId,
        'price': item.price,
        'category': item.category,
        'seller': item.seller['_id'],
        'description': item.description,
        'image': item.image,
        'available': item.available,
        'createdAt': item.createdAt,
        'updatedAt': item.updatedAt,
        '__v': item.version,
        'quantity': item.quantity,
      };
    }).toList();

    // Make API call (replace 'YOUR_API_URL' with the actual URL)
    try {
      final response = await http.post(
        Uri.parse('https://conscientia.co.in/api/foodstore/verifyCart'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'items': foodItems,
        }),
      );

      if (response.statusCode == 200) {
        // Successful API call, navigate to the next page
        setState(() {
          _isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VerifyFoodDetailsPage(
              foodItems: foodItems,
              totalPrice: cartProvider.totalPrice,
            ),
          ),
        );
      } else {
        // Error: show snackbar with message from response
        setState(() {
          _isLoading = false;
        });
        final message =
            jsonDecode(response.body)['message'] ?? 'Error occurred';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // Handle network or other errors
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/foody.jpg', // Ensure this path matches your actual image asset path
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.black.withOpacity(0.5),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'CART',
              style: TextStyle(
                  color: const Color.fromARGB(255, 244, 174, 54),
                  fontSize: 20,
                  fontFamily: "Nasa"),
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
          body: Stack(
            children: [
              Consumer<CartProvider>(
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
                        _buildSummary(cartProvider, context),
                      ],
                    );
                  }
                },
              ),
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ],
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
            'Warrior! Your Cart is empty',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: "Nasa"),
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
    return Row(
      children: [
        Card(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(Icons.circle_sharp,
              color: condition ? Colors.green : Colors.red, size: 10),
        )),
        SizedBox(width: 2),
        Container(
          width: 1,
          height: 10,
          color: Colors.white,
        ),
        SizedBox(width: 4),
        Text(
          condition ? " PURE VEG" : " NON-VEG",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Inter",
              fontSize: 12,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Card(
      color: const Color.fromARGB(255, 27, 27, 27).withOpacity(0.8),
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getConditionalIcon(item.isVeg),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0),
                    child: Text(
                      item.name,
                      style: GoogleFonts.rubik(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Each: ₹${item.price}',
                      style: TextStyle(
                          color: Colors.white70,
                          fontFamily: "Inter",
                          fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'No. of sub-items: ${item.quantity}',
                      style: TextStyle(
                          color: Colors.white70,
                          fontFamily: "Inter",
                          fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Subtotal: ₹${item.subtotal}',
                      style: TextStyle(
                          color: Colors.white70,
                          fontFamily: "Inter",
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon:
                              Icon(Icons.remove, color: Colors.white, size: 18),
                          onPressed: () => cartProvider.decrementQuantity(item),
                        ),
                        Text(
                          item.quantity.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.white, size: 18),
                          onPressed: () => cartProvider.incrementQuantity(item),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  clipBehavior: Clip.antiAlias,
                  width: 120,
                  height: 120,
                  child: Image.network(
                    item.image,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () => cartProvider.removeItem(item),
                  child: Card(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: Text(
                        "Delete",
                        style: GoogleFonts.rubik(
                            fontSize: 17, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary(CartProvider cartProvider, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 33, 33, 33).withOpacity(0.7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 8, right: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Card(
                    color: const Color.fromARGB(255, 62, 62, 62),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        'NO. OF ITEMS:  ${cartProvider.totalItems.toString()}',
                        style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Card(
                    color: const Color.fromARGB(255, 62, 62, 62),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Text(
                        'TOTAL: ₹${cartProvider.totalPrice}/-',
                        style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 17.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              ),
              onPressed: () {
                _checkout(context, cartProvider);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'CHECKOUT',
                    style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8.0),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
