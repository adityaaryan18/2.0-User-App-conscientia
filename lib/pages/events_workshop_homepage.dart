import 'dart:convert';
import 'package:app/Events/workshop_card.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app/Events/event_card.dart';
import 'package:shimmer/shimmer.dart';

class EventsWorkshopsHomepage extends StatefulWidget {
  const EventsWorkshopsHomepage({super.key});

  @override
  State<EventsWorkshopsHomepage> createState() =>
      _EventsWorkshopsHomepageState();
}

class _EventsWorkshopsHomepageState extends State<EventsWorkshopsHomepage> {
  String result = '';
  int choice = 0;
  String days = "ALL";
  String type = 'All Types';
  List<dynamic> eventsData = [];
  List<dynamic> workshopsData = [];
  List<String> eventCategories = []; // To store all unique categories
  List<dynamic> filteredEventsData =
      []; // To store filtered events based on category

  FocusNode searchFocusNode = FocusNode();

  static const border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  );

  @override
  void initState() {
    super.initState();
    _fetchData(); // Initial fetch based on default choice (Events)
  }

  void _fetchData() {
    if (choice == 0) {
      _fetchEvents();
    } else {
      _fetchWorkshops();
    }
  }


  void _onSearchTextChanged(String value) {
    setState(() {
      result = value;
      filteredEventsData = eventsData.where((event) {
        return event['eventName']
            .toLowerCase()
            .contains(result.toLowerCase());
      }).toList();
    });
  }

  @override
  void dispose() {
    searchFocusNode.dispose(); // Clean up the focus node when the widget is disposed
    super.dispose();
  }

  void _fetchEvents() async {
    const endpoint = 'https://conscientia.co.in/api/events/getAllEvents';
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'key': 'Conscientia2k24'}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        eventsData = responseData['data'];
        filteredEventsData = eventsData; // Initialize filtered list
        _extractCategories(); // Extract categories from events
      });
    } else {
      // Handle error responses here
      print(
          'Error: ${response.statusCode}, Message: ${json.decode(response.body)['msg']}');
    }
  }

  // Extract unique event categories
  void _extractCategories() {
    Set<String> categoriesSet = {};
    for (var event in eventsData) {
      List<String> categories = List<String>.from(event['eventCategory']);
      categoriesSet.addAll(categories);
    }
    setState(() {
      eventCategories = categoriesSet.toList();
    });
  }

  void _filterEventsByCategory(String selectedCategory) {
    setState(() {
      filteredEventsData = eventsData.where((event) {
        List<String> categories = List<String>.from(event['eventCategory']);
        return categories.contains(selectedCategory);
      }).toList();
    });
  }

  void _fetchWorkshops() async {
    const endpoint = 'https://conscientia.co.in/api/workshops/getAllWorkshops';
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'key': 'Conscientia2k24'}),
    );


    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        workshopsData = responseData['data'];
      });
    } else {
      // Handle error responses here
 
    }
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0, top: 10),
      child: Text(
        "EVENTS & WORKSHOPS",
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Nasa',
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

   Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 50,
        child: Card(
          elevation: 12,
          color: const Color.fromARGB(255, 37, 37, 37),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: TextField(
            focusNode: searchFocusNode,
            textAlign: TextAlign.justify,
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.text,
            onChanged: _onSearchTextChanged, // Filter as user types
            decoration: InputDecoration(
              hintStyle: GoogleFonts.rubik(color: Color(0xff6b6e6f)),
              iconColor: Color(0xff6b6e6f),
              hintText: 'Search an event',
              contentPadding: const EdgeInsets.only(
                top: 10, bottom: 10, right: 10, left: 0,
              ),
              enabledBorder: border,
              focusedBorder: border,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 0.0, right: 0),
                child: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildChoiceChip(String label, int value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          choice = value;
          _fetchData(); // Fetch the selected data
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Chip(
          backgroundColor:
              choice == value ? Color.fromARGB(255, 206, 44, 44) : Colors.black,
          side: BorderSide(
            color: choice == value
                ? Color.fromARGB(255, 206, 44, 44)
                : Colors.white24,
          ),
          label: Text(label.toUpperCase()),
          labelStyle: GoogleFonts.rubik(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
      ),
    );
  }
Widget _buildFilterPopupMenu() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Card(
      color: Color.fromARGB(255, 206, 44, 44),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: PopupMenuButton<String>(
        icon: Row(
          children: [
            Text(
              "FILTER",
              style: GoogleFonts.rubik(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            Icon(Icons.arrow_drop_down, color: Colors.white),
          ],
        ),
        color: Colors.black54,
        onSelected: (value) {
          // No need for setState here as ChoiceChip already updates state
        },
        itemBuilder: (context) => [
          const PopupMenuItem<String>(
            enabled: false,
            child: Text(
              'EVENT TYPE',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          PopupMenuItem<String>(
            enabled: false,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9, // Full screen width
              child: Wrap(
                spacing: 10, // Horizontal space between items
                runSpacing: 5, // Vertical space between rows
                children: eventCategories.map((category) {
                  return ChoiceChip(
                    label: Text(
                      category.toUpperCase(),
                      style: GoogleFonts.rubik(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: type == category
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    selected: type == category,
                    selectedColor: Colors.blue,
                    onSelected: (selected) {
                      Navigator.pop(context); // Close popup menu
                      setState(() {
                        type = category;
                      });
                      _filterEventsByCategory(category);
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildChoiceChips() {
    return SizedBox(
      height: 52,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildChoiceChip("Events", 0),
              _buildChoiceChip("Workshops", 1),
              _buildFilterPopupMenu(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    final css = event['cssDefinitions'];
    return EventCard(
      eventData: event,
      imgURL: event['nameCard'],
      titleColor1: Color(int.parse('0xff${css['titleColour1'].substring(1)}')),
      titleColor2: Color(int.parse('0xff${css['titleColour2'].substring(1)}')),
    );
  }

  Widget _buildWorkshopCard(Map<String, dynamic> event) {
    final css = event['cssDefinitions'];
    return WorkshopCard(
      eventData: event,
      imgURL: event['nameCard'],
      titleColor1: Color(int.parse('0xff${css['titleColour1'].substring(1)}')),
      titleColor2: Color(int.parse('0xff${css['titleColour2'].substring(1)}')),
    );
  }

  Widget _buildShimmerLoader() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.95,
        mainAxisSpacing: 5,
        crossAxisSpacing: 0,
      ),
      itemCount: 6, // Number of shimmer cards to display
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[800]!,
          highlightColor: Colors.grey[600]!,
          child: Card(
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 120.0,
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    List<dynamic> data = choice == 0 ? filteredEventsData : workshopsData;

    if (data.isEmpty) {
      return _buildShimmerLoader();
    }

    if (result.isNotEmpty) {
      final filteredData = data.where((event) =>
          event['eventName'].toLowerCase().contains(result.toLowerCase()));
      if (filteredData.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 180),
          child: Column(
            children: [
              Text(
                "The event/workshop you are looking for could not be found.",
                style: TextStyle(
                    fontFamily: "Nasa",
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }
    }

    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        mainAxisSpacing: 5,
        crossAxisSpacing: 0,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        if (choice == 0) {
          return _buildEventCard(data[index]);
        } else {
          return _buildWorkshopCard(data[index]);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 12, 12, 12),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 12, 12, 12),
        centerTitle: true,
        elevation: 0,
        title: _buildTitle(),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          const SizedBox(height: 10),
          _buildChoiceChips(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }
}
