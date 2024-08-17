import 'package:app/Events/colors.dart';
import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  final Color colorMinor, colorDown;
  final String bulletPoints;

  const RulesPage({
    super.key,
    required this.colorMinor,
    required this.colorDown,
    required this.bulletPoints,
  });

  @override
  Widget build(BuildContext context) {
    List<String> bulletList =
        bulletPoints.split('\n').map((point) => point.trim()).toList();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorDown,
            cardrules,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0, 1],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.book,
                          color: Colors.white,
                          size: 70,
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          height: 65,
                          width: 100,
                          child: Stack(
                            children: [
                              Text(
                                "Rule",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontFamily: "Nasa",
                                ),
                              ),
                              Positioned(
                                top: 30,
                                child: Text(
                                  "Book",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: "Nasa",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: bulletList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              textAlign: TextAlign.justify,
                              "❍◦ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - ◦❍",
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    offset: Offset(0, 2),
                                    blurRadius: 10,
                                  ),
                                ],
                                fontSize: 14,
                                fontFamily: "Rosario",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 6),
                            child: Text(
                              textAlign: TextAlign.justify,
                              bulletList[index],
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: "Rosario",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
