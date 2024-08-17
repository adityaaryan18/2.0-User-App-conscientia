import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}


class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle selection of the "Good" side
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/images/goodsi.jpg',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          color: Colors.blue.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(width: 5,),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle selection of the "Evil" side
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/images/darksi.jpg',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          color: Colors.red.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Spacer(),
                  Image.asset(
                    'assets/images/logo.png',
                    width: 200, // Adjust size as needed
                    height: 200, // Adjust size as needed
                  ),
                  Text(
                    "Choose Your Side",
                    style: TextStyle(
                      fontFamily: 'Nasa',
                      color: Colors.white,
                  
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle selection of the "Good" side
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 90.0, right: 8),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          child: Card(
                            color: Color.fromARGB(136, 33, 149, 243),
                            elevation: 15,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FittedBox(
                                child: Text(
                                  'THE DEFENDERS',
                                  style: TextStyle(
                                    fontFamily: 'Nasa',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle selection of the "Evil" side
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 90.0, right: 8),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          child: Card(
                            color: Color.fromARGB(109, 243, 33, 33),
                            elevation: 15,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FittedBox(
                                child: Text(
                                  'THE DARK SIDE',
                                  style: TextStyle(
                                    fontFamily: 'Nasa',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
