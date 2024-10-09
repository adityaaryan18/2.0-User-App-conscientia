import 'package:app/Food/restaurant.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchpage extends StatefulWidget {
  final List stores;

  Searchpage({required this.stores});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  late var myFocusNode = FocusNode();
  final search = TextEditingController();
  List availableFoodItems = [];

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    filterAvailableFoodItems();
  }

  void filterAvailableFoodItems() {
    // Collecting available food items
    availableFoodItems = widget.stores.expand((store) {
      return store['foodItems']
          .where((foodItem) => foodItem['available'] == true);
    }).toList();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(
                            foodItems: availableFoodItems,
                          ));
                    },
                    child: Container(
                      height: 50,
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
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Text(
                                "Search your desired food item",
                                style: GoogleFonts.rubik(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    letterSpacing: 1.2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 5),
                  child: Text(
                    "TOP PICKS FOR YOU",
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        letterSpacing: 3,
                        fontSize: 15),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: availableFoodItems
                        .where((foodItem) => foodItem['seller']
                            ['open']) // Filter out closed sellers
                        .map((foodItem) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Restaurant(
                                  sellerUid: foodItem['seller']['uid']),
                            ),
                          );
                        },
                        child: Container(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    NetworkImage(foodItem['image'].toString()),
                              ),
                              Text(
                                foodItem['name'].toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontFamily: "Inter"),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
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
class CustomSearchDelegate extends SearchDelegate {
  final List foodItems;

  CustomSearchDelegate({required this.foodItems});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.dark(),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: InputBorder.none,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: const Color.fromARGB(255, 255, 194, 13),
      ),
    );
  }

  late var myFocusNode = FocusNode();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        myFocusNode.unfocus();
        close(context, null);
      },
      icon: Icon(
        Icons.arrow_circle_left_outlined,
        color: const Color.fromARGB(255, 255, 194, 13),
        size: 30,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchItems = [];
    for (var item in foodItems) {
      if (item['description']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase())) {
        matchItems.add(item['description'].toString());
      }
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        var result = matchItems[index];
        return ListTile(
          tileColor: Colors.black,
          title: Text(
            result,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
      itemCount: matchItems.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List matchItems = [];
    for (var item in foodItems) {
      if (item['description']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase())) {
        matchItems.add(item);
      }
    }
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            var result = matchItems[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          Restaurant(sellerUid: result['seller']['uid'])),
                );
              },
              child: result['seller']['open']? Card(
                elevation: 0,
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    result['description'], // Extracting description from the map
                    style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ):Container()
            );
          },
          itemCount: matchItems.length,
        ),
      ),
    );
  }
}
