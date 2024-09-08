import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:app/Events/events_page.dart';

class EventCard extends StatelessWidget {
  final String imgURL;
  final eventData;
  final Color titleColor1,
      titleColor2;

  const EventCard({
    super.key,
    required this.imgURL,
    required this.eventData,
    required this.titleColor1,
    required this.titleColor2,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return EventsPage(

                aboutEvent: eventData['eventDescription'],
                eventName: eventData['eventName'],
                prizePool: '${(eventData['eventPrize'] / 1000).round()} ${'K'}',
                eventType: 'Team',
                titleColor1: titleColor1,
                titleColor2: titleColor2,
                eventData: eventData,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 10,
                              offset: const Offset(2, 10),
                            ),
                          ],
          ),
          child: Stack(
            children: [
              Center(
                  child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    eventData['eventName'],
                    style: TextStyle(
                      fontFamily: "Nasa",
                      fontSize: 12,
                    ),
                  ),
                ),
              )),
              Image.network(
              
                imgURL,
              
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // Display the image if it is loaded
                  } else {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[800]!,
                      highlightColor: Colors.grey[600]!,
                      child: Card(
                        color: Colors.grey[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 120.0,
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ); // Display shimmer effect while loading
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
