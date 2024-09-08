
import 'package:flutter/material.dart';

class MyMerch extends StatefulWidget {
  const MyMerch({super.key});

  @override
  State<MyMerch> createState() => _MyMerchState();
}

class _MyMerchState extends State<MyMerch> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double locationFontSize =
        screenWidth * 0.03 > 13 ? 13 : screenWidth * 0.035;

    // Dummy merch list
    final List<Map<String, dynamic>> merch = [
      {
        'name': 'Astral T-Shirt',
        'price': '\$25',
        'paymentId': 'PAY-201',
        'description': 'A cool t-shirt featuring the Astral Armageddon logo.',
        'image': 'assets/images/tshirt.png',
      },
      {
        'name': 'Space Mug',
        'price': '\$15',
        'paymentId': 'PAY-202',
        'description': 'A ceramic mug with the space theme.',
        'image': 'assets/images/tshirt.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            "My Merch",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ...merch.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
            child: Card(
              color: const Color.fromARGB(68, 0, 0, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Color.fromARGB(139, 158, 158, 158)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    // Left side
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 53, 53, 53)
                              .withOpacity(0.4),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                item['name']!,
                                style: const TextStyle(
                                  fontFamily: 'Nasa',
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Payment ID: ${item['paymentId']}",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 33, 33),
                                  fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Price: ${item['price']}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Description: ${item['description']}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Right side (Image)
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Image.asset(item['image']),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}