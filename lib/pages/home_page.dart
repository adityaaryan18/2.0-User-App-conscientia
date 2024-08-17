import 'package:app/Food/home_page.dart';
import 'package:app/pages/events_workshop_homepage.dart';
import 'package:app/pages/dashboard_page.dart';

import 'package:app/pages/leaderboard_page.dart';
import 'package:app/pages/notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DashboardPage(),
    EventsWorkshopsHomepage(),
    MyHomePage(),
    LeaderboardPage(),
    NotificationsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.black.withOpacity(0.6),
        child: SalomonBottomBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            SalomonBottomBarItem(
              icon: Icon(FluentIcons.home_24_regular),
              title: Text('Home', style: GoogleFonts.rubik(fontSize: 10)),
              selectedColor: const Color.fromARGB(255, 187, 34, 34),
              unselectedColor: Color.fromARGB(255, 152, 152, 152)
            ),
            SalomonBottomBarItem(
              icon: Icon(FluentIcons.calendar_24_regular),
              title: Text('Events', style: GoogleFonts.rubik(fontSize: 10)),
              selectedColor: const Color.fromARGB(255, 187, 34, 34),
              unselectedColor: Color.fromARGB(255, 152, 152, 152)
            ),
            SalomonBottomBarItem(
              icon: Icon(FluentIcons.food_24_regular),
              title: Text('Food', style: GoogleFonts.rubik(fontSize: 10)),
              selectedColor: const Color.fromARGB(255, 187, 34, 34),
              unselectedColor: Color.fromARGB(255, 152, 152, 152)
            ),
            SalomonBottomBarItem(
              icon: Icon(FluentIcons.trophy_24_regular),
              title: Text('Rank', style: GoogleFonts.rubik(fontSize: 10)),
              selectedColor: const Color.fromARGB(255, 187, 34, 34),
              unselectedColor: Color.fromARGB(255, 152, 152, 152)
            ),
            SalomonBottomBarItem(
              icon: Icon(FluentIcons.alert_24_filled),
              title: Text('', style: GoogleFonts.rubik(fontSize: 6)),
              selectedColor: const Color.fromARGB(255, 187, 34, 34),
              unselectedColor: Color.fromARGB(255, 152, 152, 152)
            ),
          ],
        ),
      ),
    );
  }
}
