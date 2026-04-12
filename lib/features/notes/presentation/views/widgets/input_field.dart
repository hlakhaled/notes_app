import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/app_color.dart';
import 'package:notes_app/core/theme/app_styles.dart';

class NoteInputField extends StatelessWidget {
  const NoteInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines,
    this.expands = false,
    this.textAlignVertical,
  });

  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  final bool expands;
  final TextAlignVertical? textAlignVertical;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      expands: expands,
      textAlignVertical: textAlignVertical,
      style: AppStyles.inputText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyles.inputHintLarge,
        filled: true,
        fillColor: AppColor.white,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColor.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColor.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColor.primary, width: 1.4),
        ),
      ),
    );
  }
}
