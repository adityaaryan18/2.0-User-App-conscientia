
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Comingsoon extends StatelessWidget {
  Comingsoon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/teams background.png',
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.black
                .withOpacity(0.3), // Make Scaffold background transparent
            body: Center(child: Text("This Feature is Coming Soon", style: GoogleFonts.rubik(fontWeight: FontWeight.bold),)),
          )
        ],
      ),
    );
  }
}