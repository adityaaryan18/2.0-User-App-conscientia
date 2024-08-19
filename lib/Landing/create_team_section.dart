import 'dart:convert';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          "https://conscientia2k24-dev-api.vercel.app/api/dashboard/addtoteam"),
      body: json.encode({'userId': userId, 'friendId': friendId}),
    );
    print('API TO ADD IN TEAM SENT SUCCESSFULLY');
    print(response.statusCode);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Your Request has been sent')),
      );
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send request')),
      );
    }
  } 

  catch (e) {
    Navigator.of(context).pop(); // Ensure the loading dialog is closed in case of error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error fetching user data: $e')),
    );
  }
}

void addToTeamFromPending(String userId, String friendId) async {
  try {
    
    final response = await http.post(
      Uri.parse(
          "https://conscientia2k24-dev-api.vercel.app/api/dashboard/acceptteam"),
      body: json.encode({'userId': userId, 'friendId': friendId}),
    );
    print('OYEE API chala gaya');
    print(response.statusCode);


    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Your Request has been sent')),
      );
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send request')),
      );
    }
  } catch (e) {
    Navigator.of(context).pop(); // Ensure the loading dialog is closed in case of error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error fetching user data: $e')),
    );
  }
}

void removeFromTeam(String userId, String friendId) async {
  try {


    final response = await http.post(
      Uri.parse(
          "https://conscientia2k24-dev-api.vercel.app/api/dashboard/removeteam"),
      body: json.encode({'userId': userId, 'friendId': friendId}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User has been removed from the team')),
      );
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove user from the team')),
      );
    }
  } catch (e) {
    Navigator.of(context).pop(); // Ensure the loading dialog is closed in case of error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error removing user: $e')),
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
                              hintText: 'Search Your Friend Here!',
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
                            Text("This is your Team \n Select Team members "),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: myAllies.length,
                              itemBuilder: (context, index) {
                                final ally =
                                    myAllies[index] as Map<String, dynamic>;
                                return _buildPersonCard(
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
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: myRequests.length,
                          itemBuilder: (context, index) {
                            final request =
                                myRequests[index] as Map<String, dynamic>;
                            return _buildPersonCard(
                              request['username'] ?? 'Unknown',
                              request['profile'] ??
                                  'assets/images/profile_default.png',
                              isApproved: false,
                            );
                          },
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

  Widget _buildPersonCard(String name, String imagePath,
      {required bool isApproved}) {
    return GestureDetector(
      onTap: () {
        _showPersonDialog(name, isApproved);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.black.withOpacity(0.3),
        child: ListTile(
          leading: Icon(
            isApproved ? Icons.remove : Icons.add,
            color: isApproved ? Colors.red : Colors.green,
          ),
          title: Text(name, style: TextStyle(color: Colors.white)),
          trailing: CircleAvatar(
            backgroundImage: imagePath.startsWith('http')
                ? NetworkImage(imagePath)
                : AssetImage(imagePath) as ImageProvider,
          ),
        ),
      ),
    );
  }

  void _showPersonDialog(String name, bool isApproved, ) {
    String dialogMessage = isApproved
        ? 'Warrior! Do you want to eliminate "$name" from your team?'
        : 'Warrior! Do you want to include "$name" into your team?';
        
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.8),
          title: Text(name, style: TextStyle(color: Colors.white)),
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
                  removeFromTeam(
                      context.read<User?>()?.uid ?? '', name);
                } else {
                  addToTeamFromPending(context.read<User?>()?.uid ?? '', name);
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