import 'dart:io';
import 'package:ace/screens/users/LoginScreen.dart';
import 'package:ace/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final provinceController = TextEditingController();

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
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        phoneController.text.isEmpty ||
        cityController.text.isEmpty ||
        provinceController.text.isEmpty ||
        selectedRole.value.isEmpty ||
        selectedGender.value.isEmpty) {
      Get.snackbar("Error", "Please fill all fields.");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Passwords do not match.");
      return;
    }

    isLoading.value = true;

    final response = await ApiService.register(
      name: fullNameController.text,
      email: emailController.text,
      password: passwordController.text,
      password2: confirmPasswordController.text,
      role: selectedRole.value,
      photoDocument: selectedFile.value,
      phone: phoneController.text,
      city: cityController.text,
      province: provinceController.text,
      gender: selectedGender.value,
      userId: emailController.text,
    );

    isLoading.value = false;

    if (response['status'] == 200 || response['status'] == 201) {
      Get.snackbar("Success", "User registered. Awaiting admin approval.");
      Get.offAll(() => const LoginScreen());
    } else {
      final msg = response['data']?['message'] ??
          response['data']?.toString() ??
          "Registration failed.";
      Get.snackbar("Error", msg);
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    cityController.dispose();
    provinceController.dispose();
    super.onClose();
  }
}
