import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert'; // For JSON decoding
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

class AnnouncementPage extends StatefulWidget {
  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  List notifications = []; // List to hold notifications
  bool isLoading = true; // To control shimmer loading

  @override
  void initState() {
    super.initState();
  }

  // Function to call the API and fetch notifications
  Future<void> fetchNotifications(String uid) async {
    final url =
        'https://socketserver.conscientia.co.in/api/getUserNotifications'; // Replace with your API endpoint
    final body = jsonEncode({'uid': uid});

    try {

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {


        final List<dynamic> responseData = jsonDecode(response.body);

        // Process the response data and update the state
        setState(() {
          notifications = responseData;
          isLoading = false; // Stop the shimmer loading
        });
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (error) {
      print(error);
      setState(() {
        isLoading = false; // Stop the shimmer even on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();


    if (notifications.isEmpty) {
      fetchNotifications(firebaseUser!.uid);
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/teams background.png',
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor:
                Colors.black.withOpacity(0.6), // Semi-transparent overlay
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "NOTIFICATIONS",
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: "Nasa",
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Expanded(
                    child: isLoading
                        ? Center(
                            child: Shimmer.fromColors(
                              baseColor:
                                  const Color.fromARGB(255, 143, 143, 143).withOpacity(0.5)!,
                              highlightColor: Color.fromARGB(255, 106, 106, 106)!,
                              child: ListView.builder(
                                itemCount: 6, // Simulate loading with 6 items
                                itemBuilder: (context, index) {
                                  return Card(
                                    margin: EdgeInsets.all(10),
                                    child: ListTile(
                                      title: Container(
                                        height: 20,
                                        color: Color.fromARGB(255, 61, 61, 61),
                                      ),
                                      subtitle: Container(
                                        height: 15,
                                        color: const Color.fromARGB(255, 63, 63, 63),
                                      ),
                                      leading: Container(
                                        width: 40,
                                        height: 40,
                                        color: const Color.fromARGB(255, 82, 82, 82),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : notifications.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  child: Text(
                                    "No new notifications received yet",
                                    style: GoogleFonts.rubik(
                                        fontWeight: FontWeight.bold,
                                        color:  Color.fromARGB(
                                            255, 98, 98, 98)),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: notifications.length,
                                itemBuilder: (context, index) {
                                  var notification = notifications[index];
                                  String heading = notification['headings']
                                          ['en'] ??
                                      'No Heading';
                                  String content = notification['contents']
                                          ['en'] ??
                                      'No Content';
                                  int completedAt =
                                      notification['completed_at'] ?? 'No Time';

                                  return Card(
                                    color: Color.fromARGB(255, 51, 51, 51).withOpacity(0.3),
                                    margin: EdgeInsets.all(10),
                                    child: ListTile(
                                      title: Text(
                                        heading,
                                        style: GoogleFonts.rubik(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // subtitle: Text(content),
                                      leading: Icon(Icons.notifications),
                                      subtitle: Text(
  DateFormat('dd-MM-yy  |  HH:mm').format(
    DateTime.fromMillisecondsSinceEpoch(completedAt * 1000),
  ),
),

                                    ),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// "https://sea-turtle-app-tw986.ondigitalocean.app/api/getUserNotifications"
// {'uid':userprovider.firebaseUID} 
// [{'headings': {'en':'some message'}, 'contents':{'en':'some message'}, 'completed_at':'time value in seconds'},{similarly here too},{similarlary here too}]