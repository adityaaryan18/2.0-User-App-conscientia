import 'package:app/Events/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkshopPage extends StatelessWidget {
  final String workshopName;
  final Color colorUp, colorDown, colorMinor;
  final String aboutWorkshop;
  final String imgURL;
  final String dateTime;
  final String venue;

  const WorkshopPage({
    super.key,
    required this.workshopName,
    required this.colorUp,
    required this.colorDown,
    required this.aboutWorkshop,
    required this.imgURL,
    required this.dateTime,
    required this.venue,
    required this.colorMinor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor1,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          backgroundColor: backgroundColor1,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.book,
                      color: backgroundColor1,
                      size: 40,
                    ),
                    Expanded(
                      child: Text(
                        workshopName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Nasa",
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  clipBehavior: Clip.none,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 60),
                          Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(50)),
                                gradient: LinearGradient(
                                  colors: [colorUp, colorDown],
                                  stops: const [0, 1],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 180),
                                    Card(
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Date & Time",
                                                    style: TextStyle(
                                                      fontFamily: "Nasa",
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    dateTime,
                                                    style: GoogleFonts.rubik(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                    
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        
                                            SizedBox(width: 10,),
                                           
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Venue",
                                                    style: TextStyle(
                                                      fontFamily: "Nasa",
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    venue,
                                                    style: GoogleFonts.rubik(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                     
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Center(
                                      child: Card(
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Card(
                                                    color: colorDown,
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    ),
                                                    child: InkWell(
                                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                      onTap: () {
                                                        // Handle Location Tap
                                                      },
                                                      child: const Padding(
                                                        padding: EdgeInsets.all(10.0),
                                                        child: Icon(
                                                          Icons.location_city,
                                                          color: Colors.white,
                                                          size: 42,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Location",
                                                    style: GoogleFonts.rubik(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Card(
                                                    color: colorDown,
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    ),
                                                    child: InkWell(
                                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                      onTap: () {
                                                        // Handle Register Now Tap
                                                      },
                                                      child: const Padding(
                                                        padding: EdgeInsets.all(10.0),
                                                        child: Icon(
                                                          Icons.edit_document,
                                                          color: Colors.white,
                                                          size: 40,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Register Now",
                                                    style: GoogleFonts.rubik(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    const Text(
                                      "About Event",
                                      style: TextStyle(
                                        fontFamily: "Nasa",
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      aboutWorkshop,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontFamily: "Rubik",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 10,
                        child: Image.asset(
                          'assets/images/sh1.png',
                          height: 250,
                          width: 250,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
