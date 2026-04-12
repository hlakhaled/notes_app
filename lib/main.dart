import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/app_color.dart';
import 'package:notes_app/core/theme/app_styles.dart';
import 'package:notes_app/features/Auth/presentation/views/register_screen.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.primarySeed,
          surface: AppColor.surface,
        ),
        scaffoldBackgroundColor: AppColor.surface,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.surface,
          surfaceTintColor: AppColor.transparent,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: AppStyles.appBarTitle,
          iconTheme: IconThemeData(color: AppColor.textPrimary),
        ),
      ),
      home: RegisterScreen(),
      // home: CreateNoteScreen(onSaveNote: _addNote, onViewNotes: _openNotesList),
    );
  }
}
