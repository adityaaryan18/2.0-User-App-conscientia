import 'dart:async';
import 'package:app/Events/events_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({super.key});

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  static const List<String> events = [
    "Fun Event 1",
    "Fun Event 2",
    "Fun Event 3",
    "Fun Event 4",
    "Fun Event 5",
    "Fun Event 6",
    "Fun Event 7",
    "Fun Event 8"
  ];

  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 7), (Timer timer) {
      if (_currentPage < events.length ~/ 2 - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
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
        SizedBox(height: 10,),
        Text(
          'UPCOMING EVENTS',
          style: GoogleFonts.rubik(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 200, // Adjust height according to your design
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: (events.length / 2).ceil(), // Half the length as each page shows 2 items
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: EventCard(
                      imgURL: "assets/images/event_image.png",
                      eventName: events[index * 2],
                      colorUp: Colors.blueAccent,
                      colorDown: Colors.lightBlue,
                      colorMinor: Colors.lightBlueAccent,
                      eventTime: "5:00 PM",
                    ),
                  ),
                  if (index * 2 + 1 < events.length)
                    Expanded(
                      child: EventCard(
                        imgURL: "assets/images/event_image.png",
                        eventName: events[index * 2 + 1],
                        colorUp: Colors.redAccent,
                        colorDown: Colors.pinkAccent,
                        colorMinor: Colors.pink,
                        eventTime: "6:00 PM",
                      ),
                    ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate((events.length / 2).ceil(), (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              height: 8.0,
              width: _currentPage == index ? 16.0 : 8.0,
              decoration: BoxDecoration(
                color: _currentPage == index ? Colors.redAccent : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class EventCard extends StatelessWidget {
  final String imgURL;
  final String eventName;
  final String eventTime;
  final Color colorUp, colorDown, colorMinor;
  
  const EventCard({
    super.key,
    required this.imgURL,
    required this.eventName,
    required this.colorDown,
    required this.colorUp,
    required this.colorMinor,
    required this.eventTime,
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
        padding: const EdgeInsets.all(2.0),
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
                shadowColor: const Color.fromARGB(255, 203, 203, 203),
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
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      eventTime,
                                      style: const TextStyle(
                                        fontFamily: 'Nasa',
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
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
                                  style: const TextStyle(
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
