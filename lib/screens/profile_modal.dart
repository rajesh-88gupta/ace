import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ace/services/api_services.dart';
import 'package:ace/screens/users/LoginScreen.dart';
import 'package:get/get.dart';

class ProfileModal extends StatelessWidget {
  const ProfileModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profileScreen');
              }),
              _buildMenuItem(context, Icons.school_outlined, 'My Classes'),
              _buildMenuItem(context, Icons.check_circle_outline, 'Attendance'),
              _buildMenuItem(context, Icons.book_outlined, 'My Course'),
              _buildMenuItem(context, Icons.calendar_today_outlined, 'Calendar'),
              _buildMenuItem(context, Icons.note_outlined, 'My Notes'),
              _buildMenuItem(context, Icons.schedule_outlined, 'Reschedule or Cancel Class'),
              const Divider(height: 30),
              _buildMenuItem(
                context,
                Icons.logout,
                'Logout',
                color: Colors.red,
                onTap: () {
                  _showLogoutDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildMenuItem(
      BuildContext context,
      IconData icon,
      String text, {
        Color color = Colors.black,
        VoidCallback? onTap,
      }) {
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
            const Spacer(),
            if (icon != Icons.logout)
              const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  static Future<void> _showLogoutDialog(BuildContext context) async {
    final storage = const FlutterSecureStorage();

    await showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (context) => Center(
        child: AlertDialog(
          elevation: 16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Log out ?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Are You Sure Want To Log Out',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF0F1F9),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C3EFF),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () async {
                        // Get the refresh token from secure storage
                        final refreshToken = await storage.read(key: 'refresh_token');

                        if (refreshToken != null) {
                          // Call the logout API
                          final result = await ApiService.logout(refreshToken);

                          if (result['status'] == 200) {
                            // Clear all stored tokens
                            await storage.delete(key: 'auth_token');
                            await storage.delete(key: 'refresh_token');

                            // Navigate to login screen
                            Navigator.of(context).pop(); // close dialog
                            Navigator.of(context).pop(); // close profile modal
                            Get.offAll(() => const LoginScreen());
                          } else {
                            // Show error message if logout failed
                            final errorMessage = result['data']?['message'] ??
                                result['error'] ?? 'Logout failed.';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(errorMessage)),
                            );
                          }
                        } else {
                          // If no refresh token, just clear storage and navigate
                          await storage.delete(key: 'auth_token');
                          Navigator.of(context).pop(); // close dialog
                          Navigator.of(context).pop(); // close profile modal
                          Get.offAll(() => const LoginScreen());
                        }
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

void showProfileModal(BuildContext context) {
  Navigator.of(context).push(RightToLeftRoute(child: const ProfileModal()));
}