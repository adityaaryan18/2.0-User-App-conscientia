
import 'package:app/Food/cart_provider.dart';
import 'package:app/Food/restaurant_route.dart';
import 'package:app/services/firebase_auth_methods.dart';
import 'package:app/firebase_options.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_)=>CartProvider()),
      ],
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(
        ),
        home: const AuthWrapper(),
        routes: {
          EmailPasswordSignup.routeName: (context) =>
              const EmailPasswordSignup(),
          EmailPasswordLogin.routeName: (context) => const EmailPasswordLogin(),
        },
      initialRoute: '/',
      onGenerateRoute: RestaurantRoute.generateRoute ,
      ),
    );
  }
}



class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return HomePage();
    }
    return const EmailPasswordLogin();
  }
}

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
class UserModel {
  final String id;
  final String forceId;
  final String username;
  final String? firstName;
  final String? lastName;
  final int? mobile;
  final String? profile;
  final String? college;
  final String? collegeId;
  final int? aadhar;
  final String role;
  final String email;
  final String userId;
  final List<dynamic> myAllies;
  final List<dynamic> myRequests;
  final List<dynamic> registeredEvents;
  final List<dynamic> registeredWorkshops;
  final List<dynamic> purchasedMerchs;
  final int rank;
  final int conscientiaPoints;
  final List<dynamic> foodOrders;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.forceId,
    required this.username,
    this.firstName,
    this.lastName,
    this.mobile,
    this.profile,
    this.college,
    this.collegeId,
    this.aadhar,
    required this.role,
    required this.email,
    required this.userId,
    required this.myAllies,
    required this.myRequests,
    required this.registeredEvents,
    required this.registeredWorkshops,
    required this.purchasedMerchs,
    required this.rank,
    required this.conscientiaPoints,
    required this.foodOrders,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      username: json['username'],
      forceId: json['forceId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      mobile: json['mobile'],
      profile: json['profile'],
      college: json['college'],
      collegeId: json['collegeId'],
      aadhar: json['aadhar'],
      role: json['role'],
      email: json['email'],
      userId: json['userId'],
      myAllies: json['myAllies'],
      myRequests: json['myRequests'],
      registeredEvents: json['registeredEvents'],
      registeredWorkshops: json['registeredWorkshops'],
      purchasedMerchs: json['purchasedMerchs'],
      rank: json['rank'],
      conscientiaPoints: json['conscientiaPoints'],
      foodOrders: json['foodOrders'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'profile': profile,
      'college': college,
      'collegeId': collegeId,
      'aadhar': aadhar,
      'role': role,
      'email': email,
      'userId': userId,
      'myAllies': myAllies,
      'myRequests': myRequests,
      'registeredEvents': registeredEvents,
      'registeredWorkshops': registeredWorkshops,
      'purchasedMerchs': purchasedMerchs,
      'rank': rank,
      'conscientiaPoints': conscientiaPoints,
      'foodOrders': foodOrders,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
