import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    return SingleChildScrollView(
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
                      color:
                          const Color.fromARGB(255, 200, 45, 66).withOpacity(1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: SizedBox(
                        height: constraints.maxWidth < 400 ? 210 : 210,
                        width: double.infinity,
                      ),
                    ),
                    Card(
                      color:
                          const Color.fromARGB(255, 200, 45, 66).withOpacity(1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          SizedBox(
                            width:
                                constraints.maxWidth * 0.22, // Responsive width
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
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/helmet.png'),
                                    ),
                                    height:
                                        constraints.maxWidth < 400 ? 110 : 130,
                                    width:
                                        constraints.maxWidth < 400 ? 110 : 130,
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
                                          'SOLDIER',
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
    );
  }
}