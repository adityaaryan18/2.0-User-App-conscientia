import 'dart:async';
import 'package:app/Events/event_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class UpcomingEvents extends StatefulWidget {
  final eventData;

  UpcomingEvents({
    super.key,
    required this.eventData,
  });

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 7), (Timer timer) {
      if (_currentPage < widget.eventData.length ~/ 2 - 1) {
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
    // Check if event data is empty or not yet loaded
    bool isLoading = widget.eventData == null || widget.eventData.isEmpty;

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          'UPCOMING EVENTS',
          style: GoogleFonts.rubik(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 200, // Adjust height according to your design
            child: isLoading
                ? Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 127, 127, 127)!,
                    highlightColor: Colors.grey[100]!,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 2, // Show 2 shimmer items for loading effect
                        itemBuilder: (context, index) {
                          return Container(
                            width: 150,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.eventData.length / 2).ceil(),
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      final event1 = widget.eventData[index * 2];
                      final event2 = index * 2 + 1 < widget.eventData.length
                          ? widget.eventData[index * 2 + 1]
                          : null;

                      final DateTime eventDateTime1 =
                          DateTime.parse(event1['eventStartDate']);
                      final String formattedTime1 =
                          DateFormat.jm().format(eventDateTime1);

                      final DateTime eventDateTime2 =
                          DateTime.parse(event2['eventStartDate']);
                      final String formattedTime2 =
                          DateFormat.jm().format(eventDateTime2);

                      final DateTime eventDate1 =
                          DateTime.parse(event1['eventStartDate']);
                      final String formattedDate1 =
                          DateFormat('d MMM').format(eventDate1); // '28 Sep'

                      final DateTime eventDate2 =
                          DateTime.parse(event2['eventStartDate']);
                      final String formattedDate2 =
                          DateFormat('d MMM').format(eventDate2); // '28 Sep'

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                EventCard(
                                  imgURL: event1['nameCard'],
                                  eventData: event1,
                                  titleColor1: Color(int.parse(
                                      '0xff${event1['cssDefinitions']['titleColour1'].substring(1)}')),
                                  titleColor2: Color(int.parse(
                                      '0xff${event1['cssDefinitions']['titleColour2'].substring(1)}')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Card(
                                        color: Colors.black.withOpacity(0.6),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              const Spacer(),
                                              Text(
                                                "Time: $formattedTime1 \n Date: $formattedDate1" ,
                                                style: GoogleFonts.rubik(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const Spacer(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (event2 != null)
                            Expanded(
                              child: Stack(
                                children: [
                                  EventCard(
                                    imgURL: event2['nameCard'],
                                    eventData: event2,
                                    titleColor1: Color(int.parse(
                                        '0xff${event2['cssDefinitions']['titleColour1'].substring(1)}')),
                                    titleColor2: Color(int.parse(
                                        '0xff${event2['cssDefinitions']['titleColour2'].substring(1)}')),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Card(
                                          color: Colors.black.withOpacity(0.6),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Spacer(),
                                                Text(
                                                  "Time: $formattedTime2 \n Date: $formattedDate2",
                                                  style: GoogleFonts.rubik(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Spacer(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    },
                  ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            (widget.eventData.length / 2).ceil(),
            (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                height: 8.0,
                width: _currentPage == index ? 16.0 : 8.0,
                decoration: BoxDecoration(
                  color:
                      _currentPage == index ? Colors.redAccent : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
