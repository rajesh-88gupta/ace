import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import '../services/api_services.dart';
import 'LoginScreen.dart';
import 'package:flutter/foundation.dart'; // Import for kDebugMode

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final AuthController controller = Get.put(AuthController());

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null) {
        if (result.files.single.size > 25 * 1024 * 1024) {
          Get.snackbar("Error", "File size must be less than 25MB");
          return;
        }

        File file = File(result.files.single.path!);
        String name = result.files.single.name;
        controller.setSelectedFile(file, name);
      }
    } catch (e) {
      if (kDebugMode) {
        print('File picker error: $e');
      }
      Get.snackbar("Error", "Failed to pick file: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        centerTitle: true,
        backgroundColor: const Color(0xFF683091),
        foregroundColor: Colors.white,
      ),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF683091)),
          ),
        )
            : SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: controller.fullNameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.cityController,
                decoration: InputDecoration(
                  labelText: "City",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.provinceController,
                decoration: InputDecoration(
                  labelText: "Province",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: controller.selectedGender.value.isEmpty
                    ? null
                    : controller.selectedGender.value,
                decoration: InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                hint: const Text("Select Gender"),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.setSelectedGender(newValue);
                  }
                },
                items: <String>['Male', 'Female', 'Other']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: controller.selectedRole.value.isEmpty
                    ? null
                    : controller.selectedRole.value,
                decoration: InputDecoration(
                  labelText: "Role",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                hint: const Text("Select Role"),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.setSelectedRole(newValue);
                  }
                },
                items: <String>['Student', 'Teacher', 'Admin']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: pickFile,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.attach_file),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Obx(
                              () => Text(
                            controller.selectedFileName.value.isEmpty
                                ? "Upload Photo/Document (Max 25MB)"
                                : controller.selectedFileName.value,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF683091),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Get.offAll(() => const LoginScreen());
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Color(0xFF683091),
                        fontWeight: FontWeight.bold,
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

class AuthController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();

  RxString selectedRole = ''.obs;
  RxString selectedGender = ''.obs;
  Rx<File?> selectedFile = Rx<File?>(null);
  RxString selectedFileName = ''.obs;
  RxBool isLoading = false.obs;

  void setSelectedFile(File file, String name) {
    selectedFile.value = file;
    selectedFileName.value = name;
  }

  void setSelectedRole(String role) {
    selectedRole.value = role;
  }

  void setSelectedGender(String gender) {
    selectedGender.value = gender;
  }

  Future<void> registerUser() async {
    // Client-side validation
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        cityController.text.isEmpty ||
        provinceController.text.isEmpty ||
        selectedRole.value.isEmpty ||
        selectedGender.value.isEmpty) {
      Get.snackbar("Error", "Please fill in all required fields.");
      return;
    }

    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar("Error", "Please enter a valid email address.");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Passwords do not match.");
      return;
    }

    isLoading.value = true;

    try {
      final response = await ApiService.register(
        name: fullNameController.text,
        email: emailController.text,
        password: passwordController.text,
        password2: confirmPasswordController.text,
        role: selectedRole.value,
        photoDocument: selectedFile.value,
        phone: phoneNumberController.text,
        city: cityController.text,
        province: provinceController.text,
        gender: selectedGender.value,
      );

      isLoading.value = false;

      if (response['status'] == 200 || response['status'] == 201) {
        Get.snackbar("Success", "Account created successfully");
        Get.offAll(() => LoginScreen());
      } else {
        // Handle specific error messages from the backend
        String errorMessage = response['error'] ?? "Registration failed. Please try again.";
        if (response['data'] != null && response['data'] is Map) {
          // Iterate over errors if the backend sends multiple field errors
          if (response['data'].containsKey('email') && response['data']['email'] is List) {
            errorMessage = response['data']['email'][0];
          } else if (response['data'].containsKey('password') && response['data']['password'] is List) {
            errorMessage = response['data']['password'][0];
          } else if (response['data'].containsKey('detail')) {
            errorMessage = response['data']['detail'];
          } else if (response['data'].containsKey('message')) {
            errorMessage = response['data']['message'];
          } else {
            // If the error data is a generic map, try to stringify it
            errorMessage = response['data'].toString();
          }
        }
        Get.snackbar("Error", errorMessage);
      }
    } catch (e) {
      isLoading.value = false;
      if (kDebugMode) {
        print('Registration catch error: $e');
      }
      Get.snackbar("Error", "An error occurred: ${e.toString()}");
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    cityController.dispose();
    provinceController.dispose();
    super.onClose();
  }
}