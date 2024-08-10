import 'package:app/Events/workshop_page.dart';

import 'package:flutter/material.dart';

class WorkshopCard extends StatelessWidget {
  final String imgURL;
  final String eventName;
  final Color colorUp, colorDown, colorMinor;
  final String aboutWorkshop;
  const WorkshopCard({
    super.key,
    required this.imgURL,
    required this.eventName,
    required this.colorDown,
    required this.colorUp,
    required this.aboutWorkshop,
    required this.colorMinor,
  });

  @override
  Widget build(BuildContext context) {
    List<String> wordList = [];
    int start = 0;
    for (int i = 0; i < eventName.length; i++) {
      if (eventName[i] == ' ') {
        String temp = eventName.substring(start, i);
        wordList.add(temp);
        start = i + 1;
      }
    }
    // Add the last word to the list
    if (start < eventName.length) {
      wordList.add(eventName.substring(start));
    }
    if (wordList.length == 2) {
      wordList.add(" ");
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return WorkshopPage(
                dateTime: "5 October 2024, 6 PM",
                venue: "Aerospace Block/D3",
                imgURL: "assets/images/shoe2.png",
                colorDown: colorDown,
                colorUp: colorUp,
                colorMinor: colorMinor,
                aboutWorkshop:
                    "A maze solver event is a competition or activity where participants are tasked with navigating or programming a solution to traverse a maze. These events can vary in complexity and format, often involving physical robots, software algorithms, or even human participants solving a maze on foot. A maze solver event is a competition or activity where participants are tasked with navigating or programming a solution to traverse a maze. These events can vary in complexity and format, often involving physical robots, software algorithms, or even human participants solving a maze on foot.",
                workshopName: "Night Sky Hunt",
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              gradient: LinearGradient(
                colors: [
                  colorDown,
                  colorUp,
                ],
                stops: const [0, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                transform: const GradientRotation(-10 / 4),
              ),
            ),
            child: Card(
              clipBehavior: Clip.none,
              semanticContainer: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              elevation: 0,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0, top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              eventName,
                              style: const TextStyle(
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 10,
                                        offset: Offset(0, 2))
                                  ],
                                  color: Colors.white,
                                  fontFamily: "Ethnocentric",
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: 180,
                              height: 120,
                              child: Text(
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.fade,
                                aboutWorkshop,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: "Rosario",
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 4.0, left: 4, right: 4),
                              child: Image.asset(
                                imgURL,
                                height: 140,
                                width: 140,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 6.0, right: 5),
                            child: Icon(
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    blurRadius: 10,
                                    offset: Offset(0, 2))
                              ],
                              Icons.keyboard_double_arrow_right_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 15),
              ),
            )),
      ),
    );
  }
}