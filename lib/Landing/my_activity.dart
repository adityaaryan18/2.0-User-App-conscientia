import 'package:app/Landing/my_events.dart';

import 'package:app/Landing/my_workshop.dart';
import 'package:flutter/material.dart';

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
            child: Card(
              color: Color.fromARGB(255, 46, 46, 46),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  "My Events",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          MyEvents(),
          SizedBox(
            height: 20,
          ),
            Center(
            child: Card(
               color: Color.fromARGB(255, 46, 46, 46),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  "My Workshops",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
