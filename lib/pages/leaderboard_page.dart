import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  late IO.Socket socket;
  List<Map<String, dynamic>> leaderboardData = [
    {
      'rank': 1,
      'name': 'Rakesh Sharma',
      'points': 9089,
      'rankTitle': 'Galactic Overlord',
      'avatar': 'assets/avatar1.png',
    },
    {
      'rank': 2,
      'name': 'Amit Patel',
      'points': 8500,
      'rankTitle': 'Admiral',
      'avatar': 'assets/avatar2.png',
    },
    {
      'rank': 3,
      'name': 'Nina Gupta',
      'points': 8200,
      'rankTitle': 'Brigadier General',
      'avatar': 'assets/avatar3.png',
    },
    {
      'rank': 4,
      'name': 'Mariko',
      'points': 8000,
      'rankTitle': 'Colonel',
      'avatar': 'assets/avatar4.png',
    },
    {
      'rank': 5,
      'name': 'Suresh Kumar',
      'points': 7800,
      'rankTitle': 'Major',
      'avatar': 'assets/avatar5.png',
    },
    {
      'rank': 6,
      'name': 'Anita Singh',
      'points': 7600,
      'rankTitle': 'Captain',
      'avatar': 'assets/avatar6.png',
    },
    {
      'rank': 7,
      'name': 'Vikram Rana',
      'points': 7400,
      'rankTitle': 'Lieutenant',
      'avatar': 'assets/avatar7.png',
    },
    {
      'rank': 8,
      'name': 'Ritu Verma',
      'points': 7200,
      'rankTitle': 'Sergeant',
      'avatar': 'assets/avatar8.png',
    },
    {
      'rank': 9,
      'name': 'Rajesh Iyer',
      'points': 7000,
      'rankTitle': 'Private',
      'avatar': 'assets/avatar9.png',
    },
    {
      'rank': 10,
      'name': 'Priya Nair',
      'points': 6800,
      'rankTitle': 'Troop Chief',
      'avatar': 'assets/avatar10.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the socket connection here
    // socket = IO.io('http://localhost:3000', <String, dynamic>{
    //   'transports': ['websocket'],
    // });
    // socket.on('connect', (_) {
    //   print('connect');
    // });
    // socket.on('disconnect', (_) {
    //   print('disconnect');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Handle info icon press
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: 16,
            right: 16,
            top: 16,
            child: Card(
              color: Colors.white.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        Text(
                          'Conscientia Points',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '1500',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            top: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTopRankCard(leaderboardData[1]),
                _buildTopRankCard(leaderboardData[0], isCenter: true),
                _buildTopRankCard(leaderboardData[2]),
              ],
            ),
          ),
          Positioned(
            top: 250,
            left: 16,
            right: 16,
            bottom: 16,
            child: Card(
              color: Colors.white.withOpacity(0.1),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Rank', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        Text('Name', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        Text('Points', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: leaderboardData.length,
                      itemBuilder: (context, index) {
                        final item = leaderboardData[index];
                        return _buildRankRow(item);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankRow(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(data['avatar']),
          ),
          title: Text(
            data['rankTitle'],
            style: const TextStyle(color: Colors.white,),
          ),
          subtitle: Text(
            '${data['name']}',
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: Text(
            '${data['points']}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildTopRankCard(Map<String, dynamic> data, {bool isCenter = false}) {
    return Column(
      children: [
        CircleAvatar(
          radius: isCenter ? 40 : 30,
          backgroundImage: AssetImage(data['avatar']),
        ),
        const SizedBox(height: 8),
        Text(
          '${data['rankTitle']}',
          style: TextStyle(fontSize: isCenter ? 18 : 16, color: Colors.white),
        ),
        Text(
          '${data['name']}',
          style: TextStyle(fontSize: isCenter ? 16 : 14, color: Colors.white),
        ),
        Text(
          '${data['points']}',
          style: TextStyle(fontSize: isCenter ? 14 : 12, color: Colors.white),
        ),
      ],
    );
  }
}