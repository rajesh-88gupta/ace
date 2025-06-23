import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ace/services/api_services.dart'; // Import your ApiService
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:flutter/foundation.dart'; // Import for kDebugMode

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  final storage = const FlutterSecureStorage();
  bool _isLoading = true;
  bool _isEditing = false;

  // Using a static image URL as per the discussion about profile API scope
  final String _staticProfileImageUrl = 'https://i.imgur.com/BoN9kdC.png'; // Your default/static image

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    super.dispose();
  }

  Future<void> _fetchProfileData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String? token = await storage.read(key: 'auth_token');
      if (token != null) {
        final response = await ApiService.getProfile(token);
        if (response['status'] == 200) {
          final userData = response['data'];
          nameController.text = userData['name'] ?? '';
          emailController.text = userData['email'] ?? '';
          phoneController.text = userData['phone'] ?? '';

          String? dobString = userData['dob'];
          if (dobString != null && dobString.isNotEmpty) {
            try {
              DateTime dobDate = DateTime.parse(dobString);
              dobController.text = DateFormat('dd MMMM yyyy').format(dobDate);
            } catch (e) {
              dobController.text = dobString;
              if (kDebugMode) {
                print('DOB parsing error: $e for $dobString');
              }
            }
          } else {
            dobController.text = '';
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['error'] ?? 'Failed to load profile (Status: ${response['status']})')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication token not found. Please log in again.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching profile: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateProfileData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String? token = await storage.read(key: 'auth_token');
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication token not found. Please log in again.')),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      String? dobForApi;
      try {
        if (dobController.text.isNotEmpty) {
          DateTime parsedDob = DateFormat('dd MMMM yyyy').parse(dobController.text);
          dobForApi = DateFormat('yyyy-MM-dd').format(parsedDob);
        }
      } catch (e) {
        if (kDebugMode) {
          print('DOB formatting error for API: $e');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid Date of Birth format. Please use dd MMMM yyyy.')),
        );
        setState(() { _isLoading = false; });
        return;
      }

      final response = await ApiService.updateProfile(
        token: token,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        dob: dobForApi ?? '',
      );

      if (response['status'] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        setState(() {
          _isEditing = false;
        });
        _fetchProfileData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['error'] ?? 'Failed to update profile (Status: ${response['status']})')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate;
    try {
      if (dobController.text.isNotEmpty) {
        initialDate = DateFormat('dd MMMM yyyy').parse(dobController.text);
      } else {
        initialDate = DateTime.now();
      }
    } catch (_) {
      initialDate = DateTime.now();
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobController.text = DateFormat('dd MMMM yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          // Purple background
          Container(
            height: 750,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),

          // White form card
          Positioned(
            top: 180,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 80), // Space for the profile image
                  CustomInputField(
                    label: 'Full Name',
                    icon: Icons.person,
                    controller: nameController,
                    readOnly: !_isEditing,
                  ),
                  CustomInputField(
                    label: 'Email Address',
                    icon: Icons.email,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    readOnly: true,
                  ),
                  CustomInputField(
                    label: 'Phone Number',
                    icon: Icons.phone,
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    readOnly: !_isEditing,
                  ),
                  CustomInputField(
                    label: 'Date of Birth',
                    icon: Icons.calendar_today,
                    controller: dobController,
                    readOnly: !_isEditing,
                    onTap: _isEditing ? () => _selectDate(context) : null,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (_isEditing)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isEditing = false;
                            });
                            _fetchProfileData();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ElevatedButton(
                        onPressed: () {
                          if (_isEditing) {
                            _updateProfileData();
                          } else {
                            setState(() {
                              _isEditing = true;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: EdgeInsets.symmetric(
                            horizontal: _isEditing ? 40 : 50,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          _isEditing ? 'Save Changes' : 'Edit Profile',
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Profile Image (centered and overlapping)
          Positioned(
            top: 100,
            left: screenWidth / 2 - 60,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(_staticProfileImageUrl),
                onBackgroundImageError: (exception, stackTrace) {
                  if (kDebugMode) {
                    print('Error loading static profile image: $exception');
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomInputField({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600]),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
      ),
    );
  }
}