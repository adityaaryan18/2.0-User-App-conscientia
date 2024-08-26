import 'dart:convert';

import 'package:app/Merch/confirmation_payment.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final String name;
  final String price;
  final String image;
  final String description;

  ProductDetailScreen({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  double get totalPrice => double.parse(widget.price) * quantity;
  String selectedSize = 'M'; // Default size

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void initPay(double amount, String receipt, Map userDatabaseId,
      List<Map> items) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://conscientia2k24-dev-api.vercel.app/api/payments/initPayment"),
          body: json.encode({
            "amount": amount, //amount to be paid (including taxes),
            "receipt":
                receipt, // a receipt for payment usually generated with date,
            "user": userDatabaseId, //whole user object,
            "items": items,
            'category': 'merch' //array of items
          }));

      if (response.statusCode == 200) {
        debugPrint(response.body);
      } else {
        debugPrint("status code is different");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;
    final userDatabaseId = user?.id;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Your logo image
                    height: size.height * 0.3,
                    color: Colors.white.withOpacity(0.2),
                    fit: BoxFit.fitWidth,
                  ),
                  Container(
                    height: size.height * 0.3,
                    child: PageView(
                      controller: _pageController,
                      children: [
                        Image.asset(
                          'assets/images/tshirt.png',
                          fit: BoxFit.contain,
                        ),
                        Image.asset(
                          'assets/images/tshirt.png',
                          fit: BoxFit.contain,
                        ),
                        Image.asset(
                          'assets/images/tshirt.png',
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3, // Number of pages
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          height: 8.0,
                          width: _currentPage == index ? 16.0 : 8.0,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? const Color.fromARGB(255, 188, 232, 90)
                                    .withOpacity(0.8)
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              widget.name,
              style: GoogleFonts.teko(
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.065,
                color: Colors.white,
              ),
            ),
            Text(
              '\$${totalPrice.toStringAsFixed(2)}',
              style: GoogleFonts.teko(
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.05,
                color: const Color.fromARGB(255, 188, 232, 90),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              widget.description,
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 0.04,
              ),
            ),

            SizedBox(height: size.height * 0.02),
            // Size Selection
            Text(
              'Select Size:',
              style: GoogleFonts.rubik(
                fontSize: size.width * 0.05,
                color: Colors.white,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Row(
              children: ['S', 'M', 'L', 'XL', 'XXL'].map((size) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: ChoiceChip(
                    label: Text(size),
                    selected: selectedSize == size,
                    onSelected: (selected) {
                      setState(() {
                        selectedSize = size;
                      });
                    },
                    selectedColor: const Color.fromARGB(255, 188, 232, 90),
                    backgroundColor: Colors.grey[800],
                    labelStyle:
                        GoogleFonts.rubik(color: Colors.white, fontSize: 16),
                  ),
                );
              }).toList(),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      },
                    ),
                    Text(
                      '$quantity',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.05,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmationPage(
                          quantity: quantity,
                          name: widget.name,
                          size: selectedSize,
                          totalPrice: totalPrice,
                          imageUrl: widget.image,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 188, 232, 90)
                        .withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1,
                      vertical: size.height * 0.015,
                    ),
                  ),
                  child: Text(
                    'Buy Now',
                    style: GoogleFonts.rubik(
                      fontSize: size.width * 0.045,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
