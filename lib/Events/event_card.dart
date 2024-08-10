import 'package:app/Events/events_page.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String imgURL;
  final String eventName;
  final Color colorUp, colorDown, colorMinor;
  const EventCard({
    super.key,
    required this.imgURL,
    required this.eventName,
    required this.colorDown,
    required this.colorUp,
    required this.colorMinor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return EventsPage(
                dateTime: "5 October 2024, 6 PM",
                venue: "Aerospace Block/D3",
                imgURL: "assets/images/shoe4.png",
                colorDown: colorDown,
                colorUp: colorUp,
                colorMinor: colorMinor,
                aboutEvent:
                    "A maze solver event is a competition or activity where participants are tasked with navigating or programming a solution to traverse a maze. These events can vary in complexity and format, often involving physical robots, software algorithms, or even human participants solving a maze on foot. A maze solver event is a competition or activity where participants are tasked with navigating or programming a solution to traverse a maze. These events can vary in complexity and format, often involving physical robots, software algorithms, or even human participants solving a maze on foot.",
                eventName: "Night Sky Hunt",
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.transparent,
          child: Stack(
            children: [
              Card(
                clipBehavior: Clip.none,
                semanticContainer: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                elevation: 0,
                shadowColor: Color.fromARGB(255, 203, 203, 203),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        gradient: LinearGradient(
                          colors: [
                            colorUp,
                            colorDown,
                          ],
                          stops: const [0, 1],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: Card(
                            color: Colors.transparent,
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.15),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Image.asset(
                                    imgURL,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Card(
                            color: Colors.black.withOpacity(0.6),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  eventName,
                                  style: TextStyle(
                                    fontFamily: 'Nasa',
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}