import 'dart:async';
import 'package:app/Food/cart.dart';
import 'package:app/Food/orders_history.dart';
import 'package:app/Food/orders_status.dart';
import 'package:app/Food/restaurant.dart';
import 'package:app/Food/restaurant_data.dart';
import 'package:app/Food/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shimmer/shimmer.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late var myFocusNode = FocusNode();
  late AnimationController _controller;
  int _currentPage = 0;
  late PageController pageController;
  Timer _timer = Timer(Duration.zero, () {});

  List foodStoreData = [];

  IO.Socket? socket;

  void initializeSocket([String? uid]) {
    socket = IO.io(
        'https://socketserver.conscientia.co.in/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket?.connect();

    socket?.onConnect((_) {

      if (uid != null) {
        socket?.emit('join', uid);
      }
    });

    socket?.on('foodStoreData', (data) {

      setState(() {
        foodStoreData = List.from(data);
      });
    });

    socket?.onDisconnect((_) {
      print('Disconnected from socket');
    });

    socket?.onError((error) {
      print('Socket error: $error');
    });
  }

  @override
  void initState() {
    super.initState();
    initializeSocket();
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..repeat();
    myFocusNode = FocusNode();
    pageController = PageController();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    int displayDuration = 1; // Initial display duration for the first image

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
        displayDuration = 0; // Reset display duration for the first image
      }

      pageController.animateToPage(
        _currentPage,
        duration: Duration(seconds: 2),
        curve: Curves.linear,
      );

      // Update display duration for subsequent images
      displayDuration = 3;

      timer.cancel();
      _timer = Timer(Duration(seconds: displayDuration), () {
        _startAutoPlay();
      });
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _controller.dispose();
    _timer.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        //cart icon
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 244, 203, 54),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartPage()));
          },
          child: Icon(
            Icons.shopping_cart,
            color: Colors.white,
            size: 35,
            weight: 45,
          ),
        ),
        //backgroundColor: Color(0xFF252525),
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/foody.jpg', // Ensure this path matches your actual image asset path
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            ListView(
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
                  child: Center(
                    child: Text(
                      "FOOD ORDERS",
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: "Nasa",
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Searchpage(
                                  stores: foodStoreData,
                                )));
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Container(
                            height: 43,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.black),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 2,
                                      offset: Offset(.2, .2),
                                      blurRadius: 2)
                                ]),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 2,
                                ),
                                Container(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: Icon(
                                    Icons.search,
                                    color: Color.fromARGB(255, 244, 203, 54),
                                  ),
                                )),
                                Container(
                                  color: Colors.white54,
                                  width: 1,
                                  height: 25,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Search your food ",
                                    style:
                                        GoogleFonts.rubik(color: Colors.grey))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => OrdersPage()));
                        },
                        child: Container(
                          width: double.infinity,
                          child: Card(
                            color: const Color.fromARGB(255, 255, 194, 13),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Order Status",
                                  style: GoogleFonts.rubik(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => OrdersHistory()));
                        },
                        child: Container(
                          width: double.infinity,
                          child: Card(
                            color: const Color.fromARGB(255, 255, 194, 13),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Order History",
                                  style: GoogleFonts.rubik(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Card(
                    color: Colors.transparent,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    elevation: 4,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          child: Card(
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Divider(),
                // "WHAT ARE YOU LOOKING FOR?" section with shimmer loading
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "WHAT ARE YOU LOOKING FOR?",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 120,
                  child: foodStoreData.isEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5, // Number of shimmer placeholders
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[800]!,
                              highlightColor: Colors.grey[500]!,
                              child: Container(
                                height: 80,
                                width: 85,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            );
                          },
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: foodStoreData
                              .expand((store) => store['foodItems'])
                              .where((foodItem) => foodItem['seller']
                                  ['open']) // Filter sellers who are open
                              .map((foodItem) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                height: 80,
                                width: 85,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => Restaurant(
                                              sellerUid: foodItem['seller']
                                                  ['uid'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(
                                          foodItem['image'].toString(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    Card(
                                      color: Color.fromARGB(255, 39, 39, 39),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: FittedBox(
                                          child: Text(
                                            foodItem['name']
                                                .toString()
                                                .toUpperCase(),
                                            style: GoogleFonts.rubik(
                                              fontSize: 13,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                ),

                Divider(),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "PARTNER RESTAURANTS",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: foodStoreData.length * 250,
                  child: foodStoreData.isEmpty
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 5, // Number of shimmer placeholders
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[800]!,
                              highlightColor: Colors.grey[500]!,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: foodStoreData.length,
                          itemBuilder: (context, index) {
                            var store = foodStoreData[index];

                            return InkWell(
                              onTap: () {
                                if (store['open'] == true) {
                                  // Pass the necessary values to the Restaurant page
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Restaurant(
                                        sellerUid: store['uid'],
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Stack(
                                children: [
                                  Card(
                                    elevation: 4,
                                    margin: EdgeInsets.all(10),
                                    clipBehavior: Clip.antiAlias,
                                    color: Color.fromARGB(75, 255, 154, 13),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 150,
                                          width: double.infinity,
                                          child: Image(
                                            image: NetworkImage(
                                                store['banner'].toString()),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            store['storeName'].toString(),
                                            style: GoogleFonts.rubik(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            '${store['foodItems'].length} Products | '
                                            '${store['foodItems'].where((item) => item['category'] == 'veg').length} Veg + '
                                            '${store['foodItems'].where((item) => item['category'] == 'nonveg').length} Non-Veg',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontFamily: "Inter",
                                              fontSize: 13,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (!store['open'])
                                    Positioned.fill(
                                      child: Card(
                                        color: Color.fromARGB(160, 39, 39, 39),
                                        child: Center(
                                          child: Text(
                                            'CLOSED',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
