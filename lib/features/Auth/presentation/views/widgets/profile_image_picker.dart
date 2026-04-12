import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/app_color.dart';

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.accentTint,
              border: Border.all(color: AppColor.borderMuted),
            ),
            child: const Icon(
              Icons.person,
              size: 40,
              color: AppColor.iconMuted,
            ),
          ),
          Positioned(
            right: -2,
            bottom: 2,
            child: Container(
              width: 26,
              height: 26,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primary,
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 14,
                color: AppColor.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}