import 'package:finova/views/Auth_view/screen/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finova/providers/auth_state_provider.dart';
import 'package:finova/providers/shared_preference_provider.dart';
import 'package:finova/views/Auth_view/screen/create_acct_screen.dart';
import 'package:finova/views/Auth_view/screen/error_screen.dart';
import 'package:finova/views/Auth_view/screen/login_screen.dart';
import 'package:finova/views/dashboard_view/Screen/dashboard_screen.dart';

class AuthWrapperScreen extends ConsumerWidget {
  const AuthWrapperScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final firebaseAuthState = ref.watch(authStateChangesProvider);
    final hasOpenedBeforeState = ref.watch(hasOpenedBeforeProvider);

    return firebaseAuthState.when(
      data: (firebaseUser) {
        if (firebaseUser != null) {
          return DashboardScreen(); 
        } else {
          return hasOpenedBeforeState.when(
            data: (hasOpened) {
              if (!hasOpened) {
                return CreateAcctScreen();
              } else {
                return LoginScreen();
              }
            },
            loading:
                () => const LoadingScreen(
                  message: "Loading app state...",
                ), // Loading the "hasOpenedBefore" flag
            error:
                (error, stackTrace) => ErrorScreen(
                  "App State Error: ${error.toString()}",
                ), // Error fetching "hasOpenedBefore"
          );
        }
      },
      loading:
          () => const LoadingScreen(
            message: "Checking authentication...",
          ), // Loading Firebase auth state
      error:
          (error, stackTrace) => ErrorScreen(
            "Auth Error: ${error.toString()}",
          ), // Error with Firebase auth stream
    );
  }
}

