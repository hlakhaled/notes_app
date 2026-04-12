import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/app_color.dart';
import 'widgets/auth_primary_button.dart';
import 'widgets/auth_shell.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/auth_header.dart';
import 'widgets/auth_footer.dart';
import 'widgets/social_auth_row.dart'; // Reusing the one from Register

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.onRegisterTap});

  final VoidCallback? onRegisterTap;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthShell(
      title: '',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        child: Column(
          children: <Widget>[
            const Spacer(flex: 2),
            const AuthHeader(
              title: 'QuickNotes',
              subtitle: 'Capture your thoughts instantly.',
            ),
            const Spacer(flex: 2),
            AuthTextField(
              controller: _emailController,
              label: 'Email',
              hintText: 'name@example.com',
            ),
            const SizedBox(height: 18),
            AuthTextField(
              controller: _passwordController,
              label: 'Password',
              hintText: '••••••••',
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                  color: AppColor.textMuted,
                ),
              ),
            ),
            const SizedBox(height: 20),
            AuthPrimaryButton(
              label: 'Login',
              onPressed: () {
                // Handle Login logic
              },
            ),
            const SizedBox(height: 20),
            const SocialAuthRow(), // Added for consistency with Register
            const SizedBox(height: 20),
            AuthFooter(
              message: "Don't have an account? ",
              actionLabel: 'Register',
              onTap: widget.onRegisterTap ?? () {},
            ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
