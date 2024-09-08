import 'package:app/Landing/update_user.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserCard extends StatefulWidget {
  const UserCard({super.key});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
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

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    String rankImageUrl = leaderboardRankImages[
        (user?.rank != null && user!.rank > 0)
            ? (user.rank <= 10 ? user.rank - 1 : 9)
            : 9];

    return GestureDetector(
      onTap: () {
        // Navigate to the order details page (replace with your navigation logic)

        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => UserProfilePage(), fullscreenDialog: true),
        );
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // User Card User Interface and APIs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Card(
                        color: const Color.fromARGB(255, 200, 45, 66)
                            .withOpacity(1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: SizedBox(
                          height: constraints.maxWidth < 400 ? 210 : 210,
                          width: double.infinity,
                        ),
                      ),
                      Card(
                        color: const Color.fromARGB(255, 200, 45, 66)
                            .withOpacity(1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: constraints.maxWidth *
                                  0.22, // Responsive width
                            ),
                            Expanded(
                              child: Container(
                                height: constraints.maxWidth < 400 ? 210 : 210,
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                                  color: const Color.fromARGB(255, 13, 30, 46),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/usercard2.jpeg'),
                                    fit: BoxFit.cover,
                                    color:
                                        const Color.fromARGB(255, 118, 118, 118)
                                            .withOpacity(0.4),
                                    colorBlendMode: BlendMode.modulate,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: constraints.maxWidth *
                                    0.43, // Responsive width
                                height: constraints.maxWidth < 400 ? 160 : 190,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    color: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    child: SizedBox(
                                      child: Image.network(
                                        rankImageUrl,
                                      ),
                                      height: constraints.maxWidth < 400
                                          ? 110
                                          : 130,
                                      width: constraints.maxWidth < 400
                                          ? 110
                                          : 130,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(height: 1),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Card(
                                      color: Colors.black.withOpacity(0.2),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Text(
                                            user?.rankName ?? "LOADING",
                                            style: GoogleFonts.rubik(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: FittedBox(
                                    child: Text(
                                      user?.firstName ?? "--",
                                      style: TextStyle(
                                        fontFamily: 'Nasa',
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        ' User ID:  ',
                                        style: GoogleFonts.rubik(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      FittedBox(
                                        child: Center(
                                          child: Text(user?.username ?? " ",
                                              style: GoogleFonts.gruppo()),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        ' Force ID:  ',
                                        style: GoogleFonts.rubik(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      FittedBox(
                                        child: Center(
                                          child: Text(user?.forceId ?? " ",
                                              style: GoogleFonts.gruppo()),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Card(
                                        elevation: 10,
                                        color: Color.fromARGB(255, 183, 51, 41)
                                            .withOpacity(0.7),
                                        child: SizedBox(
                                          height: 25,
                                          child: Row(
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    'assets/images/cp.png'),
                                                fit: BoxFit.contain,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Text(
                                                  user?.conscientiaPoints
                                                          .toString() ??
                                                      " -- ",
                                                  style: GoogleFonts.rubik(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Card(
                                        color: Colors.black.withOpacity(0.2),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Rank: ',
                                                style: GoogleFonts.rubik(
                                                    color: Colors.red),
                                              ),
                                              Text(user?.rank.toString() ??
                                                  " -- "),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
