import 'package:app/main.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MyWorkshop extends StatefulWidget {
  const MyWorkshop({super.key});

  @override
  State<MyWorkshop> createState() => _MyWorkshopState();
}

class _MyWorkshopState extends State<MyWorkshop> {
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    // If user is null, show shimmer loading cards
    if (user == null) {
      return Column(
        children: List.generate(
            3, (index) => _buildShimmerCard()), // Shimmer loading for 3 cards
      );
    }

    // Get the registered workshops list
    List<dynamic> registeredworkshops = user?.registeredWorkshops ?? [];

    // If no registered workshops, show a message
    if (registeredworkshops.isEmpty) {
      return const Center(
        child: Text(
          "You are not registered in any workshop",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    final double locationFontSize =
        screenWidth * 0.03 > 13 ? 13 : screenWidth * 0.035;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        ...registeredworkshops.map((workshop) {
          // Extract workshop data
          final participantworkshop = workshop['participantWorkshop'];
          final paymentObject = workshop['paymentObject'];
          final teamMembers = workshop['participantMembers'] ?? [];
          final teamLeader = workshop['teamLeader'] ?? [];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
            child: Card(
              color: const Color.fromARGB(68, 0, 0, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side:
                    const BorderSide(color: Color.fromARGB(132, 158, 158, 158)),
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
                                participantworkshop['workshopName'] ?? 'workshop',
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
                              "workshop ID: ${participantworkshop['workshopId']}",
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
                                    "LOCATION: ${participantworkshop['workshopVenue']}",
                                    style: GoogleFonts.rubik(
                                      color: Colors.white,
                                      fontSize: locationFontSize,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            FittedBox(
                              child: Text(
                                "Payment ID: ${paymentObject['paymentId']}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Members: ${workshop['participantNo']}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            GestureDetector(
                              onTap: () => _showTeamMembersPopup(
                                  context, teamMembers, teamLeader),
                              child: Card(
                                color: Colors.black.withOpacity(0.3),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 10),
                                  child: Text(
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
                    // Right side (Image and workshop Details)
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Image.network(participantworkshop['card']),
                          ),
                          const SizedBox(height: 8),
                          FittedBox(
                            child: Text(
                              "Time: ${_formatTime(participantworkshop['workshopStartDate'])}",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 185, 185, 185),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              "Date: ${_formatDate(participantworkshop['workshopStartDate'])}",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 170, 170, 170),
                                  fontWeight: FontWeight.bold),
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

// Helper functions to format date and time
  String _formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  String _formatTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return "${dateTime.hour}:${dateTime.minute} ${dateTime.hour >= 12 ? 'PM' : 'AM'}";
  }

  // Shimmer loading card
  Widget _buildShimmerCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[700]!,
        highlightColor: Colors.grey[500]!,
        child: Card(
          color: Colors.grey[850],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[850],
            ),
          ),
        ),
      ),
    );
  }

  void _showTeamMembersPopup(
      BuildContext context, List<dynamic> teamMembers, Map teamLeader) {
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
                    color: member['forceId'] == teamLeader['forceId']
                        ? Color.fromARGB(255, 255, 84, 84).withOpacity(0.2)
                        : Colors.grey.withOpacity(0.2),
                    child: ListTile(
                      title: Text(
                        '${member['firstName']} ${member['lastName']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: FittedBox(
                        child: Text(
                          '${member['forceId']}: ${member['forceId'] == teamLeader['forceId'] ? 'CAPTAIN' : "MEMBER"}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(member['profile']),
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
