import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ConfirmationPage extends StatefulWidget {
  final String name;
  final String size;
  final double totalPrice;
  final String imageUrl;
  final int quantity;
 
  ConfirmationPage({
    required this.quantity,
    required this.name,
    required this.size,
    required this.totalPrice,
    required this.imageUrl,
  });

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  late Razorpay _razorpay;

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
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    print('Payment Success: ${response.toString()}');
    // Navigate to success page or show a success message
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment error
    print('Payment Error: ${response.message}');
    // Show error message
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet payment
    print('External Wallet: ${response.walletName}');
  }

  void _startPayment() {
    var options = {
      'key': 'rzp_test_uMjILIOyjNmhGV', // Replace with your Razorpay API key
      'amount': widget.totalPrice * 102, // Amount in paise (so multiply by 100)
      'name': widget.name,
      'description': 'T-shirt Size: ${widget.size}',
      'prefill': {
        'contact': '1234567890', // Replace with actual contact number
        'email': 'email@example.com' // Replace with actual email
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "CONFIRM YOUR DETAILS",
          style: GoogleFonts.teko(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                widget.imageUrl,
                height: size.height * 0.3,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              'Merch Name: ${widget.name}',
              style: GoogleFonts.teko(
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.065,
                color: Colors.white,
              ),
            ),
            Text(
              'Size: ${widget.size}',
              style: GoogleFonts.rubik(
                fontSize: size.width * 0.05,
                color: Colors.white,
              ),
            ),
            Text(widget.quantity.toString()),
            SizedBox(height: size.height * 0.01),
            Text(
              'Total: \$${widget.totalPrice.toStringAsFixed(2)}',
              style: GoogleFonts.teko(
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.05,
                color: const Color.fromARGB(255, 188, 232, 90),
              ),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _startPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 188, 232, 90).withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.1,
                    vertical: size.height * 0.015,
                  ),
                ),
                child: Text(
                  'Proceed',
                  style: GoogleFonts.rubik(
                    fontSize: size.width * 0.045,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}