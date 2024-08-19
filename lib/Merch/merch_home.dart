import 'package:app/Merch/merch_product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MerchandiseScreen extends StatefulWidget {
  @override
  State<MerchandiseScreen> createState() => _MerchandiseScreenState();
}

class _MerchandiseScreenState extends State<MerchandiseScreen> {
  final List<Map<String, String>> products = [
    {
      'name': 'ZoomX Invincible',
      'price': '180',
      'image': 'assets/images/tshirt.png',
      'description':
          'High-performance running shoes with advanced cushioning for ultimate comfort.',
    },
    {
      'name': 'Air Max 90',
      'price': '120',
      'image': 'assets/images/tshirt.png',
      'description':
          'Classic sneaker with iconic design and excellent durability.',
    },
    {
      'name': 'Cosmic Unity',
      'price': '150',
      'image': 'assets/images/tshirt.png',
      'description':
          'Eco-friendly basketball shoes built for performance and style.',
    },
    {
      'name': 'React Infinity',
      'price': '160',
      'image': 'assets/images/tshirt.png',
      'description':
          'Running shoes designed to reduce injuries and provide a smooth ride.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/merch_backgroun.jpg',
          fit: BoxFit.fill,
          color: Colors.black.withOpacity(0.8),
          colorBlendMode: BlendMode.darken,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Center(
              child: Text(
                'MERCHANDISE',
                style: GoogleFonts.teko(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.065,
                  color: Colors.white,
                ),
              ),
            ),
            backgroundColor: Colors.black.withOpacity(0.6),
            elevation: 0,
          ),
          body: Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Add action for the "Your Orders" card tap
                  },
                  child: Container(
                    padding: EdgeInsets.all(size.width * 0.03),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 188, 232, 90)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        'YOUR ORDERS',
                        style: GoogleFonts.rubik(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.only(top: 60),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: size.width > 600 ? 3 : 2,
                      crossAxisSpacing: size.width * 0.05,
                      mainAxisSpacing: size.height * 0.03,
                      childAspectRatio: size.width > 600 ? 0.8 : 0.7,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => ProductDetailScreen(
                                name: product['name']!,
                                price: product['price']!,
                                image: product['image']!,
                                description: product['description']!,
                              ),
                            ),
                          );
                        },
                        child: ProductCard(
                          name: product['name']!,
                          price: product['price']!,
                          image: product['image']!,
                          size: size,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final Size size;

  ProductCard({
    required this.name,
    required this.price,
    required this.image,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: size.height * 0.16,
          width: size.width * 0.378,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.white.withOpacity(0.05),
                Colors.white.withOpacity(0.3),
              ],
              center: Alignment.center,
              radius: 1,
            ),
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -size.height * 0.05,
                left: 0,
                child: Image.asset(
                  image,
                  height: size.height * 0.2,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                bottom: size.height * 0.01,
                right: size.width * 0.02,
                child: Card(
                  color: const Color.fromARGB(200, 188, 232, 90),
                  elevation: 0,
                  child: Icon(
                    Icons.add,
                    color: Colors.white.withOpacity(0.8),
                    size: size.width * 0.07,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width * 0.04,
          ),
        ),
        Text(
          '\$$price',
          style: GoogleFonts.teko(
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 188, 232, 90).withOpacity(0.8),
            fontSize: size.width * 0.05,
          ),
        ),
      ],
    );
  }
}
