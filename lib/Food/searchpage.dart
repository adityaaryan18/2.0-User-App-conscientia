import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchpage extends StatefulWidget {
  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  late var myFocusNode = FocusNode();
  final search = TextEditingController();

  var arrDishes = [
    {"image": "assets/images/biryani.png", "name": "Biryani"},
    {"image": "assets/images/cake.png", "name": "Cake"},
    {"image": "assets/images/chicken.png", "name": "Chicken"},
    {"image": "assets/images/pizza.png", "name": "Pizza"},
    {"image": "assets/images/burger.png", "name": "Burger"},
    {"image": "assets/images/dosa.png", "name": "Dosa"},
    {"image": "assets/images/rice.png", "name": "Rice"},
    {"image": "assets/images/Shawrma.png", "name": "Shawarma"},
    {"image": "assets/images/biryani.png", "name": "Biryani"},
    {"image": "assets/images/cake.png", "name": "Cake"},
    {"image": "assets/images/chicken.png", "name": "Chicken"},
    {"image": "assets/images/pizza.png", "name": "Pizza"},
    {"image": "assets/images/burger.png", "name": "Burger"},
    {"image": "assets/images/dosa.png", "name": "Dosa"},
    {"image": "assets/images/rice.png", "name": "Rice"},
    {"image": "assets/images/Shawrma.png", "name": "Shawarma"},
    {"image": "assets/images/biryani.png", "name": "Biryani"},
    {"image": "assets/images/cake.png", "name": "Cake"},
    {"image": "assets/images/chicken.png", "name": "Chicken"},
    {"image": "assets/images/pizza.png", "name": "Pizza"},
    {"image": "assets/images/burger.png", "name": "Burger"},
    {"image": "assets/images/dosa.png", "name": "Dosa"},
    {"image": "assets/images/rice.png", "name": "Rice"},
    {"image": "assets/images/Shawrma.png", "name": "Shawarma"},
  ];

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
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
                          context: context, delegate: CustomSearchDelegate());
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
                              padding: const EdgeInsets.symmetric(horizontal: 18),
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
                    children: arrDishes.map((toElement) {
                      return Container(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage(toElement['image'].toString()),
                            ),
                            Text(
                              toElement['name'].toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: "Inter"),
                            )
                          ],
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

  List<String> FoodItems = [
    'Pizza',
    'Dominos',
    'Burger',
    'Momos',
    'Ice Cream',
    'Wow Momos',
    'Burger King',
    'Coke',
    'Garlic Bread',
    'Chicken Wings',
    'KFC',
    'Rice',
    'Fries',
    'Dosa',
    'Shawrma'
  ];

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
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchItems = [];
    for (var item in FoodItems) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchItems.add(item);
      }
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        var result = matchItems[index];
        return ListTile(
          tileColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white),
          title: Text(result),
        );
      },
      itemCount: matchItems.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchItems = [];
    for (var item in FoodItems) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
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
            return Card(
              elevation: 0,
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(result),
                titleTextStyle: GoogleFonts.rubik(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            );
          },
          itemCount: matchItems.length,
        ),
      ),
    );
  }
}