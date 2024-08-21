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
    return SingleChildScrollView(
      child: Column(
        children: [

          MyEvents(),
          SizedBox(height: 20,),
          MyWorkshop(),
          SizedBox(height: 20,),
          MyMerch(),

        ],
      ),
    );
  }
}




class MyEvents extends StatefulWidget {
  const MyEvents({super.key});

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double locationFontSize =
        screenWidth * 0.03 > 13 ? 13 : screenWidth * 0.035;

    // Dummy events list
    final List<Map<String, dynamic>> events = [
      {
        'name': 'DRONTRIX',
        'location': 'Online',
        'price': 'Free',
        'members': 50,
        'eventId': 'EVT-101',
        'date': '2024-09-10',
        'time': '10:00 AM',
        'image': 'assets/images/event.png',
        'teamMembers': [
          {'name': 'Ankit Raj', 'forceId': 'Force-2', 'designation': 'Member'},
          {
            'name': 'Aditya Aryan',
            'forceId': 'Force-3',
            'designation': 'Captain'
          },
        ],
      },
      {
        'name': 'DART CONFERENCE',
        'location': 'New York',
        'price': '\$99',
        'members': 150,
        'eventId': 'EVT-102',
        'date': '2024-10-15',
        'time': '2:00 PM',
        'image': 'assets/images/event.png',
        'teamMembers': [
          {
            'name': 'Sonia Kumar',
            'forceId': 'Force-4',
            'designation': 'Member'
          },
          {
            'name': 'Rajesh Sharma',
            'forceId': 'Force-5',
            'designation': 'Member'
          },
        ],
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            "My Events",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ...events.map((event) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
            child: Card(
              color: const Color.fromARGB(68, 0, 0, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Color.fromARGB(132, 158, 158, 158)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    // Left side
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 53, 53, 53)
                              .withOpacity(0.4),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                event['name']!,
                                style: const TextStyle(
                                  fontFamily: 'Nasa',
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Event ID: ${event['eventId']}",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 33, 33),
                                  fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                      
                            Card(
                              color: Colors.black.withOpacity(0.3),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "LOCATION: ${event['location']}",
                                    style: GoogleFonts.rubik(
                                      color: Colors.white,
                                      fontSize: locationFontSize,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "Payment ID: ${event['price']}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Members: ${event['members']}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            GestureDetector(
                              onTap: () => _showTeamMembersPopup(
                                context, event['teamMembers']),
                              child: Card(
                                color: Colors.black.withOpacity(0.3),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10 ),
                                  child: const Text(
                                    "Team Members",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Right side (Image and Event Details)
            
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Image.asset(event['image']),
                          ),
                          const SizedBox(height: 8),
                          FittedBox(
                            child: Text(
                              "Time: ${event['time']}",
                              style: const TextStyle(color: Color.fromARGB(255, 185, 185, 185), fontWeight: FontWeight.bold),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              "Date: ${event['date']}",
                              style: const TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
  
  void _showTeamMembersPopup(
      BuildContext context, List<Map<String, dynamic>> teamMembers) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black.withOpacity(0.7),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Team Members",
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...teamMembers.map((member) {
                  return Card(
                    color: Colors.grey.withOpacity(0.2),
                    child: ListTile(
                      title: Text(
                        '${member['name']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        '${member['forceId']} | ${member['designation']}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyWorkshop extends StatefulWidget {
  const MyWorkshop({super.key});

  @override
  State<MyWorkshop> createState() => _MyWorkshopState();
}

class _MyWorkshopState extends State<MyWorkshop> {
 @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double locationFontSize =
        screenWidth * 0.03 > 13 ? 13 : screenWidth * 0.035;

    // Dummy events list
    final List<Map<String, dynamic>> events = [
      {
        'name': 'DRONTRIX',
        'location': 'Online',
        'price': 'Free',
        'members': 50,
        'eventId': 'EVT-101',
        'date': '2024-09-10',
        'time': '10:00 AM',
        'image': 'assets/images/event.png',
        'teamMembers': [
          {'name': 'Ankit Raj', 'forceId': 'Force-2', 'designation': 'Member'},
          {
            'name': 'Aditya Aryan',
            'forceId': 'Force-3',
            'designation': 'Captain'
          },
        ],
      },
      {
        'name': 'DART CONFERENCE',
        'location': 'New York',
        'price': '\$99',
        'members': 150,
        'eventId': 'EVT-102',
        'date': '2024-10-15',
        'time': '2:00 PM',
        'image': 'assets/images/event.png',
        'teamMembers': [
          {
            'name': 'Sonia Kumar',
            'forceId': 'Force-4',
            'designation': 'Member'
          },
          {
            'name': 'Rajesh Sharma',
            'forceId': 'Force-5',
            'designation': 'Member'
          },
        ],
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            "My Workshop",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ...events.map((event) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
            child: Card(
              color: const Color.fromARGB(68, 0, 0, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Color.fromARGB(90, 158, 158, 158)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    // Left side
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 53, 53, 53)
                              .withOpacity(0.4),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                event['name']!,
                                style: const TextStyle(
                                  fontFamily: 'Nasa',
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Event ID: ${event['eventId']}",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 33, 33),
                                  fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                      
                            Card(
                              color: Colors.black.withOpacity(0.3),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "LOCATION: ${event['location']}",
                                    style: GoogleFonts.rubik(
                                      color: Colors.white,
                                      fontSize: locationFontSize,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "Payment ID: ${event['price']}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Members: ${event['members']}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            GestureDetector(
                              onTap: () => _showTeamMembersPopup(
                                context, event['teamMembers']),
                              child: Card(
                                color: Colors.black.withOpacity(0.3),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10 ),
                                  child: const Text(
                                    "Team Members",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Right side (Image and Event Details)
            
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Image.asset(event['image']),
                          ),
                          const SizedBox(height: 8),
                          FittedBox(
                            child: Text(
                              "Time: ${event['time']}",
                              style: const TextStyle(color: Color.fromARGB(255, 185, 185, 185), fontWeight: FontWeight.bold),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              "Date: ${event['date']}",
                              style: const TextStyle(color: Color.fromARGB(255, 170, 170, 170), fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
  
  void _showTeamMembersPopup(
      BuildContext context, List<Map<String, dynamic>> teamMembers) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black.withOpacity(0.7),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Team Members",
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...teamMembers.map((member) {
                  return Card(
                    color: Colors.grey.withOpacity(0.2),
                    child: ListTile(
                      title: Text(
                        '${member['name']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        '${member['forceId']} | ${member['designation']}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyMerch extends StatefulWidget {
  const MyMerch({super.key});

  @override
  State<MyMerch> createState() => _MyMerchState();
}

class _MyMerchState extends State<MyMerch> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double locationFontSize =
        screenWidth * 0.03 > 13 ? 13 : screenWidth * 0.035;

    // Dummy merch list
    final List<Map<String, dynamic>> merch = [
      {
        'name': 'Astral T-Shirt',
        'price': '\$25',
        'paymentId': 'PAY-201',
        'description': 'A cool t-shirt featuring the Astral Armageddon logo.',
        'image': 'assets/images/tshirt.png',
      },
      {
        'name': 'Space Mug',
        'price': '\$15',
        'paymentId': 'PAY-202',
        'description': 'A ceramic mug with the space theme.',
        'image': 'assets/images/tshirt.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            "My Merch",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ...merch.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
            child: Card(
              color: const Color.fromARGB(68, 0, 0, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Color.fromARGB(139, 158, 158, 158)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    // Left side
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 53, 53, 53)
                              .withOpacity(0.4),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                item['name']!,
                                style: const TextStyle(
                                  fontFamily: 'Nasa',
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Payment ID: ${item['paymentId']}",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 33, 33),
                                  fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Price: ${item['price']}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Description: ${item['description']}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Right side (Image)
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Image.asset(item['image']),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

