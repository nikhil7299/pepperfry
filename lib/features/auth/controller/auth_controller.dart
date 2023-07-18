import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pepperfry/apis/auth_api.dart';
import 'package:pepperfry/core/enums.dart';
import 'package:pepperfry/features/auth/controller/auth_state.dart';
import 'package:pepperfry/models/user_info_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.isLoading;
});

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  // print('${authState.result} ${authState.userId}');
  return authState.result == AuthResult.success;
});

//? AUTH STATE
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
        super(const AuthState.unknown());

  void setAuthUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('x-auth-token');
    if (token == null) {
      return;
    }
    state = state.copiedWithIsLoading(true);
    final res = await _authAPI.setAuthUser(token);
    if (res) {
      state = const AuthState(result: AuthResult.success, isLoading: false);
      return;
    }

    state = state.copiedWithIsLoading(false);
  }

  Future<bool> checkUser(String identifier, BuildContext context) async {
    //TODO return false- to register user
    // return false;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    state = state.copiedWithIsLoading(true);
    final result = await _authAPI.checkUser(identifier);
    state = state.copiedWithIsLoading(false);
    if (result == AuthResult.success) {
      return true;
    } else if (result == AuthResult.error) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text("Unexpected error occured"),
        ),
      );
    }
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
    final result = await _authAPI.verifyPhone(phone: phone, otp: otp);

    state = AuthState(result: result, isLoading: false);

    switch (result) {
      case AuthResult.success:
        navigator.pop();
        return;
      case AuthResult.failure:
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text("Incorrect OTP, try again"),
          ),
        );
        return;
      default:
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text("Unexpected error occured"),
          ),
        );
    }
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
    final authMessage = await _authAPI.signUpUser(
      phone: phone,
      otp: otp,
      name: name,
      email: email,
    );
    state = AuthState(result: authMessage.authResult, isLoading: false);
    switch (authMessage.authResult) {
      case AuthResult.success:
        navigator.pop();
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(authMessage.message),
          ),
        );
        return;
      case AuthResult.failure:
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(authMessage.message),
          ),
        );
        return;
      default:
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(authMessage.message),
          ),
        );
    }
  }
}

//? USER INFO STATE
final isAdminProvider = Provider((ref) {
  final userInfoState = ref.watch(userInfoStateProvider);
  if (userInfoState == null) {
    return false;
  }
  return userInfoState.type == 'admin';
});

final userInfoStateProvider =
    StateNotifierProvider<UserInfoStateNotifier, UserInfoState?>((ref) {
  return UserInfoStateNotifier();
});

class UserInfoStateNotifier extends StateNotifier<UserInfoState?> {
  UserInfoStateNotifier() : super(null);

  void setUser(String user) {
    state = UserInfoState.fromJson(user);
    print('user mobile ${state!.phone}');
  }

  void setUserFromModel(UserInfoState userInfoState) {
    state = userInfoState;
  }
}
