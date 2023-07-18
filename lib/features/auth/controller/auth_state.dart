import 'package:flutter/foundation.dart' show immutable;
import 'package:pepperfry/core/enums.dart';

@immutable
class AuthState {
  final AuthResult? result;
  final bool isLoading;

  const AuthState({
    required this.result,
    required this.isLoading,
  });

  const AuthState.unknown()
      : result = null,
        isLoading = false;

  AuthState copiedWithIsLoading(bool isLoading) =>
      AuthState(result: result, isLoading: isLoading);

// objects can be different, even if their value inside is same,
// this makes sure to find if the objects are equal or not
// identical checks if the objects are same, then return true
// and if objects are not same(not same reference)
// we check internal values are same or not and then return true

  @override
  String toString() => 'AuthState (AuthResult: $result, isLoading: $isLoading)';

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result && isLoading == other.isLoading);

  @override
  int get hashCode => Object.hash(
        result,
        isLoading,
      );
}
