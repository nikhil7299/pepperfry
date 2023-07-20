import 'package:flutter/foundation.dart' show immutable;
import 'enums.dart';

@immutable
class AuthResult {
  final AuthStatus authStatus;
  final String message;
  const AuthResult({
    required this.authStatus,
    required this.message,
  });
}
