import 'package:app/Landing/my_events.dart';
import 'package:app/Landing/my_merch.dart';
import 'package:app/Landing/my_workshop.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyActivitySection extends StatefulWidget {
  const MyActivitySection({super.key});

  @override
  State<MyActivitySection> createState() => _MyActivitySectionState();
}

class _MyActivitySectionState extends State<MyActivitySection> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
           Center(
            child: Text(
              "My Events",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          MyEvents(),
          SizedBox(
            height: 20,
          ),
            Center(
            child: Text(
              "My Workshops",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          MyWorkshop(),
          SizedBox(
            height: 20,
          ),
          // MyMerch(),
        ],
      ),
    );
  }
}
