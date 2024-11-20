// lib/views/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/Components/dashboard_card.dart';
import 'package:task/Components/dashboard_drawer.dart';
import 'package:task/controller/auth_controller.dart';
import 'package:task/login.dart';
import 'package:task/models/menu_item_model.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  final List<MenuItemModel> menuItems = [
    MenuItemModel(
      title: 'Tasks',
      subtitle: 'Manage your tasks',
      icon: Icons.task,
      route: '/tasks',
    ),
    MenuItemModel(
      title: 'Calendar',
      subtitle: 'View your schedule',
      icon: Icons.calendar_today,
      route: '/calendar',
    ),
    MenuItemModel(
      title: 'Reports',
      subtitle: 'View analytics',
      icon: Icons.bar_chart,
      route: '/reports',
    ),
    MenuItemModel(
      title: 'Messages',
      subtitle: 'Check your inbox',
      icon: Icons.message,
      route: '/messages',
    ),
    MenuItemModel(
      title: 'Team',
      subtitle: 'Manage your team',
      icon: Icons.people,
      route: '/team',
    ),
    MenuItemModel(
      title: 'Files',
      subtitle: 'Access documents',
      icon: Icons.folder,
      route: '/files',
    ),
  ];

  Future<void> _handleLogout(BuildContext context) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await AuthController.logout(); // Just prints a message for now

      // Update status bar
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ));

      // Navigate to login screen (mocking login screen for now)
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login()), // Replace with your Login screen
          (route) => false,
        );
      }
    } catch (e) {
      // Handle error
      if (context.mounted) {
        Navigator.pop(context); // Remove loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        elevation: 8.0,
        shadowColor: Colors.black,
        backgroundColor: Colors.brown,
        toolbarHeight: 70.0,
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            iconSize: 27,
            onPressed: () {
              // Show notifications
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.account_circle),
            iconSize: 50,
            onSelected: (value) {
              if (value == 'profile') {
                // Navigate to profile
              } else if (value == 'logout') {
                _handleLogout(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Profile'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: const DashboardDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return DashboardCard(
                  title: item.title,
                  subtitle: item.subtitle,
                  icon: item.icon,
                  onTap: () {
                    // Navigate to the respective screen
                    print('Navigating to ${item.route}');
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
