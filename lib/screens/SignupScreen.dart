import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../services/api_services.dart';
import 'LoginScreen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final AuthController controller = Get.put(AuthController());

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      String name = result.files.single.name;

      controller.setSelectedFile(file, name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              "Create Your Account",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please fill in your details to create your account and enjoy our se rvices.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Full Name
            TextField(
              controller: controller.fullNameController,
              decoration: InputDecoration(
                hintText: "Full Name",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 10),

            // Email
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 10),

            // Password
            TextField(
              controller: controller.passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),

            // Role
            DropdownButtonFormField<String>(
              items: ["Student", "Teacher", "Admin"].map((role) {
                return DropdownMenuItem(value: role, child: Text(role));
              }).toList(),
              onChanged: (value) {
                controller.selectedRole.value = value ?? '';
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 20),

            // File Upload Section
            GestureDetector(
              onTap: pickFile,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "Click to Upload or drag and drop\n(Max. File size 25 MB)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.purple,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Display selected file
            if (controller.selectedFile.value != null)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        controller.fileName.value,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: controller.removeFile,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            // Sign Up Button
            controller.isLoading.value
                ? const CircularProgressIndicator()
                : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF683091),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: controller.registerUser,
                child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),

            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Get.to(() => LoginScreen());
              },
              child: const Text("Already have an account? Log In"),
            ),
          ],
        ),
      )),
    );
  }
}

class AuthController extends GetxController {
  var isLoading = false.obs;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var selectedRole = ''.obs;

  var selectedFile = Rxn<File>();
  var fileName = ''.obs;

  void setSelectedFile(File file, String name) {
    selectedFile.value = file;
    fileName.value = name;
    print("Selected file: $name");
  }

  void removeFile() {
    selectedFile.value = null;
    fileName.value = '';
    print("File removed");
  }

  void registerUser() async {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        selectedRole.value.isEmpty) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    isLoading.value = true;

    final response = await ApiService.register(
      fullName: fullNameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    isLoading.value = false;

    print("Register API response: $response");

    if (response['status'] == 200) {
      Get.snackbar("Success", "Account created successfully");
      Get.to(() => LoginScreen());
    } else {
      final errorMessage = response['data']?['message'] ?? response['error'] ?? "Registration failed";
      Get.snackbar("Error", errorMessage);
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
