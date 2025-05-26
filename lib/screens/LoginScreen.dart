import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  bool agreeTerms = false;
  bool isLoginSuccessful = false;
  bool isLoginAttempted = false;

  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Color userIdBorderColor = Colors.grey;
  Color passwordBorderColor = Colors.grey;

  void validateLogin() {
    setState(() {
      isLoginAttempted = true;

      // Dummy login validation (Replace with actual logic)
      if (userIdController.text == "admin" && passwordController.text == "1234") {
        isLoginSuccessful = true;
        userIdBorderColor = Colors.green;
        passwordBorderColor = Colors.green;
      } else {
        isLoginSuccessful = false;
        userIdBorderColor = Colors.red;
        passwordBorderColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/images/bg_bottom.png",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Log In To Your Account",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Welcome back! Please log in to your account\nto continue where you left off.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 30),

                  // User ID Field
                  Text("User Id", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 5),
                  TextField(
                    controller: userIdController,
                    decoration: InputDecoration(
                      hintText: "User Id",
                      prefixIcon: Icon(Icons.person, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: userIdBorderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: userIdBorderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: userIdBorderColor, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Password Field
                  Text("Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 5),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock, color: Colors.grey),
                      suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: passwordBorderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: passwordBorderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: passwordBorderColor, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Terms and Conditions Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: agreeTerms,
                        onChanged: (value) {
                          setState(() {
                            agreeTerms = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          "By creating an account, you agree to our",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            agreeTerms = !agreeTerms;
                          });
                        },
                        child: Text(
                          "Terms and Conditions",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.purple),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Log In Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF683091),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: validateLogin,
                      child: Text(
                        "Log In",
                        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Remember Me & Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            rememberMe = !rememberMe;
                          });
                        },
                        child: Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value!;
                                });
                              },
                            ),
                            Text("Remember me?", style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                      Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.purple),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
