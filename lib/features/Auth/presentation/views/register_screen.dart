import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/theme/app_color.dart';
import 'package:notes_app/core/theme/app_styles.dart';
import 'package:notes_app/features/Auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:notes_app/features/Auth/presentation/manager/auth_visibility_cubit.dart';
import 'package:notes_app/features/Auth/presentation/views/login_screen.dart';
import 'package:notes_app/features/notes/presentation/views/create_note_screen.dart';

import 'widgets/auth_primary_button.dart';
import 'widgets/auth_shell.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/profile_image_picker.dart';
import 'widgets/social_auth_row.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register() {
    context.read<AuthCubit>().register(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthVisibilityCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Account created successfully')),
            );

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const CreateNoteScreen(),
              ),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<AuthVisibilityCubit, bool>(
          builder: (context, obscurePassword) {
            return AuthShell(
              title: '',
              actions: const <Widget>[],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        'Create Account',
                        style: AppStyles.screenTitle,
                      ),
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
                        obscureText: obscurePassword,
                        suffixIcon: IconButton(
                          onPressed: () =>
                              context.read<AuthVisibilityCubit>().toggle(),
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 18,
                            color: AppColor.textMuted,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// REGISTER BUTTON
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const CircularProgressIndicator();
                          }

                          return AuthPrimaryButton(
                            label: 'Register',
                            onPressed: _register,
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      const SocialAuthRow(),

                      const SizedBox(height: 40),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Already have an account? ',
                            style: AppStyles.screenSubtitle,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Login',
                              style: AppStyles.linkText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}