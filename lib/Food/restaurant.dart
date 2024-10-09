import 'package:app/Food/cart.dart';
import 'package:app/Food/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Restaurant extends StatefulWidget {
  final String sellerUid;
  Restaurant({Key? key, required this.sellerUid}) : super(key: key);

  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  Map<dynamic, dynamic>? selectedItem;
  int quantity = 1;
  bool itemAdded = false;

  Map data = {};
  bool isLoading = true; // Add loading state

  IO.Socket? socket;

  void initializeSocket([String? uid]) {
    socket = IO.io(
        'https://socketserver.conscientia.co.in/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket?.connect();

    socket?.onConnect((_) {

      if (uid != null) {
        socket?.emit('join', uid);
      }
    });

    socket?.on('foodStoreData', (data) {


      // Iterate through the received data to find the seller matching the sellerUid
      for (var store in data) {
        if (store['uid'] == widget.sellerUid) {
          setState(() {
            this.data = store; // Store the matched seller's details in 'data'
            isLoading = false; // Stop the loading once data is received
          });
          break;
        }
      }

      if (this.data.isEmpty) {
        print('No matching seller found for the provided sellerUid');
      }
    });

    socket?.onDisconnect((_) {
      print('Disconnected from socket');
    });

    socket?.onError((error) {
      print('Socket error: $error');
    });
  }

  @override
  void initState() {
    super.initState();
    initializeSocket();
  }

  Widget buildShimmerEffect() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[700]!,
            highlightColor: Colors.grey[500]!,
            child: Card(
              color: Colors.black.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 120,
                      width: 120,
                      color: Colors.grey[700],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            color: Colors.grey[700],
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: 15,
                            width: 80,
                            color: Colors.grey[700],
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: 12,
                            width: 100,
                            color: Colors.grey[700],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getConditionalIcon(bool condition) {
    return Row(
      children: [
        Icon(
          Icons.circle_sharp,
          color: condition ? Colors.green : Colors.red,
          size: 10,
        ),
        SizedBox(width: 4),
        Text(
          condition ? "VEG" : "NON-VEG",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Inter",
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  void _openBottomSheet(Map<dynamic, dynamic> item) {
    setState(() {
      selectedItem = item;
      quantity = 1;
      itemAdded = false;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Color.fromARGB(253, 43, 43, 43)
          .withOpacity(0.85), // Set to dark mode
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            int totalPrice = selectedItem!['price'] * quantity;

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              height: MediaQuery.of(context).size.height * 0.34,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Card(
                        color: Color.fromARGB(255, 71, 71, 71),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13.0, vertical: 8),
                          child: Text(
                            selectedItem!['name'].toString().toUpperCase(),
                            style: GoogleFonts.rubik(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color:
                                  Colors.white, // Text in white for dark mode
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13.0, vertical: 8),
                      child: Text(
                        "Price: ₹ ${selectedItem!['price']}/-"
                            .toString()
                            .toUpperCase(),
                        style: GoogleFonts.rubik(
                            fontSize: 17, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) quantity--;
                          });
                        },
                        icon: Icon(Icons.remove,
                            color: const Color.fromARGB(255, 255, 121, 111),
                            size: 30),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          quantity.toString(),
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (quantity < 4) {
                              // Limit the quantity to 4
                              quantity++;
                            }
                          });
                        },
                        icon: Icon(Icons.add,
                            color: Color.fromRGBO(255, 255, 255, 1), size: 30),
                      ),
                    ],
                  ),

                  Divider(color: Colors.white), // White divider for dark mode
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13.0, vertical: 8),
                          child: Text(
                            "Total: ₹ $totalPrice",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      itemAdded
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => CartPage()));
                              },
                              child: Text(
                                "Go to Cart",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                final cartProvider = Provider.of<CartProvider>(
                                    context,
                                    listen: false);
                                cartProvider.addItem(CartItem(
                                  isVeg: selectedItem!['category'] == 'veg',
                                    name: selectedItem!['name'],
                                    price: selectedItem!['price'],
                                    image: selectedItem!['image'],
                                    quantity: quantity,
                                    data: selectedItem,
                                    seller: selectedItem!['seller'],
                                    productId: selectedItem!['_id'],
                                    itemId: selectedItem!['itemId'],
                                    category: selectedItem!['category'],
                                    description: selectedItem!['description'],
                                    available: selectedItem!['available'],
                                    createdAt: selectedItem!['createdAt'],
                                    updatedAt: selectedItem!['updatedAt'],
                                    version: selectedItem!['__v']));
                                setState(() {
                                  itemAdded = true;
                                });

                                // Show a snackbar message for 3 seconds after item is added
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Item added to cart!",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              },
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
@override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/foody.jpg',
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.black.withOpacity(0.85),
            body: Column(
              children: [
                // Top Bar with Back and Cart Icons
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.shopping_cart, color: Colors.white),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => CartPage()));
                        },
                      ),
                    ],
                  ),
                ),

                // Banner with store details (no Stack)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: data['logo'] != null
                                ? NetworkImage(data['logo'].toString())
                                : AssetImage('assets/images/default_logo.png')
                                    as ImageProvider,
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['storeName']?.toString() ??
                                    'Store Name Unavailable',
                                style: GoogleFonts.rubik(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '${data['foodItems']?.length ?? 0} Products | '
                                '${data['foodItems']?.where((item) => item['category'] == 'veg').length ?? 0} Veg + '
                                '${data['foodItems']?.where((item) => item['category'] == 'nonveg').length ?? 0} Non-Veg',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Inter",
                                  fontSize: 13,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Text(
                  "FOOD ITEMS",
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                ),
                Divider(),
                Expanded(
                  child: isLoading
                      ? buildShimmerEffect() // Show shimmer while loading
                      : data['foodItems'] != null && data['foodItems'].isNotEmpty
                          ? ListView.builder(
                              itemCount: data['foodItems']?.length ?? 0,
                              itemBuilder: (context, index) {
                                var item = data['foodItems'][index];
                                bool isAvailable = item['available'];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: GestureDetector(
                                    onTap: isAvailable
                                        ? () => _openBottomSheet(item)
                                        : null, // Disable tap if item is not available
                                    child: Card(
                                      color: Colors.black.withOpacity(0.7),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 5,
                                      child: Row(
                                        children: [
                                          Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 120,
                                                  width: 120,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      item['image'],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (!isAvailable)
                                                Positioned.fill(
                                                  child: Container(
                                                    height: 120,
                                                    width: 120,
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    child: Center(
                                                      child: Text(
                                                        'OUT OF STOCK',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  getConditionalIcon(
                                                      item['category'] == 'veg'),
                                                  Text(
                                                    item['name'],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    "Rs ${item['price']} /-",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    'CATEGORY: ${item['description'].toString().toUpperCase()}',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                "No Food Items Available",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
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
