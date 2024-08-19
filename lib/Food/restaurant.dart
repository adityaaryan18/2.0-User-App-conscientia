import 'package:app/Food/cart.dart';
import 'package:app/Food/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//ignore: must_be_immutable
class Restaurant extends StatefulWidget {
  final List data;
  Map<dynamic, dynamic> newData = {};
  Restaurant({Key? key, required this.data}) : super(key: key) {
    newData = data.fold({}, (previousValue, element) {
      previousValue.addAll(element);
      return previousValue;
    });
  }

  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  Map<dynamic, dynamic>? selectedItem;
  int quantity = 1;
  bool itemAdded = false;

  Widget getConditionalIcon(bool condition) {
    return Row(
      children: [
        Card(
          child: Icon(
            Icons.circle_sharp,
            color: condition ? Colors.green : Colors.red,
            size: 10,
          ),
        ),
        SizedBox(width: 2),
        Container(width: 1, height: 10, color: Colors.white),
        SizedBox(width: 4),
        Text(
          condition ? "VEG" : "NON-VEG",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Inter",
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  void _openBottomSheet(Map<dynamic, dynamic> item) {
    setState(() {
      selectedItem = item;
      quantity = 1;
      itemAdded = false;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            int totalPrice = selectedItem!['Price'] * quantity;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                children: [
                  Text(
                    selectedItem!['Name'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Price: ₹ ${selectedItem!['Price']}",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) quantity--;
                          });
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Total: ₹ $totalPrice",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  itemAdded
                      ? Column(
                    children: [
                      Text(
                        "Your item has been added to the cart.",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (_) => CartPage(),
                          ));
                        },
                        child: Text("Go to Cart"),
                      ),
                    ],
                  )
                      : ElevatedButton(
                    onPressed: () {
                      final cartProvider =
                      Provider.of<CartProvider>(context,
                          listen: false);
                      cartProvider.addItem(CartItem(
                        isVeg: selectedItem!['isVeg'],
                        name: selectedItem!['Name'],
                        price: selectedItem!['Price'],
                        image: selectedItem!['photo'],
                        quantity: quantity,
                      ));
                      setState(() {
                        itemAdded = true;
                      });
                    },
                    child: Text("Add to Cart"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 10,
                  margin: EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      Container(
                        height: 220,
                        width: 400,
                        child: Image.asset(
                          widget.newData['image'],
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Positioned(
                        top: 130,
                        child: Container(
                          width: 385,
                          height: 70,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 17),
                                child: Text(
                                  widget.newData['name'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontFamily: "Inter",
                                  ),
                                ),
                              ),
                              Text(
                                widget.newData['variety'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.6),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 90,
                        left: 160,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(widget.newData['Logo']),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(color: Colors.grey, height: 1),
            ),
            Text(
              "FOOD ITEMS",
              style: GoogleFonts.rubik(
                color: Colors.white,
                fontSize: 16,
                letterSpacing: 2,
              ),
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: widget.newData['Menu'].map<Widget>((info) {
                  var mappedInfo = info as Map;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => _openBottomSheet(mappedInfo),
                      child: Card(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(),
                        elevation: 5,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 8, top: 1, left: 1),
                              child: Container(
                                height: 130,
                                width: 220,
                                color: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3, left: 4),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      getConditionalIcon(
                                          mappedInfo['isVeg']),
                                      Text(
                                        mappedInfo['Name'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 23,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      Text(
                                        "₹ ${mappedInfo['Price']}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      Text(
                                        mappedInfo['desciption'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontFamily: "Inter",
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 15,
                              clipBehavior: Clip.antiAlias,
                              color: Colors.black,
                              child: Container(
                                height: 130,
                                width: 130,
                                child: Stack(
                                  children: [
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      height: 100,
                                      width: 140,
                                      child: Image.asset(
                                        mappedInfo['photo'],
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}