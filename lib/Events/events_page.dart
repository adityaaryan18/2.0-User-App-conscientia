import 'package:app/Events/team_builder.dart';
import 'package:app/Events/verify_details.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

class EventsPage extends StatefulWidget {
  final String eventName;
  final Color titleColor1, titleColor2;
  final String aboutEvent;
  final String prizePool;
  final String eventType;
  final eventData;

  EventsPage({
    super.key,
    required this.eventData,
    required this.eventName,
    required this.aboutEvent,
    required this.prizePool,
    required this.eventType,
    required this.titleColor1,
    required this.titleColor2,
  });

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  Map<String, dynamic> eventsUidData = {};

  // void _fetchEventsById() async {
  //   const endpoint =
  //       'https://conscientia2k24-website.vercel.app/api/workshops/getWorkshopByUID';
  //   final response = await http.post(
  //     Uri.parse(endpoint),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'uid': widget.eventData['_id']}),
  //   );


  //   if (response.statusCode == 200) {
  //     final responseData = json.decode(response.body);

  //     setState(() {
  //       eventsUidData = responseData;
  //     });
  //   } else {
  //     print(
  //         'Error: ${response.statusCode}, Message: ${json.decode(response.body)['msg']}');
  //   }
  // }

  List<String> _splitEventName(String eventName) {
    List<String> wordList = eventName.split(RegExp(r'(?=[A-Z])'));
    return wordList;
  }

  @override
  Widget build(BuildContext context) {

    final userProvider = context.read<UserProvider>();
    final user = userProvider.user;




    List<String> wordList = _splitEventName(widget.eventName);
    String startTime = widget.eventData['eventStartDate'];
    String endTime = widget.eventData['eventEndDate'];
    DateTime StartDateTime = DateTime.parse(startTime);
    DateTime EndDateTime = DateTime.parse(endTime);

    // Format the date
    String formatStartDate =
        DateFormat("d MMM y, h:mm a").format(StartDateTime);
    String formatEndDate =
        DateFormat("d MMM y, h:mm a").format(EndDateTime);

    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    List associatedLinks = widget.eventData["associatedLinks"];

    // Function to find the URL for "Brochure"
    String getBrochureUrl(List links) {
      for (var link in links) {
        if (link["name"] == "Brochure") {
          return link["url"];
        }
      }
      return 'https://conscientia.co.in/events/details/${widget.eventData['_id']}'; // Return null if no "Brochure" link is found
    }

    final String brochureUrl = getBrochureUrl(associatedLinks);

  

    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01,
                  horizontal: screenWidth * 0.04,
                ),
                child: FittedBox(
                  child: Row(
                    children: [
                      Text(
                        wordList[0],
                        style: TextStyle(
                          color: widget.titleColor1,
                          fontFamily: "Nasa",
                          fontSize: screenWidth * 0.07,
                        ),
                      ),
                      Text(
                        "${wordList[1]}",
                        style: TextStyle(
                          color: widget.titleColor2,
                          fontFamily: "Nasa",
                          fontSize: screenWidth * 0.07,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: screenWidth * 0.03,
                              offset: Offset(
                                  screenWidth * 0.03, screenHeight * 0.03),
                            ),
                          ],
                        ),
                        child: Image.network(
                          widget.eventData['card'],
                          height: screenHeight * 0.28,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Shimmer.fromColors(
                              baseColor: widget.titleColor1,
                              highlightColor: widget.titleColor2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: widget.titleColor1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: screenWidth * 0.46,
                                    height: screenHeight * 0.27,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: screenWidth * 0.35,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                widget.titleColor1.withOpacity(0.4),
                                widget.titleColor2.withOpacity(0.4)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              tileMode: TileMode.decal),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.eventData['eventType'].toLowerCase() ==
                                      "team"
                                  ? Text(
                                      "Team",
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.045,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Nasa",
                                      ),
                                    )
                                  : Text(
                                      "Solo",
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.045,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Nasa",
                                      ),
                                    ),
                              Text(
                                "Event",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Nasa",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ((widget.eventData['eventPrize'] / 1000)
                                    .round()) !=
                                0
                            ? Container(
                                width: screenWidth * 0.35,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(0, 255, 255, 255)
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(screenWidth * 0.04),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          "Prize Pool",
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.033,
                                            color: Color.fromARGB(
                                                255, 184, 184, 184),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Nasa",
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${(widget.eventData['eventPrize'] / 1000).round()}K',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.05,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Nasa",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    ((widget.eventData['eventPrize'] / 1000).round()) == 0
                        ? Card(
                            color: Colors.black.withOpacity(0.2),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Winning Prize",
                                            style: TextStyle(
                                              fontFamily: "Nasa",
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            widget.eventData['eventRules'][0],
                                            style: GoogleFonts.rubik(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines:
                                                null, // This allows the text to wrap into multiple lines
                                            overflow: TextOverflow
                                                .visible, // Ensures no overflow handling
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Card(
                        color: Colors.black.withOpacity(0.2),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Center(
                                    child: Text(
                                      "Date & Time",
                                      style: TextStyle(
                                        fontFamily: "Nasa",
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                    child: Card(
                                      color:
                                          const Color.fromARGB(0, 255, 255, 255)
                                              .withOpacity(0.11),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Begin",
                                              style: TextStyle(
                                                fontFamily: "Nasa",
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                            FittedBox(
                                              child: Text(
                                                formatStartDate,
                                                style: GoogleFonts.rubik(
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Card(
                                      color:
                                          const Color.fromARGB(0, 255, 255, 255)
                                              .withOpacity(0.11),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "End",
                                              style: TextStyle(
                                                fontFamily: "Nasa",
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                            FittedBox(
                                              child: Text(
                                                formatEndDate,
                                                style: GoogleFonts.rubik(
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      color: Colors.black.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Venue",
                                      style: TextStyle(
                                        fontFamily: "Nasa",
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      widget.eventData['eventVenue'],
                                      style: GoogleFonts.rubik(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      color: Colors.black.withOpacity(0.2),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Registration Fee: ",
                                          style: TextStyle(
                                            fontFamily: "Nasa",
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 172, 172, 172),
                                          ),
                                        ),
                                        Text(
                                          "Rs ${widget.eventData['eventRegistrationFee'].toString()} /-",
                                          style: TextStyle(
                                            fontFamily: "Nasa",
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    if (widget.eventData['eventType'] == 'team')
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Max Members: ',
                                              style: GoogleFonts.rubik(),
                                            ),
                                            Text(
                                                widget.eventData['eventMaxTeam']
                                                    .toString(),
                                                style: GoogleFonts.rubik(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    Row(
                                      children: [
                                        Text(
                                          'Min Members: ',
                                          style: GoogleFonts.rubik(),
                                        ),
                                        Text(
                                          widget.eventData['eventMinTeam']
                                              .toString(),
                                          style: GoogleFonts.rubik(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Card(
                        color: Colors.black.withOpacity(0.15),
                        elevation: 7,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 90,
                                    child: Card(
                                      color:
                                          widget.titleColor1.withOpacity(0.7),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: InkWell(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        onTap: () async {
                                          final Uri url =
                                              Uri.parse(brochureUrl);
                                          if (!await launchUrl(url)) {
                                            throw Exception(
                                                'Could not launch $url');
                                          }
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Icon(
                                            Icons.article_outlined,
                                            color: Colors.white,
                                            size: 42,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Brochure",
                                    style: GoogleFonts.rubik(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 90,
                                    child: Card(
                                      color: widget.titleColor2,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: InkWell(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        onTap: () {
                                          widget.eventData['eventType'] ==
                                                  "team"
                                              ? Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return TeamBuilderPage(
                                                        eventData:
                                                            widget.eventData,
                                                        colorMinor:
                                                            widget.titleColor1,
                                                        colorUp:
                                                            widget.titleColor2,
                                                        colorDown:
                                                            widget.titleColor2,
                                                        MinMembers:
                                                            widget.eventData[
                                                                'eventMinTeam'],
                                                        MaxMembers:
                                                            widget.eventData[
                                                                'eventMaxTeam'],
                                                      );
                                                    },
                                                  ),
                                                )
                                              : Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return VerifyDetailsPage(
                                                        eventDetails:
                                                            widget.eventData,
                                                        teamMembers: [user?.id],
                                                        teamLeader: {'_id': user?.id},
                                                        teamName: user?.firstName,
                                                        eventType:
                                                            widget.eventData[
                                                                'eventType'],
                                                      );
                                                    },
                                                  ),
                                                );
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
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 90,
                                    child: Card(
                                      color:
                                          widget.titleColor1.withOpacity(0.7),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: InkWell(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "About Event",
                        style: TextStyle(
                          fontFamily: "Nasa",
                          fontSize: 20,
                          color: widget.titleColor2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        widget.aboutEvent,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: "Rubik",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Rules",
                        style: TextStyle(
                          fontFamily: "Nasa",
                          fontSize: 20,
                          color: widget.titleColor2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.eventData['eventRules'].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom:
                                    8.0), // Add spacing between items if needed
                            child: Text(
                              '${index + 1}. ${widget.eventData['eventRules'][index]}',
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: "Rubik",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      ),
                    )
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
