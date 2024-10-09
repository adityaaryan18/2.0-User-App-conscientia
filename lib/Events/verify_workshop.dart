import 'dart:convert';
import 'package:app/Landing/update_user.dart';
import 'package:http/http.dart' as http;
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class VerifyWorkshopDetailsPage extends StatefulWidget {
  final List teamMembers;
  final teamLeader;
  final teamName;
  final Map eventDetails;
  final String eventType;

  const VerifyWorkshopDetailsPage({
    super.key,
    required this.teamMembers,
    required this.teamLeader,
    required this.teamName,
    required this.eventDetails,
    required this.eventType,
  });

  @override
  _VerifyWorkshopDetailsPageState createState() => _VerifyWorkshopDetailsPageState();
}

class _VerifyWorkshopDetailsPageState extends State<VerifyWorkshopDetailsPage> {
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
   

    // Close the loading dialog in case of failure
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment failed: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet selection here

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

    // Verify Registration Before Payment
    bool proceed = await _verifyRegistration();
    if (!proceed) return;

    // Proceed to initiate payment as usual if registration is not complete

    // Show loading dialog immediately when payment is initiated
    _showLoadingDialog();

    final requestBody = {
      'amount':
          (widget.eventDetails['workshopFee'] * 1.03 * 100).toInt(),
      'receipt': 'WORKSHOP_${DateTime.now().millisecondsSinceEpoch}',
      'user': {'_id': user?.id},
      'items': [widget.eventDetails],
      'category': 'WORKSHOP_REGISTRATION'
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
          'amount': (widget.eventDetails['workshopFee'] * 1.03 * 100)
              .toInt(),
          'name': widget.eventDetails['workshopName'],
          'description': 'workshop Registration Fee',
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

  Future<bool> _verifyRegistration() async {
    final requestBody = {
      'eventId': widget.eventDetails['_id'],
      'members': widget.teamMembers,
      'referral':
          _referralController.text.isNotEmpty ? _referralController.text : '',
    };

    try {

      final res = await http.post(
        Uri.parse(
            'https://conscientia.co.in/api/workshops/verifyRegistration'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

  
      if (res.statusCode == 200) {
        final responseData = jsonDecode(res.body);
        if (responseData['isRegistered'] == true) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Some of the team members are already registered")),
          );
          return false;
        }
      } else if (res.statusCode == 404) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Referral code does not exist.")),
        );
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error verifying registration: $e")),
      );
      return false;
    }

    return true;
  }

  Future<void>_sendPaymentDataToBackend(PaymentSuccessResponse response) async {

         

    final requestBody = {
      'pid': response.paymentId,
      'oid': response.orderId,
      'signature': response.signature,
      'tname': widget.teamName,
      'workshopId': widget.eventDetails['_id'],
      'ptype': widget.eventType,
      'members': widget.teamMembers,
      'leaderId': widget.teamLeader['_id'],
      'referral':
          _referralController.text.isNotEmpty ? _referralController.text : ''
    };

    try {
 
      final res = await http.post(
        Uri.parse(
            'https://conscientia.co.in/api/workshops/registerWorkshop'),
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
              content: Text('Payment successful and workshop registered'),
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
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    int registrationFee = widget.eventDetails['workshopFee'] ?? 0;
    double convenienceFee = registrationFee * 0.03;
    double totalFee = registrationFee + convenienceFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Check Details',
          style: TextStyle(fontFamily: 'Nasa', fontSize: 18),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 100),
            Center(
              child: Text(
                "You are about to make the payment",
                style: GoogleFonts.rubik(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                "Please Check Your Details",
                style: GoogleFonts.rubik(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _referralController,
              decoration: InputDecoration(
                labelText: "Add a referral code (Optional)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Your Details'),
            _buildDetailBox([
              _buildDetailRow(
                'Your Name',
                Text(
                  '${user?.firstName} ${user?.lastName}',
                  style: GoogleFonts.rubik(color: Colors.white, fontSize: 15),
                ),
              ),
              _buildDetailRow(
                'User Name',
                Text(
                  '@${user?.username}',
                  style: GoogleFonts.rubik(color: Colors.white, fontSize: 15),
                ),
              ),
              _buildDetailRow(
                'E-mail',
                Text(
                  user?.email ?? '',
                  style: GoogleFonts.rubik(color: Colors.white, fontSize: 15),
                ),
              ),
              _buildDetailRow(
                'Mobile No',
                Text(
                  user?.mobile.toString() ?? '',
                  style: GoogleFonts.rubik(color: Colors.white, fontSize: 15),
                ),
              ),
              _buildDetailRow(
                'College',
                Text(
                  user?.college.toString() ?? '',
                  style: GoogleFonts.rubik(color: Colors.white, fontSize: 15),
                ),
              ),
              _buildDetailRow(
                'College ID',
                Text(
                  user?.collegeId.toString() ?? '',
                  style: GoogleFonts.rubik(color: Colors.white, fontSize: 15),
                ),
              ),
              _buildDetailRow(
                'Aadhaar Number',
                Text(
                  '${user?.aadhar}',
                  style: GoogleFonts.rubik(color: Colors.white, fontSize: 15),
                ),
              ),
            ]),
            const SizedBox(height: 20),
            if (widget.eventType == 'team') ...[
              _buildSectionTitle('Team Details'),
              _buildDetailBox([
                _buildDetailRow(
                  'Team Name',
                  Text(
                    widget.teamName.toUpperCase(),
                    style: GoogleFonts.rubik(color: Colors.white, fontSize: 15),
                  ),
                ),
                _buildDetailRow(
                  'Team Members',
                  _buildTeamMembersList(widget.teamMembers),
                ),
                _buildDetailRow(
                  'Team Leader',
                  Text(
                    '${widget.teamLeader['firstName']} ${widget.teamLeader['lastName']}',
                    style: GoogleFonts.rubik(color: Colors.white, fontSize: 15),
                  ),
                ),
              ]),
            ],
            const SizedBox(height: 20),
            _buildSectionTitle('Payment Details'),
            _buildDetailBox([
              _buildDetailRow(
                'Workshop Name',
                Text(
                  widget.eventDetails['workshopName'] ?? '',
                  style: GoogleFonts.rubik(color: Colors.white, fontSize: 15),
                ),
              ),
              _buildDetailRow(
                'Number of Participants',
                Text(
                  widget.eventType == 'team'
                      ? '${widget.teamMembers.length}'
                      : '1',
                  style: GoogleFonts.rubik(color: Colors.white, fontSize: 15),
                ),
              ),
              _buildDetailRow(
                'Total Fee',
                Text(
                  '₹$totalFee',
                  style: GoogleFonts.rubik(color: Colors.white, fontSize: 15),
                ),
              ),
            ]),
            const SizedBox(height: 40),
            _buildProceedButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Center(
      child: Text(
        title,
        style: GoogleFonts.rubik(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDetailBox(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(children: children),
    );
  }

  Widget _buildDetailRow(String label, Widget valueWidget) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '$label:  ',
              style: GoogleFonts.rubik(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: valueWidget, // Use the widget directly here
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMembersList(List members) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: members.map((member) {
            return Text(
              'Check previous page for members details',
              style: GoogleFonts.rubik(
                color: Colors.white,
                fontSize: 15,
              ),
            );
          }).toList(),
        ),
      ],
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
