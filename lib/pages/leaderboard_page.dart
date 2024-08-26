import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage();

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final leaderboardRankImages = [
    "https://firebasestorage.googleapis.com/v0/b/consx-user-app.appspot.com/o/rank1.png?alt=media&token=f2aed88c-c567-46a2-b423-9cb8bf24bf6d",
    "https://firebasestorage.googleapis.com/v0/b/consx-user-app.appspot.com/o/rank2.png?alt=media&token=1938c13d-5fa0-4822-b7c8-92930916570f",
    "https://firebasestorage.googleapis.com/v0/b/consx-user-app.appspot.com/o/rank3.png?alt=media&token=1d7d25da-f706-4a1e-a866-9f915fc9fdd9",
    "https://firebasestorage.googleapis.com/v0/b/consx-user-app.appspot.com/o/rank4.png?alt=media&token=fc076109-cfe2-4b6d-a664-61492fd88160",
    "https://firebasestorage.googleapis.com/v0/b/consx-user-app.appspot.com/o/rank5.png?alt=media&token=0c97e190-8369-4f22-a1d3-23fe299e9ae4",
    "https://firebasestorage.googleapis.com/v0/b/consx-user-app.appspot.com/o/rank6.png?alt=media&token=34101ea7-bafa-447b-aeec-965ee586592f",
    "https://firebasestorage.googleapis.com/v0/b/consx-user-app.appspot.com/o/rank7.png?alt=media&token=e69601cb-35aa-4d61-9eb4-50670f6160b9",
    "https://firebasestorage.googleapis.com/v0/b/consx-user-app.appspot.com/o/rank8.png?alt=media&token=3e8c7abc-1324-4c7d-b20d-704b0db065d0",
    "https://firebasestorage.googleapis.com/v0/b/consx-user-app.appspot.com/o/rank9.png?alt=media&token=5ec75bbc-b758-4438-b856-a4055ebb0a63",
    "https://firebasestorage.googleapis.com/v0/b/consx-user-app.appspot.com/o/rank10.png?alt=media&token=7cd1c7c3-974c-4c05-aa48-8bc469574815",
  ];

  List<Map<String, dynamic>> leaderboardData = [];

  IO.Socket? socket;

  @override
  void initState() {
    super.initState();
    initializeSocket();
  }

  void initializeSocket([String? uid]) {
    socket = IO.io(
        'https://socketserver-conscientia2k24-o343q.ondigitalocean.app/',
        <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        });

    socket?.connect();

    socket?.onConnect((_) {
      print('Connected to socket');
      if (uid != null) {
        socket?.emit('join', uid);
      }
    });

    socket?.on('leaderboard', (data) {
      print("Data received using socket:");
      print(data);
      setState(() {
        leaderboardData = List<Map<String, dynamic>>.from(data);
      });
    });

    socket?.onDisconnect((_) {
      print('Disconnected from socket');
    });

    socket?.onError((error) {
      print('Socket error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      body: Stack(
        children: [
          // Background Image with Opacity
          Image.asset(
            "assets/images/BG.jpg",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.92),
          ),
          // Content
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                centerTitle: true,
                backgroundColor: Colors.transparent, // Make app bar transparent
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    "GALACTIC HIERARCHY",
                    style: TextStyle(
                      fontFamily: "Nasa",
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: leaderboardData.isNotEmpty
                    ? Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // First column with sized box and Admiral details
                            if (leaderboardData.length > 1)
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1),
                                    buildAvatarColumn(
                                      leaderboardRankImages[1],
                                      'Admiral',
                                      leaderboardData[1]['firstName']
                                          .toString()
                                          .toUpperCase(),
                                      leaderboardData[1]['username'].toString(),
                                      leaderboardData[1]['conscientiaPoints']
                                          .toString(),
                                      const Color.fromARGB(179, 0, 0, 0),
                                    ),
                                  ],
                                ),
                              ),
                            // Second column with First Order details
                            if (leaderboardData.isNotEmpty)
                              Column(
                                children: [
                                  buildAvatarColumn(
                                    leaderboardRankImages[0],
                                    'First Order',
                                    leaderboardData[0]['firstName']
                                        .toString()
                                        .toUpperCase(),
                                    leaderboardData[0]['username'].toString(),
                                    leaderboardData[0]['conscientiaPoints']
                                        .toString(),
                                    const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                              ),
                            // Third column with sized box and General details
                            if (leaderboardData.length > 2)
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1),
                                    buildAvatarColumn(
                                      leaderboardRankImages[2],
                                      'General',
                                      leaderboardData[2]['firstName']
                                          .toString()
                                          .toUpperCase(),
                                      leaderboardData[2]['username'].toString(),
                                      leaderboardData[2]['conscientiaPoints']
                                          .toString(),
                                      const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      )
                    : Column(
                      children: [
                        buildShimmerPlaceholder(),
                        SizedBox(height: 10,),
                        buildShimmerLeaderboardCard(),
                        SizedBox(height: 10,),
                        buildShimmerLeaderboardCard(),
                      
                       
                      ],
                    )
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var e = leaderboardData[index];
                    var img = leaderboardRankImages[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Container(
                        height: 75,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade200.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Avatar Section
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 38,
                                child: Image.network(img ??
                                    'https://example.com/default-avatar.png'),
                              ),
                              SizedBox(width: 10),

                              // Text Section
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Rank
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.indigo.shade900
                                              .withOpacity(0.4),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 4),
                                          child: Text(
                                            e['rankName']?.toString() ??
                                                'Unknown Rank',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Nasa',
                                                fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Name and Username
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              e['firstName']
                                                      ?.toString()
                                                      .toUpperCase() ??
                                                  'UNKNOWN',
                                              style: GoogleFonts.rubik(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          FittedBox(
                                            child: Text(
                                              e['username']?.toString() ??
                                                  'unknown_username',
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 158, 158, 158),
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Points Section
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 6.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                            "assets/images/WA UI (1).png",
                                            width: 20),
                                        SizedBox(width: 5),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            e['conscientiaPoints']
                                                    ?.toString() ??
                                                '0',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 66, 215, 139),
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
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
                        ),
                      ),
                    );
                  },
                  childCount: leaderboardData.length,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to build the avatar columns
  Widget buildAvatarColumn(String imageUrl, String rankName, String name,
      String username, String points, Color bgColor) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 45,
          child: Image.network(imageUrl),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: name != 'null' ? bgColor : Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Text(
              name != 'null' ? rankName : 'Not Recognised',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Nasa', fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Center(
                child: Text(
                  name,
                  style: GoogleFonts.rubik(color: Colors.white, fontSize: 13),
                ),
              ),
            ),
            FittedBox(
              child: Text(
                username,
                style: TextStyle(
                    color: const Color.fromARGB(255, 158, 158, 158),
                    fontSize: 10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  @override
  void dispose() {
    socket?.disconnect();
    socket?.close();
    super.dispose();
  }
}

  // Shimmer Placeholder for Avatar Section
  Widget buildShimmerPlaceholder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(3, (index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade800,
          highlightColor: Colors.grey.shade600,
          child: Column(
            children: [
              SizedBox(height: index%2 == 0? 80:20),
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 45,
              ),
              const SizedBox(height: 10),
              Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: 60,
                height: 15,
                color: Colors.grey.shade800,
              ),
              const SizedBox(height: 5),
              Container(
                width: 50,
                height: 10,
                color: Colors.grey.shade800,
              ),
            ],
          ),
        );
      }),
    );
  }

  // Shimmer Placeholder for Leaderboard Cards
  Widget buildShimmerLeaderboardCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade800,
        highlightColor: Colors.grey.shade600,
        child: Container(
          height: 75,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
