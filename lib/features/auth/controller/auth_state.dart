import 'package:flutter/foundation.dart' show immutable;
import 'package:pepperfry/core/enums.dart';

@immutable
class AuthState {
  final AuthStatus? status;
  final bool isLoading;

  const AuthState({
    required this.status,
    required this.isLoading,
  });

  const AuthState.unknown()
      : status = null,
        isLoading = false;

  AuthState copiedWithIsLoading(bool isLoading) =>
      AuthState(status: status, isLoading: isLoading);

  @override
  String toString() => 'AuthState (AuthStatus: $status, isLoading: $isLoading)';

  // objects can be different, even if their value inside is same,
  // identical checks if the objects are pointing to the same memory location
  // If not, we check if the internal values of objects are same or not

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (status == other.status && isLoading == other.isLoading);

  @override
  int get hashCode => Object.hash(
        status,
        isLoading,
      );
}
