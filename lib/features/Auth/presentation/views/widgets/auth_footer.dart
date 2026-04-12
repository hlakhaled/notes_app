import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/app_styles.dart';

class AuthFooter extends StatelessWidget {
  final String message;
  final String actionLabel;
  final VoidCallback onTap;

  const AuthFooter({
    super.key,
    required this.message,
    required this.actionLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(message, style: AppStyles.screenSubtitle),
        GestureDetector(
          onTap: onTap,
          child: Text(actionLabel, style: AppStyles.linkText),
        ),
      ],
    );
  }
}