import 'dart:io';
import 'package:ace/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import '../../services/api_services.dart';
import 'LoginScreen.dart';
import 'package:flutter/foundation.dart'; // Import for kDebugMode
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final AuthController controller = Get.put(AuthController());

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      controller.setSelectedFile(file, result.files.single.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(controller: controller.fullNameController, decoration: InputDecoration(labelText: 'Full Name',
                border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)),
          )),
              const SizedBox(height: 20),
              TextField(controller: controller.emailController, decoration: InputDecoration(labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)),)),
              const SizedBox(height: 20),
              TextField(controller: controller.phoneController, decoration: InputDecoration(labelText: 'Phone',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),)),
              const SizedBox(height: 20),
              TextField(controller: controller.cityController, decoration: InputDecoration(labelText: 'City',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),)),
              const SizedBox(height: 20),
              TextField(controller: controller.provinceController, decoration: InputDecoration(labelText: 'Province',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),)),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                value: controller.selectedGender.value.isEmpty ? null : controller.selectedGender.value,
                decoration: InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                hint: const Text("Select Gender"),
                onChanged: (value) => controller.setSelectedGender(value!),
                items: ['Male', 'Female', 'Other'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                value: controller.selectedRole.value.isEmpty ? null : controller.selectedRole.value,
                decoration: InputDecoration(
                  labelText: "Role",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                hint: const Text("Select Role"),
                onChanged: (value) => controller.setSelectedRole(value!),
                items: ['Student', 'Instructor'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: pickFile,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      const Icon(Icons.attach_file),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Obx(() => Text(
                          controller.selectedFileName.value.isEmpty
                              ? "Upload File"
                              : controller.selectedFileName.value,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(controller: controller.passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),)),
              const SizedBox(height: 20),
              TextField(controller: controller.confirmPasswordController, obscureText: true, decoration: InputDecoration(labelText: 'Confirm Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),)),
              const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: controller.registerUser,
              //   style: ElevatedButton.styleFrom(
              //       backgroundColor: const Color(0xFF683091),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       padding: const EdgeInsets.symmetric(vertical: 15),
              //     ),
              //   child: const Text(
              //     "Sign Up",
              //     style: TextStyle(fontSize: 18, color: Colors.white),
              //   ),
              // ),
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

// class SignUpScreen extends StatelessWidget {
//   SignUpScreen({super.key});
//
//   final AuthController controller = Get.put(AuthController());
//
//   Future<void> pickFile() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
//       );
//
//       if (result != null) {
//         if (result.files.single.size > 25 * 1024 * 1024) {
//           Get.snackbar("Error", "File size must be less than 25MB");
//           return;
//         }
//
//         File file = File(result.files.single.path!);
//         String name = result.files.single.name;
//         controller.setSelectedFile(file, name);
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('File picker error: $e');
//       }
//       Get.snackbar("Error", "Failed to pick file: ${e.toString()}");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Sign Up"),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF683091),
//         foregroundColor: Colors.white,
//       ),
//       body: Obx(
//             () => controller.isLoading.value
//             ? const Center(
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF683091)),
//           ),
//         )
//             : SingleChildScrollView(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               TextField(
//                 controller: controller.fullNameController,
//                 decoration: InputDecoration(
//                   labelText: "Full Name",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: controller.emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   labelText: "Email",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: controller.phoneNumberController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   labelText: "Phone Number",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: controller.cityController,
//                 decoration: InputDecoration(
//                   labelText: "City",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: controller.provinceController,
//                 decoration: InputDecoration(
//                   labelText: "Province",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               DropdownButtonFormField<String>(
//                 value: controller.selectedGender.value.isEmpty
//                     ? null
//                     : controller.selectedGender.value,
//                 decoration: InputDecoration(
//                   labelText: "Gender",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//                 hint: const Text("Select Gender"),
//                 onChanged: (String? newValue) {
//                   if (newValue != null) {
//                     controller.setSelectedGender(newValue);
//                   }
//                 },
//                 items: <String>['Male', 'Female', 'Other']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 20),
//               DropdownButtonFormField<String>(
//                 value: controller.selectedRole.value.isEmpty
//                     ? null
//                     : controller.selectedRole.value,
//                 decoration: InputDecoration(
//                   labelText: "Role",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//                 hint: const Text("Select Role"),
//                 onChanged: (String? newValue) {
//                   if (newValue != null) {
//                     controller.setSelectedRole(newValue);
//                   }
//                 },
//                 items: <String>['Student', 'Teacher', 'Admin']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 20),
//               GestureDetector(
//                 onTap: pickFile,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 15, horizontal: 10),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.attach_file),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: Obx(
//                               () => Text(
//                             controller.selectedFileName.value.isEmpty
//                                 ? "Upload Photo/Document (Max 25MB)"
//                                 : controller.selectedFileName.value,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: controller.passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: "Password",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: controller.confirmPasswordController,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: "Confirm Password",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: controller.registerUser,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF683091),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                   ),
//                   child: const Text(
//                     "Sign Up",
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Already have an account?"),
//                   TextButton(
//                     onPressed: () {
//                       Get.offAll(() => const LoginScreen());
//                     },
//                     child: const Text(
//                       "Login",
//                       style: TextStyle(
//                         color: Color(0xFF683091),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
