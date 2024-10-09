import 'dart:convert';
import 'package:app/Landing/update_user.dart';
import 'package:app/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class VerifyFoodDetailsPage extends StatefulWidget {
  final List<Map<String, dynamic>> foodItems;
  final totalPrice;

  VerifyFoodDetailsPage({required this.foodItems, required this.totalPrice});

  @override
  State<VerifyFoodDetailsPage> createState() => _VerifyFoodDetailsPageState();
}

class _VerifyFoodDetailsPageState extends State<VerifyFoodDetailsPage> {
  late Razorpay _razorpay;
  final TextEditingController _referralController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Clear all event listeners
    _referralController.dispose(); // Dispose of the controller
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Payment success, keep the loading dialog visible until backend processing is complete


    await _sendPaymentDataToBackend(response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.code} - ${response.message}");

    // Close the loading dialog in case of failure
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment failed: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet selection here
    print("External Wallet: ${response.walletName}");
  }

  void _showIncompleteDetailsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Incomplete Details"),
          content: Text("Please complete your details."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => UserProfilePage(),
                      fullscreenDialog: true),
                ); // Navigate to the page
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _initiatePayment() async {
    final userProvider = context.read<UserProvider>();
    final user = userProvider.user;

    // Check if any user details are missing
    if (user?.firstName == null ||
        user?.lastName == null ||
        user?.aadhar == null ||
        user?.college == null ||
        user?.collegeId == null ||
        user?.mobile == null) {
      _showIncompleteDetailsDialog();
      return; // Stop further execution if details are incomplete
    }

    // Show loading dialog immediately when payment is initiated
    _showLoadingDialog();

    final requestBody = {
      'amount': (widget.totalPrice * 1.03 * 100).toInt(),
      'receipt': 'FOOD_${DateTime.now().millisecondsSinceEpoch}',
      'user': {'_id': user?.id},
      'items': [widget.foodItems],
      'category': 'Food'
    };

    try {
      final response = await http.post(
        Uri.parse(
            'https://conscientia.co.in/api/payments/initPayment'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final orderId = responseData['id'];

        if (orderId == null || orderId.isEmpty) {
          throw Exception('Invalid Order ID');
        }


        final options = {
          'key': 'rzp_live_7uMEh9O3WkPNCb',
          'amount': (widget.totalPrice * 1.03 * 100).toInt(),
          'name': user?.firstName.toString(),
          'description': 'Food Price',
          'order_id': orderId,
          'prefill': {
            'contact': user?.mobile.toString(),
            'email': user?.email ?? 'YOUR_EMAIL',
          },
          'external': {
            'wallets': ['paytm'],
          },
        };

        _razorpay.open(options);
      } else {
        final errorMessage = jsonDecode(response.body)['message'];
        throw Exception(errorMessage);
      } 
    } catch (e) {
      print("Exception: $e");
      // Close the loading dialog in case of error
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception occurred: $e")),
      );
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Please don't close the app"),
            ],
          ),
        );
      },
    );
  }

  Future<void> _sendPaymentDataToBackend(
      PaymentSuccessResponse response) async {
    final userProvider = context.read<UserProvider>();
    final user = userProvider.user;


    final requestBody = {
      'pid': response.paymentId,
      'oid': response.orderId,
      'signature': response.signature,
      'amountPaid': widget.totalPrice * 1.03,
      'items': widget.foodItems,
      'user': {'_id': user?.id, 'conscientiaPoints': user?.conscientiaPoints},
      'time': DateTime.now().millisecondsSinceEpoch
    };

    try {
      final res = await http.post(
        Uri.parse(
            'https://conscientia.co.in/api/foodstore/saveOrder'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (res.statusCode == 200) {
        // Close the loading dialog here, after the registration is successful
        Navigator.of(context).pop();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Payment successful: Your Food order has been placed'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context).popUntil(
                        (route) => route.isFirst); // Pop to the first route
                  },
                  child: Text('Okay'),
                ),
              ],
            );
          },
        );
      } else {
        final errorMessage = jsonDecode(res.body)['message'];
        throw Exception(errorMessage);
      }
    } catch (e) {
      print("Exception: $e");
      // Close the loading dialog in case of error
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error during registration: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double convenienceFee = widget.totalPrice * 0.03;
    double totalPriceWithFee = widget.totalPrice + convenienceFee;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/foody.jpg', // Ensure this path matches your actual image asset path
              fit: BoxFit.cover,
            ),
            Scaffold(
              backgroundColor: Colors.black.withOpacity(0.7),
              body: Column(
                children: [
                  Text(
                    'Verify Food Details',
                    style: TextStyle(
                        color: Colors.white, fontSize: 17, fontFamily: 'Nasa'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.foodItems.length,
                            itemBuilder: (context, index) {
                              final item = widget.foodItems[index];
                              return Card(
                                color: Colors.grey.shade900.withOpacity(0.9),
                                margin: EdgeInsets.all(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name: ${item['name']}',
                                        style: GoogleFonts.rubik(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Price: ₹${item['price']}',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        'Quantity: ${item['quantity']}',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        'Type: ${item['isVeg'] != null && item['isVeg'] ? 'Veg' : 'Non-Veg'}',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Pricing details
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900.withOpacity(0.8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price: ₹${widget.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Convenience Fee and Taxes: ₹${convenienceFee.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Total Price: ₹${totalPriceWithFee.toStringAsFixed(2)}',
                          style: GoogleFonts.rubik(
                              color: Colors.greenAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10,),
                        _buildProceedButton(),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  // Pay button
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProceedButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _initiatePayment,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.green,
          shadowColor: Colors.black,
          elevation: 10,
        ),
        child: Text(
          'Pay',
          style: GoogleFonts.rubik(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
