import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/app_styles.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: AppStyles.screenTitle),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: AppStyles.screenSubtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}