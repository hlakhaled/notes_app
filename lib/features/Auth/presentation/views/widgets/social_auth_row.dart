import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/app_color.dart';
import 'package:notes_app/core/theme/app_styles.dart';

class SocialAuthRow extends StatelessWidget {
  const SocialAuthRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const <Widget>[
            Expanded(child: Divider(color: AppColor.divider, thickness: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'OR CONTINUE WITH',
                style: AppStyles.dividerLabel,
              ),
            ),
            Expanded(child: Divider(color: AppColor.divider, thickness: 1)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            Expanded(
              child: _SocialButton(
                backgroundColor: AppColor.white,
                borderColor: AppColor.borderSoft,
                icon: const Text('G', style: AppStyles.googleLetter),
                label: 'Google',
                labelColor: AppColor.textPrimary,
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SocialButton(
                backgroundColor: AppColor.facebookBlue,
                borderColor: AppColor.facebookBlue,
                icon: const Icon(
                  Icons.facebook,
                  size: 18,
                  color: AppColor.white,
                ),
                label: 'Facebook',
                labelColor: AppColor.white,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.backgroundColor,
    required this.borderColor,
    required this.icon,
    required this.label,
    required this.labelColor,
    required this.onPressed,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Widget icon;
  final String label;
  final Color labelColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            const SizedBox(width: 8),
            Text(label, style: AppStyles.socialLabel.copyWith(color: labelColor)),
          ],
        ),
      ),
    );
  }
}