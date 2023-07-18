import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pepperfry/core/loading_screen.dart';
import 'package:pepperfry/features/admin/admin_view.dart';
import 'package:pepperfry/features/auth/controller/auth_controller.dart';
import 'package:pepperfry/features/auth/view/auth_splash_view.dart';
import 'package:pepperfry/features/home/view/home_view.dart';
import 'package:pepperfry/state_logger.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      observers: [StateLogger()],
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(authStateProvider.notifier).setAuthUser();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pepperfry',
      home: Consumer(
        builder: (context, ref, child) {
          ref.listen<bool>(isLoadingProvider, (_, isLoading) {
            if (isLoading) {
              LoadingScreen.instance().show(context: context);
            } else {
              LoadingScreen.instance().hide();
            }
          });
          final isLoggedIn = ref.watch(isLoggedInProvider);
          final isAdmin = ref.watch(isAdminProvider);
          return isLoggedIn
              ? isAdmin
                  ? const AdminView()
                  : const HomeView()
              : const AuthSplashView();
        },
      ),
    );
  }
}
