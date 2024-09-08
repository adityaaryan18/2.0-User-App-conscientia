import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

class Announcements extends StatefulWidget {
  const Announcements({super.key});

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;
  List<String> announcements = [];

  // Use the custom Firebase Realtime Database URL for announcements
  final DatabaseReference _announcementsRef = FirebaseDatabase.instance
      .refFromURL('https://consx-user-app-default-rtdb.asia-southeast1.firebasedatabase.app/announcements');

  @override
  void initState() {
    super.initState();
    _fetchAnnouncements();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < announcements.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  void _fetchAnnouncements() {
    // Listen for real-time updates from Firebase using the custom URL
    _announcementsRef.onValue.listen((event) {
      final data = event.snapshot.value as List<dynamic>;
      setState(() {
        announcements = data.cast<String>(); // Convert to List<String>
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'ANNOUNCEMENTS',
          style: GoogleFonts.rubik(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 60, // Adjust height according to your design
          child: announcements.isEmpty
              ? Center(child: CircularProgressIndicator())
              : PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: announcements.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        color: Colors.redAccent.withOpacity(0.7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                announcements[index],
                                style: GoogleFonts.rubik(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(announcements.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              height: 8.0,
              width: _currentPage == index ? 16.0 : 8.0,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? Colors.redAccent
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }),
        ),
      ],
    );
  }
}
