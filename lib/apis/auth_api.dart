import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pepperfry/constants/app_constants.dart';
import 'package:pepperfry/core/auth_message.dart';
import 'package:pepperfry/core/enums.dart';
import 'package:pepperfry/features/auth/controller/auth_controller.dart';
import 'package:http/http.dart' as http;
import 'package:pepperfry/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authAPIProvider = Provider((ref) {
  return AuthAPI(
    ref: ref,
  );
});

class AuthAPI {
  final Ref _ref;
  const AuthAPI({required Ref ref}) : _ref = ref;

  Future<bool> setAuthUser(String? token) async {
    final url = '$uri/';
    try {
      http.Response res = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );
      res.body.log();
      if (res.statusCode == 200) {
        _ref.read(userInfoStateProvider.notifier).setUser(jsonEncode(
              jsonDecode(res.body)['user'],
            ));
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<AuthResult> checkUser(String phone) async {
    final url = '$uri/auth/checkUser';
    try {
      http.Response res = await http.post(
        Uri.parse(url),
        body: jsonEncode(
          {
            'phone': phone,
          },
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      'check ${res.statusCode}'.log();
      switch (res.statusCode) {
        case 201:
          return AuthResult(
            authStatus: AuthStatus.success,
            message: jsonDecode(res.body)['msg'],
          );
        case 401:
          return AuthResult(
            authStatus: AuthStatus.failure,
            message: jsonDecode(res.body)['msg'],
          );

        default:
          return AuthResult(
            authStatus: AuthStatus.error,
            message: jsonDecode(res.body)['error'],
          );
      }
    } catch (e) {
      ' error ${e.toString()}'.log();
      return const AuthResult(
        authStatus: AuthStatus.success,
        message: "Unexpected Error Occured",
      );
    }
  }

  Future<AuthResult> verifyPhone(
      {required String phone, required String otp}) async {
    final url = '$uri/auth/verifyPhone';
    final prefs = await SharedPreferences.getInstance();
    try {
      http.Response res = await http.post(
        Uri.parse(url),
        body: jsonEncode(
          {'phone': phone, 'otp': otp},
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      'res status code ${res.statusCode}'.log();
      switch (res.statusCode) {
        case 200:
          _ref.read(userInfoStateProvider.notifier).setUser(jsonEncode(
                jsonDecode(res.body)['user'],
              ));
          prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          return AuthResult(
            authStatus: AuthStatus.success,
            message: jsonDecode(res.body)['msg'],
          );
        case 400:
          return AuthResult(
            authStatus: AuthStatus.failure,
            message: jsonDecode(res.body)['msg'],
          );

        default:
          return AuthResult(
            authStatus: AuthStatus.error,
            message: jsonDecode(res.body)['error'],
          );
      }
    } catch (e) {
      return const AuthResult(
        authStatus: AuthStatus.success,
        message: 'Unexpected Error Occured',
      );
    }
  }

  Future<AuthResult> signUpUser({
    required String phone,
    required String otp,
    required String name,
    required String email,
  }) async {
    final url = '$uri/auth/signUpUser';
    final prefs = await SharedPreferences.getInstance();
    try {
      http.Response res = await http.post(
        Uri.parse(url),
        body: jsonEncode(
            {'phone': phone, 'otp': otp, 'name': name, 'email': email}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      switch (res.statusCode) {
        case 200:
          //msg - Logged In Successfully
          _ref.read(userInfoStateProvider.notifier).setUser(jsonEncode(
                jsonDecode(res.body)['user'],
              ));
          prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          return AuthResult(
            authStatus: AuthStatus.success,
            message: jsonDecode(res.body)['msg'],
          );
        case 400:
          //msg - OTP Incorrect, Please try again | User with this Email already exists
          return AuthResult(
            authStatus: AuthStatus.failure,
            message: jsonDecode(res.body)['msg'],
          );

        default:
          return AuthResult(
            authStatus: AuthStatus.error,
            message: jsonDecode(res.body)['error'],
          );
      }
    } catch (e) {
      return const AuthResult(
        authStatus: AuthStatus.error,
        message: "Unexpected Error Occured",
      );
    }
  }
}
