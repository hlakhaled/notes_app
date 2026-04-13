import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/Auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:notes_app/features/notes/data/services/database_service.dart';
import 'package:notes_app/features/notes/presentation/manager/notes_cubit/notes_cubit.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:notes_app/core/theme/app_color.dart';
import 'package:notes_app/core/theme/app_styles.dart';
import 'package:notes_app/features/Auth/presentation/views/register_screen.dart';
import 'package:notes_app/features/notes/presentation/views/widgets/force_update_dialog.dart';
import 'package:notes_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(hours: 1),
      minimumFetchInterval: const Duration(seconds: 10),
    ),
  );

  await remoteConfig.setDefaults({"min_version": "1.0.0"});

  await remoteConfig.fetchAndActivate();

  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = packageInfo.version;

  final minVersion = remoteConfig.getString('min_version');

  final needUpdate = _isLowerVersion(currentVersion, minVersion);
  print(
    "Current Version: $currentVersion, Min Version: $minVersion, Need Update: $needUpdate",
  );
  runApp(NotesApp(needUpdate: needUpdate));
}

bool _isLowerVersion(String current, String min) {
  final c = current.split('.').map(int.parse).toList();
  final m = min.split('.').map(int.parse).toList();

  for (int i = 0; i < 3; i++) {
    if (c[i] < m[i]) return true;
    if (c[i] > m[i]) return false;
  }
  return false;
}

class NotesApp extends StatelessWidget {
  final bool needUpdate;

  const NotesApp({super.key, required this.needUpdate});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotesCubit>(create: (_) => NotesCubit(DatabaseService())),
        BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
      ],
      child: MaterialApp(
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
        home: ForceUpdateWrapper(
          needUpdate: needUpdate,
          child: const RegisterScreen(),
        ),
      ),
    );
  }
}

class ForceUpdateWrapper extends StatefulWidget {
  final bool needUpdate;
  final Widget child;

  const ForceUpdateWrapper({
    super.key,
    required this.needUpdate,
    required this.child,
  });

  @override
  State<ForceUpdateWrapper> createState() => _ForceUpdateWrapperState();
}

class _ForceUpdateWrapperState extends State<ForceUpdateWrapper> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.needUpdate) {
        ForceUpdateDialog.show(
          context: context,
          packageName: "com.example.notes_app",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
