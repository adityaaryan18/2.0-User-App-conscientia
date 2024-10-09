
import 'package:app/Events/verify_details.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TeamBuilderPage extends StatefulWidget {
  final Color colorUp;
  final Color colorDown;
  final Color colorMinor;
  final eventData;
  final int MinMembers;
  final int MaxMembers;

  const TeamBuilderPage({
    super.key,
    required this.colorUp,
    required this.colorDown,
    required this.colorMinor,
    required this.eventData,
    required this.MinMembers,
    required this.MaxMembers,
  });

  @override
  _TeamBuilderPageState createState() => _TeamBuilderPageState();
}

class _TeamBuilderPageState extends State<TeamBuilderPage> {
  List<Map<String, dynamic>> people = [];
  List<Map<String, dynamic>> teamMembers = [];
  Map teamLeader = {};
  String? teamName;
  List<String> teamMembersList=[];  

  final TextEditingController _teamNameController = TextEditingController();
  final FocusNode _teamNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final userProvider = context.read<UserProvider>();
    if (userProvider.user != null) {
      people = List<Map<String, dynamic>>.from(userProvider.user!.myAllies);
      // Add the user to the teamMembers list
      teamMembers.add({
        'firstName': userProvider.user!.firstName,
        'lastName': userProvider.user!.lastName,
        'username': userProvider.user!.username,
        '_id': userProvider.user!.id,
      });
      teamMembersList.add(userProvider.user!.id);
    }
  }


  void _unfocusTextField() {
    if (!_teamNameFocusNode.hasFocus) {
      _teamNameFocusNode.unfocus();
    }
  }

  void _showIncompleteDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Attention Warrior!',
            style: TextStyle(fontFamily: 'Nasa', fontSize: 16),
          ),
          content: Text(
            message,
            style: GoogleFonts.rubik(),
          ),
          actions: [
            TextButton(
              child: Text('OK', style: TextStyle(color:Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Build Your Team',
          style: TextStyle(fontFamily: 'Nasa', fontSize: 17),
        ),
      ),
      body: GestureDetector(
        onTap: _unfocusTextField,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Icon(
                  Icons.group_rounded,
                  size: 50,
                  color: Colors.white,
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: widget.colorDown.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _teamNameController,
                            focusNode: _teamNameFocusNode,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Nasa",
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter A Team Name',
                              hintStyle: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: "Nasa",
                                  fontSize: 12),
                            ),
                            onChanged: (value) {
                              setState(() {
                                teamName = value;
                                _unfocusTextField();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Your Friends',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Nasa",
                              ),
                            ),
                          ),
                          people.isEmpty
                              ? Column(
                                  children: [
                                    Text(
                                      'No friends available',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      'Add more friends in the home page',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      '"Create Team" Section',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    
                                  ],
                                )
                              : Column(
                                  children: [
                                    Text('Tap on them to add to your team'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Wrap(
                                      alignment: WrapAlignment.center,
                                      runAlignment: WrapAlignment.center,
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: people.map((person) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              teamMembers.add({'firstName': person['firstName'], 'lastName': person['lastName'] ,'username': person['username'], '_id':person['_id']});
                                              teamMembersList.add(person['_id']);
                                              people.remove(person);
                                            });
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                  color: widget.colorDown,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  person['firstName']
                                                          ?.toString() ??
                                                      '',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontFamily: "Nasa",
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 4.0),
                                              Text(
                                                '@${person['username']?.toString().toLowerCase() ?? ''}',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[300],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),

                // Your Team Section
// In the "Your Team" section, filter out the current user before displaying the team members
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Text(
                              'Your Team',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Nasa",
                              ),
                            ),
                            SizedBox(height: 10),
                            teamMembers.where((member) {
                              // Filter out the user themselves based on their username
                              return member['username'] !=
                                  context.read<UserProvider>().user?.username;
                            }).isEmpty
                                ? Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          'No team members selected',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        Text(
                                          'Select from above',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Column(
                                  children: [

                                    Text(
                                          'Tap to remove from team',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white70,
                                          ),
                                        ),

                                    SizedBox(height: 10,),
                                    
                                    Wrap(
                                        alignment: WrapAlignment.center,
                                        runAlignment: WrapAlignment.center,
                                        spacing: 8.0,
                                        runSpacing: 8.0,
                                        children: teamMembers.where((member) {
                                          return member['username'] !=
                                              context
                                                  .read<UserProvider>()
                                                  .user
                                                  ?.username;
                                        }).map((member) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                people.add(member);
                                                teamMembers.remove(member);
                                                teamMembersList.remove(member["_id"]);
                                              });
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color: widget.colorDown,
                                                    borderRadius:
                                                        BorderRadius.circular(12),
                                                  ),
                                                  child: Text(
                                                    member['firstName']
                                                            ?.toString() ??
                                                        '',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontFamily: "Nasa",
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 4.0),
                                                Text(
                                                  '@${member['username']?.toString().toLowerCase() ?? ''}',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[300],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                  ],
                                ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Team Leader Selection
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Text(
                              'Select Your Leader',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Nasa",
                              ),
                            ),
                            SizedBox(height: 10),

                            // Existing team members section
                            teamMembers.isEmpty
                                ? Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          'No team members selected',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        Text(
                                          'Select from above',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Wrap(
                                    alignment: WrapAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children: teamMembers.map((member) {
                                      final isSelected = teamLeader['username'] ==
                                          member['username']?.toString();
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            teamLeader = {'firstName': member['firstName'], 'lastName':member['lastName'] ,'username': member['username'], '_id':member['_id'] };
                                             // Set the leader
                                          });
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? Color.fromARGB(
                                                        255,
                                                        251,
                                                        165,
                                                        15) // Golden color for leader
                                                    : widget.colorDown,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                member['firstName']
                                                        ?.toString() ??
                                                    '',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontFamily: "Nasa",
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 4.0),
                                            Text(
                                              '@${member['username']?.toString().toLowerCase() ?? ''}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: isSelected
                                                    ? Colors.amber[200]
                                                    : Colors.grey[300],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),

// Proceed Button
                ElevatedButton(
                  onPressed: () {
                    if (teamName == null || teamName!.isEmpty) {
                      _showIncompleteDialog('Please enter a team name.');
                    } else if (teamLeader.isEmpty) {
                      _showIncompleteDialog('Please select a team leader.');
                    } else if (teamMembers.isEmpty) {
                      _showIncompleteDialog('Please add members to your team.');
                    } else if (teamMembers.length < widget.MinMembers) {
                      _showIncompleteDialog(
                          'Your team must have at least ${widget.MinMembers} members.');
                    } else if (teamMembers.length > widget.MaxMembers) {
                      _showIncompleteDialog(
                          'Your team cannot have more than ${widget.MaxMembers} members.');
                    } else {
                      // Navigate to the VerifyDetailsPage with event data and team information
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerifyDetailsPage(
                            eventDetails: widget.eventData,
                            teamName: teamName!,
                            teamLeader: teamLeader,
                            teamMembers: teamMembersList,
                            eventType: widget.eventData['eventType'],
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: widget.colorUp,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text(
                      'Proceed',
                      style: TextStyle(fontSize: 15, fontFamily: "Nasa"),
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
