import 'package:app/Landing/announcements.dart';
import 'package:app/Landing/create_team_section.dart';
import 'package:app/Landing/fun_events.dart';
import 'package:app/Landing/my_activity.dart';
import 'package:app/Landing/order_stat_dash.dart';
import 'package:app/Landing/upcoming_event.dart';
import 'package:app/Landing/user_card.dart';
import 'package:app/main.dart';
import 'package:app/pages/comingsoon.dart';
import 'package:app/pages/my_events_page.dart';
import 'package:app/pages/my_workshop_page.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DashboardPage extends StatefulWidget {
  DashboardPage({
    super.key,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
 
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;


    if (user != null) {
      print('Username: ${user.username}');
      print('Email: ${user.email}');
      // Use other fields as needed
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/teams background.png',
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.black
                .withOpacity(0.3), // Make Scaffold background transparent
            key: _scaffoldKey,
            drawer: Drawer(
              backgroundColor: Color.fromARGB(255, 14, 14, 14),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: Text(
                        'ASTRAL ARMAGEDDON',
                        style: TextStyle(
                            fontFamily: 'Dune',
                            color: Colors.white,
                            fontSize: 15),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          const Divider(),
                          _buildDrawerItem(
                            icon: FluentIcons.person_24_regular,
                            text: 'My Events',
                          ),
                          _buildDrawerItem(
                            icon: FluentIcons.toolbox_24_regular,
                            text: 'My Workshop',
                          ),

                          _buildDrawerItem(
                            icon: FluentIcons.people_24_regular,
                            text: 'My Friendlist',
                          ),
                          _buildDrawerItem(
                            icon: FluentIcons.person_add_16_filled,
                            text: 'Friend Requests',
                          ),
                          _buildDrawerItem(
                            icon: FluentIcons.cart_24_regular,
                            text: 'My Food Orders',
                          ),
                          const Divider(color: Colors.white),

                          _buildDrawerItem(
                            icon: FluentIcons.alert_24_regular,
                            text: 'Announcements',
                          ),
                          const Divider(color: Colors.white),
                          _buildDrawerItem(
                            icon: FluentIcons.code_16_filled,
                            text: 'Developers',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  surfaceTintColor: Colors.black,
                  floating: true,
                  snap: true,
                  title: const Text(
                    "Conscientia 2k24",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'warx',
                      color: Colors.white,
                    ),
                  ),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.red,
                      size: 30,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                  backgroundColor: Colors.black
                      .withOpacity(0.4), // Transparent with some opacity
                  elevation: 0,
                ),
                SliverPersistentHeader(
                  floating: false,
                  delegate: _SliverAppBarDelegate(
                    minHeight: 60.0,
                    maxHeight: 60.0,
                    child: Container(
                      color: Colors.black
                          .withOpacity(0.4), // Transparent with some opacity
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 10),
                          _buildSelectableCard(
                            index: 0,
                            title: "Dashboard",
                            icon: FluentIcons.home_24_regular,
                          ),
                          const Spacer(),
                          _buildSelectableCard(
                            index: 1,
                            title: "My Activity",
                            icon: FluentIcons.shopping_bag_16_filled,
                          ),
                          const Spacer(),
                          _buildSelectableCard(
                            index: 2,
                            title: "Create Team",
                            icon: FluentIcons.people_team_24_regular,
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(height: 10),
                      if (selectedIndex == 0) const DashboardSection(),
                      if (selectedIndex == 1) const MyActivitySection(),
                      if (selectedIndex == 2)  CreateTeamSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectableCard(
      {required int index, required String title, required IconData icon}) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Card(
        color: isSelected
            ? const Color.fromARGB(255, 254, 63, 63).withOpacity(0.7)
            : Color.fromARGB(255, 59, 59, 59).withOpacity(0.7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: SizedBox(
          height: 35,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String text}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      tileColor: const Color.fromARGB(255, 14, 14, 14),
      onTap: () {
        switch (text) {
          case 'My Events':
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => MyEventsPage(),
                  fullscreenDialog: true),
            );
          case 'My Workshop':
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => MyworkshopsPage(),
                  fullscreenDialog: true),
            );

          case 'My Friendlist':

          Navigator.of(context).pop();
          setState(() {
            selectedIndex=2;
            
          });

          case 'Friend Requests':
          Navigator.of(context).pop();
          setState(() {
            selectedIndex=2;

          });
          

          case 'My Food Orders':
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => Comingsoon(),
                  fullscreenDialog: true),
            );
          case 'Merchandise':
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => Comingsoon(),
                  fullscreenDialog: true),
            );
          case 'Announcements':
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => Comingsoon(),
                  fullscreenDialog: true),
            );
          case 'Developers':
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => Comingsoon(),
                  fullscreenDialog: true),
            );
        }
      },
    );
  }
}

class DashboardSection extends StatefulWidget {
  const DashboardSection({super.key});

  @override
  State<DashboardSection> createState() => _DashboardSectionState();
}

class _DashboardSectionState extends State<DashboardSection> {


    IO.Socket? socket;
  
    List upcomingEventData=[];

  
    @override
  void initState() {
    super.initState();
    initializeSocket();
  }

    void initializeSocket() {
    socket = IO.io(
        'https://socketserver-conscientia2k24-o343q.ondigitalocean.app/',
        <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        });

    socket?.connect();

    socket?.onConnect((_) {
      print('Connected to socket');
      // Subscribe to the user's room or listen for specific events
    });

    socket?.on('upcomingevents', (data) {
      print("Data recieved on dashboooarrrrdd");
      print(data);
      setState(() {
        upcomingEventData=data;
      });
      
    });
    }


  @override
  Widget build(BuildContext context) {

    print('socket data on dashboard Page xyz ${upcomingEventData}');



    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          // Announcements on Dashboard section
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Announcements(),
          // ),

          // User Card User Interface and APIs
          UserCard(),

          // OrderStatus Live Update for Users
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Column(
          //     children: [
          //       OrderList(),
          //     ],
          //   ),
          // ),

          FunEvents(),

          UpcomingEvents(
            eventData: upcomingEventData
          ),

          // MerchWidget()
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
