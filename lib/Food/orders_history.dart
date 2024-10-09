import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class OrdersHistory extends StatefulWidget {
  @override
  _OrdersHistoryState createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {

  bool showInProgress = true;

    Widget _buildShimmerCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[700]!,
        highlightColor: Colors.grey[500]!,
        child: Card(
          color: Colors.grey[850],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[850],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    // If user is null, show shimmer loading cards
    if (user == null) {
      return Column(
        children: List.generate(
            3, (index) => _buildShimmerCard()), // Shimmer loading for 3 cards
      );
    }

    List<dynamic> orders = user.foodOrders;

    // If no registered events, show a message
    if (orders.isEmpty) {
      return const Center(
        child: Text(
          "You don't have any food Orders",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    // Filter orders with status 'delivered'
    final deliveredOrders =
        orders.where((order) => order['status'] == 'delivered').toList();

    // If no delivered orders, show a message
    if (deliveredOrders.isEmpty) {
      return const Center(
        child: Text(
          "No delivered orders yet",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

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
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    centerTitle: true,
                    title: Text(
                      "DELIVERED ORDERS",
                      style: GoogleFonts.rubik(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: OrderList(
                      orders: deliveredOrders,
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
  final List orders;

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
      case 'preparing':
        return Colors.yellow.shade700;
      case 'ready':
        return Colors.green.shade700;
      case 'rejected':
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
                    order['orderno'] as String,
                    style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${order['seller']['storeName']}',
                    style: GoogleFonts.rubik(color: const Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                'Convenience Fee: ₹${(order['amount']*0.03).toStringAsFixed(2)}',
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
                      ' ₹ ${(item['quantity'] * item['price']).toStringAsFixed(2)}',
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
                        'Total Price:  ₹ ${order['amountPaid'].toStringAsFixed(2)}',
                        style: GoogleFonts.rubik(
                          fontSize: 15,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (status == 'ready')
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
                            'OTP: ${order['deliveryOTP']}',
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
              if (status == 'rejected')
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
              if (status == 'preparing')
                Card(
                  color: _getStatusColor(status).withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Your Order is preparing! \nOTP will be generated when it is ready",
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
