import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  bool _isPasswordValid(String password) => password.length >= 8;

  @override
  void initState() {
    super.initState();
    _newPasswordFocus.addListener(() => setState(() {}));
    _confirmPasswordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _newPasswordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40),

              // New Password
              _buildPasswordField(
                label: 'New Password',
                controller: _newPasswordController,
                obscureText: _obscureNew,
                onToggle: () {
                  setState(() {
                    _obscureNew = !_obscureNew;
                  });
                },
                focusNode: _newPasswordFocus,
              ),

              const SizedBox(height: 8),
              _buildPasswordStatus(_newPasswordController.text),

              const SizedBox(height: 24),

              // Confirm Password
              _buildPasswordField(
                label: 'Confirm Password',
                controller: _confirmPasswordController,
                obscureText: _obscureConfirm,
                onToggle: () {
                  setState(() {
                    _obscureConfirm = !_obscureConfirm;
                  });
                },
                focusNode: _confirmPasswordFocus,
              ),

              const SizedBox(height: 8),
              _buildPasswordStatus(_confirmPasswordController.text),

              const Spacer(),

              // Reset Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Add reset logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggle,
    required FocusNode focusNode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, color: Colors.black87)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: focusNode.hasFocus ? Colors.green : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            obscureText: obscureText,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: onToggle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordStatus(String password) {
    final valid = _isPasswordValid(password);
    return Row(
      children: [
        Icon(
          valid ? Icons.check_circle_outline : Icons.error_outline,
          color: valid ? Colors.green : Colors.grey,
          size: 18,
        ),
        const SizedBox(width: 6),
        Text(
          valid ? 'Password accepted!' : 'Enter at least 8 characters',
          style: TextStyle(
            fontSize: 14,
            color: valid ? Colors.green : Colors.grey,
          ),
        ),
        const Spacer(),
        Text(
          '${password.length}/8',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
