import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pepperfry/apis/auth_api.dart';
import 'package:pepperfry/core/enums.dart';
import 'package:pepperfry/core/storage_manager.dart';
import 'package:pepperfry/features/auth/controller/auth_state.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.isLoading;
});

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  // print('${authState.result} ${authState.userId}');
  return authState.status == AuthStatus.success;
});

// ? AUTH STATE
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(
    authAPI: ref.watch(authAPIProvider),
  ),
);

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthAPI _authAPI;

  AuthStateNotifier({
    required AuthAPI authAPI,
  })  : _authAPI = authAPI,
        super(const AuthState.unknown()) {
    StorageManager.readData('x-auth-token').then((token) {
      if (token != null) {
        _authAPI.setAuthUser(token: token).then((res) {
          if (res) {
            state =
                const AuthState(status: AuthStatus.success, isLoading: false);
          }
        });
      }
    });
  }

  Future<bool> checkUser({
    required String phone,
    required BuildContext context,
  }) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    state = state.copiedWithIsLoading(true);
    final authResult = await _authAPI.checkUser(phone: phone);
    state = state.copiedWithIsLoading(false);
    if (authResult.authStatus == AuthStatus.success) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(authResult.message),
        ),
      );
      return true;
    }
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(authResult.message),
      ),
    );

    return false;
  }

  Future<void> verifyPhone({
    required String phone,
    required String otp,
    required BuildContext context,
  }) async {
    final navigator = Navigator.of(context, rootNavigator: true);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    state = state.copiedWithIsLoading(true);
    final authResult = await _authAPI.verifyPhone(phone: phone, otp: otp);

    state = AuthState(status: authResult.authStatus, isLoading: false);
    if (authResult.authStatus == AuthStatus.success) {
      navigator.pop();
    }
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(authResult.message),
      ),
    );
  }

  Future<void> signUpUser({
    required String phone,
    required String otp,
    required String name,
    required String email,
    required BuildContext context,
  }) async {
    final navigator = Navigator.of(context, rootNavigator: true);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    state = state.copiedWithIsLoading(true);
    final authResult = await _authAPI.signUpUser(
      phone: phone,
      otp: otp,
      name: name,
      email: email,
    );
    state = AuthState(status: authResult.authStatus, isLoading: false);
    if (authResult.authStatus == AuthStatus.success) {
      navigator.pop();
    }
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(authResult.message),
      ),
    );
  }
}
