import 'dart:convert';
import 'package:app/Food/home_page.dart';
import 'package:app/main.dart';
import 'package:app/pages/events_workshop_homepage.dart';
import 'package:app/Landing/dashboard_page.dart';
import 'package:app/pages/leaderboard_page.dart';
import 'package:app/pages/notifications_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  IO.Socket? socket;

  @override
  void initState() {
    super.initState();
    initializeSocket();
  }

  bool canpop() {
    if (_selectedIndex == 0) {
      return true;
    } else {
      return false;
    }
  }

  final List<Widget> _pages = [
    DashboardPage(),
    EventsWorkshopsHomepage(),
    MyHomePage(),
    LeaderboardPage(),
    NotificationsPage(),
  ];

  void getUserDetails(String uid) async {
    try {
      final response = await http.post(
        Uri.parse('https://conscientia2k24-dev-api.vercel.app/api/getUser'),
        body: json.encode({'userId': uid}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = UserModel.fromJson(data['user']);
        context.read<UserProvider>().setUser(user);
        // Initialize socket after fetching user data
        initializeSocket(uid);
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void initializeSocket([String? uid]) {
    socket = IO.io('https://socketserver-conscientia2k24-o343q.ondigitalocean.app/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket?.connect();

    socket?.onConnect((_) {
      print('Connected to socket');
      // Subscribe to the user's room or listen for specific events
      if (uid != null) {
        socket?.emit('join', uid);
      }
    });

socket?.on('userUpdate', (data) {
  print("Data recieved using socket");
  print(data);

  // Parse the updated user data from the socket response
  final updatedUser = UserModel.fromJson(data);

  // Get the Firebase user ID of the currently logged-in user
  final firebaseUser = context.read<User?>();

  if (firebaseUser != null && updatedUser.userId == firebaseUser.uid) {
    // Update the user details only if the Firebase IDs match
    context.read<UserProvider>().setUser(updatedUser);
  } else {
    print('Firebase ID mismatch: update ignored.');
  }
});

    socket?.onDisconnect((_) {
      print('Disconnected from socket');
    });
  }

  @override
  void dispose() {
    socket?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      final uid = firebaseUser.uid;
      getUserDetails(uid);

      return PopScope(
        canPop: canpop(),
        onPopInvoked: (didPop) {
          if (_selectedIndex != 0) {
            setState(() {
              _selectedIndex = 0;
            });
          }
        },
        child: Scaffold(
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
                  unselectedColor: const Color.fromARGB(255, 152, 152, 152),
                ),
                SalomonBottomBarItem(
                  icon: Icon(FluentIcons.calendar_24_regular),
                  title: Text('Events', style: GoogleFonts.rubik(fontSize: 10)),
                  selectedColor: const Color.fromARGB(255, 187, 34, 34),
                  unselectedColor: const Color.fromARGB(255, 152, 152, 152),
                ),
                SalomonBottomBarItem(
                  icon: Icon(FluentIcons.food_24_regular),
                  title: Text('Food', style: GoogleFonts.rubik(fontSize: 10)),
                  selectedColor: const Color.fromARGB(255, 187, 34, 34),
                  unselectedColor: const Color.fromARGB(255, 152, 152, 152),
                ),
                SalomonBottomBarItem(
                  icon: Icon(FluentIcons.trophy_24_regular),
                  title: Text('Rank', style: GoogleFonts.rubik(fontSize: 10)),
                  selectedColor: const Color.fromARGB(255, 187, 34, 34),
                  unselectedColor: const Color.fromARGB(255, 152, 152, 152),
                ),
                SalomonBottomBarItem(
                  icon: Icon(FluentIcons.alert_24_filled),
                  title: Text('', style: GoogleFonts.rubik(fontSize: 6)),
                  selectedColor: const Color.fromARGB(255, 187, 34, 34),
                  unselectedColor: const Color.fromARGB(255, 152, 152, 152),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
