import 'package:app/Merch/merch_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MerchWidget extends StatefulWidget {
  const MerchWidget({super.key});

  @override
  _MerchWidgetState createState() => _MerchWidgetState();
}

class _MerchWidgetState extends State<MerchWidget> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;

  final List<Map<String, String>> merchItems = [
    {
      'name': 'ZoomX Invincible',
      'price': '180',
      'image': 'assets/images/tshirt.png',
      'description': 'High-performance running shoes with advanced cushioning for ultimate comfort.',
    },
    {
      'name': 'Air Max 90',
      'price': '120',
      'image': 'assets/images/tshirt.png',
      'description': 'Classic sneaker with iconic design and excellent durability.',
    },
    {
      'name': 'Cosmic Unity',
      'price': '150',
      'image': 'assets/images/tshirt.png',
      'description': 'Eco-friendly basketball shoes built for performance and style.',
    },
    {
      'name': 'React Infinity',
      'price': '160',
      'image': 'assets/images/tshirt.png',
      'description': 'Running shoes designed to reduce injuries and provide a smooth ride.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Center(
            child:  Text(
              "SUIT UP! WARRIOR",
              style: GoogleFonts.rubik(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 200,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.2,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: merchItems.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          final item = merchItems[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MerchandiseScreen(),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  item['image']!,
                                  height: 140,
                                  width: 140,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  item['name']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
