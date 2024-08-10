import 'package:app/Events/grid_view_builder.dart';
import 'package:app/Events/listview_builder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsWorkshopsHomepage extends StatefulWidget {
  const EventsWorkshopsHomepage({super.key});

  @override
  State<EventsWorkshopsHomepage> createState() => _EventsWorkshopsHomepageState();
}

class _EventsWorkshopsHomepageState extends State<EventsWorkshopsHomepage> {
  String result = '';
  int choice = 0;
  String days = "ALL";
  String eventId = "1", eventDay = "3 Oct 2024";
  String eventName = 'Night Sky Hunt';
  String type = 'Online';

  static const border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  );

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
            textAlign: TextAlign.justify,
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.text,
            onSubmitted: (value) {
              setState(() {
                result = value;
              });
            },
            decoration: InputDecoration(
              hintStyle: GoogleFonts.rubik(color: Color(0xff6b6e6f)),
              iconColor: Color(0xff6b6e6f),
              hintText: 'Search an event',
              contentPadding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 0),
              enabledBorder: border,
              focusedBorder: border,
              prefixIcon: Padding(
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
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Chip(
          backgroundColor: choice == value ? Color.fromARGB(255, 206, 44, 44) : Colors.black,
          side: BorderSide(
            color: choice == value ? Color.fromARGB(255, 206, 44, 44) : Colors.white24,
          ),
          label: Text(label),
          labelStyle: const TextStyle(color: Colors.white, fontSize: 11, fontFamily: "Nasa"),
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
        color: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: PopupMenuButton<String>(
          icon: Row(
            children: [
              Icon(Icons.filter_list, color: Colors.white),
              SizedBox(width: 10),
              Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
          color: Colors.black54,
          onSelected: (value) {
            setState(() {
              if (['ALL', 'Day 1', 'Day 2', 'Day 3'].contains(value)) {
                days = value;
              } else if (['All Types', 'Robotics', 'Online', 'Gaming'].contains(value)) {
                type = value;
              }
            });
          },
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              enabled: false,
              child: Text(
                'Event Occurrence:',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            ...['ALL', 'Day 1', 'Day 2', 'Day 3'].map((day) {
              return PopupMenuItem<String>(
                value: day,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      day,
                      style: GoogleFonts.rubik(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: days == day ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (days == day) Icon(Icons.check, color: Colors.white),
                  ],
                ),
              );
            }).toList(),
            PopupMenuDivider(),
            PopupMenuItem<String>(
              enabled: false,
              child: Text(
                'Event Type:',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            ...['All Types', 'Robotics', 'Online', 'Gaming'].map((type) {
              return PopupMenuItem<String>(
                value: type,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type,
                      style: GoogleFonts.rubik(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: this.type == type ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (this.type == type) Icon(Icons.check, color: Colors.white),
                  ],
                ),
              );
            }).toList(),
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

  Widget _buildContent() {
    if (result.isNotEmpty && !eventName.toLowerCase().contains(result.toLowerCase())) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 180),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "404 :",
                  style: TextStyle(
                    shadows: [Shadow(color: Colors.white, blurRadius: 25, offset: Offset(0, 0))],
                    fontFamily: "Ethnocentric",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  " No ${choice == 0 ? 'Events' : 'Workshops'} Found",
                  style: TextStyle(
                    shadows: [Shadow(color: Colors.white, blurRadius: 25, offset: Offset(0, 0))],
                    fontFamily: "Ethnocentric",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    final isDayMatch = (String targetDay) => days == 'ALL' || eventDay == targetDay;

    if (choice == 0) {
      if (isDayMatch("3 Oct 2024")) return const GridViewEventsBuilder();
    } else if (choice == 1) {
      if (isDayMatch("3 Oct 2024")) return const ListViewWorkshopBuilder();
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            _buildTitle(),
            _buildSearchBar(),
            SizedBox(height: 10),
            _buildChoiceChips(),
            SizedBox(height: 10),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }
}