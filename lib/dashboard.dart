// dashboard.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/login.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.brown[50],
      appBar: AppBar(
        elevation: 8.0,
        shadowColor: Colors.black, 
        backgroundColor: Colors.brown,
        toolbarHeight: 70.0,
        actions: [
          //Notification Icon
          IconButton(
            icon: const Icon(Icons.notifications),
            // color: Colors.white,
            iconSize: 27,
            onPressed: () {}, 
          ),
          // // User Icon
          // IconButton(
          //   padding: EdgeInsets.only(right: 20, left: 5),
          //   icon: const Icon(Icons.account_circle),
          //   iconSize: 50,
          //   // color: Colors.white,
          //   onPressed: () {
          //     // Action when the user icon is pressed
          //     // print('User icon pressed');
          //   },

        // User Icon - showing a popup menu
          PopupMenuButton<String>(
            icon: const Icon(Icons.account_circle),
            iconSize: 50,
            onSelected: (value) {
              if (value == 'profile') {
                // Navigate to profile screen
                // Navigator.push(
                //   context,
                  // MaterialPageRoute(builder: (context) => ProfileScreen()),
                // );
              } else if (value == 'logout') {
                // Handle logout logic here
                print('Logging out...');

                // Ensure status bar looks correct
                SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent, // Transparent status bar
                  statusBarIconBrightness: Brightness.dark, // Dark icons on transparent background
                ));

                 Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()), // Navigate to LoginScreen
                  (Route<dynamic> route) => false, // Removes all previous routes
                );

              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: const [
                    Icon(Icons.person, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Profile'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children:[
                    Icon(Icons.logout, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
          

          // ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            SizedBox(
              height: 120.0, // Set the desired height
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.brown, // Set the color of the DrawerHeader
                ),
                child: Center(
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            // Add other items here
            ListTile(
              title: Text('Item 1'),
              // onTap: () {},
            ),
            ListTile(
              title: Text('Item 2'),
              // onTap: () {},
            ),
          ],
        ),
      ),
      body: const Center(
        
        child: Text(
          'Welcome to the Dashboard!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
