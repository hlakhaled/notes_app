import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/theme/app_color.dart';
import 'package:notes_app/features/Auth/data/services/auth_service.dart';
import 'package:notes_app/features/Auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:notes_app/features/Auth/presentation/manager/auth_visibility_cubit.dart';
import 'package:notes_app/features/Auth/presentation/views/register_screen.dart';
import 'package:notes_app/features/notes/presentation/views/create_note_screen.dart';

import 'widgets/auth_primary_button.dart';
import 'widgets/auth_shell.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/auth_header.dart';
import 'widgets/auth_footer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    context.read<AuthCubit>().login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthVisibilityCubit(),
      child: Builder(
        builder: (context) {
          return BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login successful!')),
                );

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const CreateNoteScreen()),
                );
              } else if (state is AuthError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: BlocBuilder<AuthVisibilityCubit, bool>(
              builder: (context, obscurePassword) {
                return AuthShell(
                  title: '',
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                    child: Column(
                      children: [
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
                          obscureText: obscurePassword,
                          suffixIcon: IconButton(
                            onPressed: () =>
                                context.read<AuthVisibilityCubit>().toggle(),
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 18,
                              color: AppColor.textMuted,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return const CircularProgressIndicator();
                            }

                            return AuthPrimaryButton(
                              label: 'Login',
                              onPressed: _login,
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        AuthFooter(
                          message: "Don't have an account? ",
                          actionLabel: 'Register',
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const RegisterScreen(),
                              ),
                            );
                          },
                        ),

                        const Spacer(flex: 5),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
