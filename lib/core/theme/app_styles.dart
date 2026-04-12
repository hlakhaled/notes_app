import 'package:flutter/material.dart';

import 'app_color.dart';

class AppStyles {
  static const TextStyle appBarTitle = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle screenTitle = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 23,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle screenSubtitle = TextStyle(
    color: AppColor.textMuted,
    fontSize: 12,
  );

  static const TextStyle sectionLabel = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle inputText = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 15,
  );

  static const TextStyle inputHint = TextStyle(
    color: AppColor.textHint,
    fontSize: 14,
  );

  static const TextStyle inputHintLarge = TextStyle(
    color: AppColor.textPlaceholder,
    fontSize: 15,
  );

  static const TextStyle noteTitle = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle noteContent = TextStyle(
    color: AppColor.textBrand,
    fontSize: 14,
    height: 1.25,
  );

  static const TextStyle noteDetailsTitle = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle noteDetailsBody = TextStyle(
    color: AppColor.textSecondary,
    fontSize: 15,
    height: 1.45,
  );

  static const TextStyle noteDetailsMeta = TextStyle(
    color: AppColor.textBrand,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle primaryButton = TextStyle(
    color: AppColor.white,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle bodyText = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 14,
  );

  static const TextStyle bodyMuted = TextStyle(
    color: AppColor.textMuted,
    fontSize: 12,
  );

  static const TextStyle linkText = TextStyle(
    color: AppColor.primary,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle dividerLabel = TextStyle(
    color: AppColor.labelMuted,
    fontSize: 11,
    letterSpacing: 0.6,
  );

  static const TextStyle socialLabel = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle googleLetter = TextStyle(
    color: AppColor.googleBlue,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
}
