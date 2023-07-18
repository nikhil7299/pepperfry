import 'package:flutter/foundation.dart' show immutable;
import 'enums.dart';

@immutable
class AuthMessage {
  final AuthResult authResult;
  final String message;
  const AuthMessage({
    required this.authResult,
    required this.message,
  });
}
