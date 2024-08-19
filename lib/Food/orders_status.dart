import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final List<Map<String, dynamic>> orders = [
    {
      "orderNumber": "1234",
      "restaurantName": "Pizza Place",
      "restaurantLogo": "assets/pizza.png",
      "status": "Ready",
      "items": [
        {"name": "Pizza", "quantity": 1, "price": 12.0}
      ],
      "convenienceFee": 2.0,
      "totalPrice": 14.0,
      "otp": "567889"
    },
    {
      "orderNumber": "1235",
      "restaurantName": "Burger Joint",
      "restaurantLogo": "assets/burger.png",
      "status": "Preparing",
      "items": [
        {"name": "Burger", "quantity": 2, "price": 5.0}
      ],
      "convenienceFee": 1.0,
      "totalPrice": 11.0,
      "otp": ""
    },
    {
      "orderNumber": "1236",
      "restaurantName": "Sushi Spot",
      "restaurantLogo": "assets/sushi.png",
      "status": "Preparing",
      "items": [
        {"name": "Sushi Roll", "quantity": 3, "price": 7.0}
      ],
      "convenienceFee": 3.0,
      "totalPrice": 24.0,
      "otp": ""
    },
    {
      "orderNumber": "1237",
      "restaurantName": "Taco House",
      "restaurantLogo": "assets/taco.png",
      "status": "Rejected",
      "items": [
        {"name": "Taco", "quantity": 4, "price": 3.0}
      ],
      "convenienceFee": 2.0,
      "totalPrice": 14.0,
      "otp": ""
    },
  ];

  bool showInProgress = true;

  @override
  Widget build(BuildContext context) {
    final inProgressOrders =
        orders.where((order) => order['status'] != 'Rejected').toList();
    final rejectedOrders =
        orders.where((order) => order['status'] == 'Rejected').toList();

    // Sort in-progress orders by status (Ready orders on top)
    inProgressOrders.sort((a, b) {
      if (a['status'] == 'Ready' && b['status'] != 'Ready') return -1;
      if (a['status'] != 'Ready' && b['status'] == 'Ready') return 1;
      return 0;
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/foody.jpg', // Ensure this path matches your actual image asset path
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.85),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "ORDER STATUS",
                      style: GoogleFonts.rubik(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showInProgress = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  showInProgress ? Colors.blue : Colors.grey,
                            ),
                            child: Text('In Progress', style: GoogleFonts.rubik(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showInProgress = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              showInProgress ? Colors.grey : Colors.red,
                        ),
                        child: Text('Rejected', style: GoogleFonts.rubik(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: OrderList(
                      orders:
                          showInProgress ? inProgressOrders : rejectedOrders,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  OrderList({required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCard(order: order);
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  OrderCard({required this.order});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Preparing':
        return Colors.yellow.shade700;
      case 'Ready':
        return Colors.green.shade700;
      case 'Rejected':
        return Colors.red.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = order['status'];
    final color = _getStatusColor(status);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.grey.shade300, width: 0.1),
        ),
        color: _getStatusColor(status).withOpacity(0.15),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    order['orderNumber'] as String,
                    style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${order['restaurantName']}',
                    style: GoogleFonts.rubik(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                'Convenience Fee: \$${order['convenienceFee'].toStringAsFixed(2)}',
                style: GoogleFonts.rubik(
                  color: Colors.grey.shade400,
                ),
              ),
              const Divider(color: Colors.grey),
              const SizedBox(height: 8.0),
              ...order['items'].map<Widget>((item) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item['name']} x${item['quantity']}',
                      style:
                          GoogleFonts.rubik(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      '\$${(item['quantity'] * item['price']).toStringAsFixed(2)}',
                      style:
                          GoogleFonts.rubik(fontSize: 16, color: Colors.white),
                    ),
                  ],
                );
              }).toList(),
              const SizedBox(height: 8.0),
              const Divider(color: Colors.grey),
              Row(
                children: [
                  SizedBox(
                    height: 30,
                    child: Card(
                      color: color.withOpacity(0.7),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Center(
                          child: Text(
                            order['status'].toString().toUpperCase(),
                            style: GoogleFonts.rubik(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Total Price: \$${order['totalPrice'].toStringAsFixed(2)}',
                        style: GoogleFonts.rubik(
                          fontSize: 15,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (status == 'Ready')
                Card(
                  color: _getStatusColor(status).withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            "Give this OTP to Seller to claim your Order \n",
                            style: GoogleFonts.rubik(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          Text(
                            'OTP: ${order['otp']}',
                            style: GoogleFonts.rubik(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (status == 'Rejected')
                Card(
                  color: _getStatusColor(status).withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Dont worry! Your money will be refunded within 4 days",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                ),
              if (status == 'Preparing')
                Card(
                  color: _getStatusColor(status).withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Your Order is preparing! \nOTP will be generated When it is ready",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
