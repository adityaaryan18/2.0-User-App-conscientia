import 'dart:convert';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class CreateTeamSection extends StatefulWidget {
  const CreateTeamSection({super.key});

  @override
  _CreateTeamSectionState createState() => _CreateTeamSectionState();
}

class _CreateTeamSectionState extends State<CreateTeamSection> {
  bool isApprovedSelected = true;
  final textEditingController = TextEditingController();

  void addToTeam(String userId, String friendId) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://conscientia.co.in/api/dashboard/addtoteam"),
        body: json.encode({'userId': userId, 'friendId': friendId}),
      );

      print('API TO ADD IN TEAM SENT SUCCESSFULLY');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['msg'])),
        );
        setState(() {}); // Assuming this is within a stateful widget
      } else {
        final responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['msg'])),
        );
      }
    } catch (e) {
      Navigator.of(context)
          .pop(); // Ensure the loading dialog is closed in case of error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user data: $e')),
      );
    }
  }

  void addToTeamFromPending(String userId, String friendId) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://conscientia.co.in/api/dashboard/acceptteam"),
        body: json.encode({'userId': userId, 'friendId': friendId}),
      );
      print('OYEE API chala gaya');
      print(response.statusCode);
      print(response);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['msg'])),
        );
        setState(() {}); // Assuming this is within a stateful widget
      } else {
        final responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['msg'])),
        );
      }
    } catch (e) {
      Navigator.of(context)
          .pop(); // Ensure the loading dialog is closed in case of error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user data: $e')),
      );
    }
  }

  void removeFromTeam(String userId, String friendId) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://conscientia.co.in/api/dashboard/removeteam"),
        body: json.encode({'userId': userId, 'friendId': friendId}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['msg'])),
        );
        setState(() {}); // Assuming this is within a stateful widget
      } else {
        final responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['msg'])),
        );
      }
    } catch (e) {
      Navigator.of(context)
          .pop(); // Ensure the loading dialog is closed in case of error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user data: $e')),
      );
    }
  }

  Future<void> _showLoadingDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;
    final firebaseUser = context.watch<User?>();
    final uid = firebaseUser?.uid;

    List<dynamic> myAllies = user?.myAllies ?? [];
    List<dynamic> myRequests = user?.myRequests ?? [];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.redAccent.shade700.withOpacity(0.13),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.grey.shade300, width: 0.06),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                              hintText: 'Enter Your Friend Username',
                              hintStyle: TextStyle(color: Colors.white70),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.white70),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.red.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6),
                          child: GestureDetector(
                            onTap: () {
                              addToTeam(uid!, textEditingController.text);
                            },
                            child: Text(
                              'Add To Friendlist',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSectionCard('Your Team', isApprovedSelected,
                              () {
                            setState(() {
                              isApprovedSelected = true;
                            });
                          }),
                          _buildSectionCard('Pending', !isApprovedSelected, () {
                            setState(() {
                              isApprovedSelected = false;
                            });
                          }),
                        ],
                      ),
                      const SizedBox(height: 20),
                      if (isApprovedSelected)
                        Column(
                          children: [
                            FittedBox(child: Text(myAllies.length==0? 'Search Your friend to Add them to your team' : "Add them during Event Registration")),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: myAllies.length,
                              itemBuilder: (context, index) {
                                final ally =
                                    myAllies[index] as Map<String, dynamic>;
                                return _buildPersonCard(
                                  ally['firstName']?? 'Unknown',
                                  ally['username'] ?? 'Unknown',
                                  ally['profile'] ??
                                      'assets/images/profile_default.png',
                                  isApproved: true,
                                );
                              },
                            ),
                          ],
                        )
                      else
                        Column(
                          children: [
                            FittedBox(child: Text(myRequests.length==0? "People who sent you request will show up here": "People waiting for your Approval")),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: myRequests.length,
                              itemBuilder: (context, index) {
                                final request =
                                    myRequests[index] as Map<String, dynamic>;
                                return _buildPersonCard(
                                  request['firstName']??"Unknown",
                                  request['username'] ?? 'Unknown',
                                  request['profile'] ??
                                      'assets/images/profile_default.png',
                                  isApproved: false,
                                );
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: !isSelected
                ? const Color.fromARGB(255, 125, 125, 125)
                : Colors.red.withOpacity(0.4),
            width: 0.2,
          ),
        ),
        color: isSelected
            ? Colors.redAccent.shade200.withOpacity(0.3)
            : const Color.fromARGB(255, 40, 40, 40).withOpacity(0.3),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonCard(String firstname,String username, String imagePath,
      {required bool isApproved}) {
    return GestureDetector(
      onTap: () {
        _showPersonDialog(firstname,username, isApproved);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.black.withOpacity(0.3),
        child: ListTile(
          trailing: Icon(
            isApproved ? Icons.remove : Icons.add,
            color: isApproved ? Colors.red : Colors.green,
          ),
          title: Column(
            children: [
              Text(firstname.toUpperCase(), style: GoogleFonts.rubik(color: Colors.white, fontWeight: FontWeight.bold)),
              FittedBox(child: Text(username, style: GoogleFonts.rubik(color: Colors.white, fontSize: 12))),
            ],
          ),
          leading: CircleAvatar(
            backgroundImage: imagePath.startsWith('http')
                ? NetworkImage(imagePath)
                : AssetImage(imagePath) as ImageProvider,
          ),
        ),
      ),
    );
  }

  void _showPersonDialog(
    String firstname,
    String username,
    bool isApproved,
  ) {
    String dialogMessage = isApproved
        ? 'Warrior! \nDo you want to eliminate "$firstname" from your team?'
        : 'Warrior! \nDo you want to include "$firstname" into your team?';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.8),
          title: Text(firstname, style: TextStyle(color: Colors.white)),
          content: Text(dialogMessage, style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (isApproved) {
                  removeFromTeam(context.read<User?>()?.uid ?? '', username);
                } else {
                  addToTeamFromPending(context.read<User?>()?.uid ?? '', username);
                }
              },
              child: Text('Yes', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }
}
