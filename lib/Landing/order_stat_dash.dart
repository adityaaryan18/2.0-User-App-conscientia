import 'package:app/Landing/update_user.dart';
import 'package:app/Merch/merch_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderList extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      "orderNumber": "1234",
      "restaurantName": "Pizza Place",
      "status": "accepted",
      "items": [
        {"name": "Pizza", "quantity": 1},
      ],
    },
    {
      "orderNumber": "1235",
      "restaurantName": "Burger Joint",
      "status": "preparing",
      "items": [
        {"name": "Burger", "quantity": 2},
      ],
    },
    {
      "orderNumber": "1236",
      "restaurantName": "Sushi Spot",
      "status": "rejected",
      "items": [
        {"name": "Sushi Roll", "quantity": 3},
        {"name": "Sandwich", "quantity": 2},
        {"name": "Sandwich", "quantity": 2},
        {"name": "Sandwich", "quantity": 2},
      ],
    },
    {
      "orderNumber": "1237",
      "restaurantName": "Taco House",
      "status": "prepared",
      "items": [
        {"name": "Taco", "quantity": 4},
      ],
    },
    {
      "orderNumber": "1238",
      "restaurantName": "Sandwich Shop",
      "status": "rejected",
      "items": [
        {"name": "Sandwich", "quantity": 2},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter orders to only show 'preparing' and 'rejected' statuses
    final filteredOrders = orders.where((order) {
      return order['status'] == 'preparing' ||
          order['status'] == 'rejected' ||
          order['status'] == 'prepared';
    }).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600
            ? 3
            : 2, // Adjust columns based on screen width
        childAspectRatio: 1.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        return GestureDetector(
          onTap: () {
            // Navigate to the order details page (replace with your navigation logic)

            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => UserProfilePage(),
                  fullscreenDialog: true),
            );
          },
          child: OrderCard(order: order),
        );
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (order['status']) {
      case 'preparing':
        statusColor = Colors.yellow;
        break;
      case 'rejected':
        statusColor = Colors.red;
        break;
      case 'prepared':
        statusColor = Colors.green;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: statusColor.withOpacity(0.12),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/restaurant_icon.png'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display the first item
                      Text(
                        '${order['items'][0]['name']} x${order['items'][0]['quantity']}',
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(221, 255, 255, 255),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      // If more than one item, show "....more"
                      if (order['items'].length > 1)
                        Text(
                          '....more',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(221, 255, 255, 255),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.center,
              child: Text(
                order['status'].toUpperCase(),
                style: GoogleFonts.rubik(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
