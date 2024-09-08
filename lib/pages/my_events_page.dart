import 'package:app/Landing/my_events.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyEventsPage extends StatelessWidget {
  const MyEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,  // This allows the app bar to be transparent over the background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,  // Removes the shadow
        title: Text(
          'My Events',
          style: GoogleFonts.rubik(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();  // Go back to the previous page
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/teams background.png',
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: kToolbarHeight + 20),  // To prevent content from being hidden behind the app bar
                MyEvents(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
