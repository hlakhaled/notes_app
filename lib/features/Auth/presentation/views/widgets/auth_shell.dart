import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/app_color.dart';
import 'package:notes_app/core/theme/app_styles.dart';

class AuthShell extends StatelessWidget {
  const AuthShell({
    super.key,
    required this.title,
    required this.child,
    this.actions,
  });

  final String title;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: AppStyles.appBarTitle),
        actions: actions,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: AppColor.surface,
          child: child,
        ),
      ),
    );
  }
}
