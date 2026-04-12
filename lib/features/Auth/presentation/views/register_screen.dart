import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/app_color.dart';
import 'package:notes_app/core/theme/app_styles.dart';

import 'widgets/auth_primary_button.dart';
import 'widgets/auth_shell.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/profile_image_picker.dart';
import 'widgets/social_auth_row.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, this.onLoginTap});

  final VoidCallback? onLoginTap;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}


class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthShell(
      title: '',
      actions: const <Widget>[],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        child: Column(
          children: <Widget>[
            const Spacer(flex: 1),
            const Text('Create Account', style: AppStyles.screenTitle),
            const SizedBox(height: 6),
            const Text(
              'Start organizing your thoughts today.',
              style: AppStyles.screenSubtitle,
            ),
            const SizedBox(height: 18),
            const ProfileImagePicker(),
            const SizedBox(height: 26),
            AuthTextField(
              controller: _nameController,
              label: 'Name',
              hintText: 'Full Name',
            ),
            const SizedBox(height: 16),
            AuthTextField(
              controller: _emailController,
              label: 'Email',
              hintText: 'Email Address',
            ),
            const SizedBox(height: 16),
            AuthTextField(
              controller: _passwordController,
              label: 'Password',
              hintText: 'Password',
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 18,
                  color: AppColor.textMuted,
                ),
              ),
            ),
            const SizedBox(height: 20),
            AuthPrimaryButton(label: 'Register', onPressed: () {}),
            const Spacer(flex: 1),
            const SocialAuthRow(),
            const Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Already have an account? ',
                  style: AppStyles.screenSubtitle,
                ),
                GestureDetector(
                  onTap: widget.onLoginTap,
                  child: const Text('Login', style: AppStyles.linkText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
