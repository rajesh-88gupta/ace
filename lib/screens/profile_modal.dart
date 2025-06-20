import 'package:flutter/material.dart';

// This is your ProfileModal widget, unchanged except for the borderRadius
class ProfileModal extends StatelessWidget {
  const ProfileModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // for overlay effect if needed
      body: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Center(
                child: Text(
                  'My Profile',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/women/68.jpg',
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Smita Williams',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Smithawilliams458@gmail.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildMenuItem(context, Icons.account_circle_outlined, 'My Account', onTap: () {
                Navigator.pop(context); // Close modal
                Navigator.pushNamed(context, '/profileScreen');
              }),
              _buildMenuItem(context, Icons.school_outlined, 'My Classes'),
              _buildMenuItem(context, Icons.check_circle_outline, 'Attendance'),
              _buildMenuItem(context, Icons.book_outlined, 'My Course'),
              _buildMenuItem(context, Icons.calendar_today_outlined, 'Calendar'),
              _buildMenuItem(context, Icons.note_outlined, 'My Notes'),
              _buildMenuItem(context, Icons.schedule_outlined, 'Reschedule or Cancel Class'),
              const Divider(height: 30),
              _buildMenuItem(context, Icons.logout, 'Logout', color: Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildMenuItem(BuildContext context, IconData icon, String text,
      {Color color = Colors.black, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 15),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom route for right-to-left animation
class RightToLeftRoute extends PageRouteBuilder {
  final Widget child;
  RightToLeftRoute({required this.child})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween<Offset>(
        begin: const Offset(1, 0), // Start from right
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.ease));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

// Usage: call this to open the profile modal from right to left
void showProfileModal(BuildContext context) {
  Navigator.of(context).push(RightToLeftRoute(child: const ProfileModal()));
}

// Example main app for testing
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/profileScreen': (_) => const Scaffold(
          body: Center(child: Text('Profile Screen')),
        ),
      },
      home: Scaffold(
        appBar: AppBar(title: const Text('Demo App')),
        body: Center(
          child: ElevatedButton(
            onPressed: () => showProfileModal(context),
            child: const Text('Open Profile Modal'),
          ),
        ),
      ),
    );
  }
}