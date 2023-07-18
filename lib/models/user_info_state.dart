import 'dart:convert';
import 'package:flutter/foundation.dart' show immutable;
import 'package:pepperfry/core/type_defs.dart';

@immutable
class UserInfoState {
  final UserId userId;
  final Name name;
  final Phone phone;
  final Email email;
  final String type;
  final List<dynamic> cart;
  // final List<dynamic> address;
  // final List<dynamic> wishlist;

  const UserInfoState({
    required this.userId,
    required this.name,
    required this.phone,
    required this.email,
    required this.type,
    required this.cart,
    // required this.address,
    // required this.wishlist,
  });

  @override
  String toString() {
    return '''UserInfoState 
              (UserId: $userId, Name: $name, Phone: $phone)
              (Email: $email, Type: $type, Cart: $cart)''';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoState &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          name == other.name &&
          email == other.email &&
          phone == other.phone;

  @override
  int get hashCode => Object.hash(
        runtimeType,
        userId,
        name,
        email,
        phone,
      );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'name': name});
    result.addAll({'phone': phone});
    result.addAll({'email': email});
    result.addAll({'type': type});
    result.addAll({'cart': cart});
    // result.addAll({'address': address});
    // result.addAll({'wishlist': wishlist});

    return result;
  }

  factory UserInfoState.fromMap(Map<String, dynamic> map) {
    return UserInfoState(
      userId: map['_id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      type: map['type'] ?? '',
      // cart: List<Map<String, dynamic>>.from(
      //   map['cart']?.map(
      //         (x) => Map<String, dynamic>.from(x),
      //       ) ??
      //       {},
      // ),
      cart: List<dynamic>.from(map['cart']),
      // address: List<Map<String, dynamic>>.from(
      //   map['address']?.map(
      //     (x) => Map<String, dynamic>.from(x),
      //   ),
      // ),
      // wishlist: List<Map<String, dynamic>>.from(
      //   map['wishlist']?.map(
      //     (x) => Map<String, dynamic>.from(x),
      //   ),
      // ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfoState.fromJson(String source) =>
      UserInfoState.fromMap(json.decode(source));

  UserInfoState copyWith({
    UserId? userId,
    Name? name,
    Phone? phone,
    Email? email,
    String? type,
    List<dynamic>? cart,
    // List<dynamic>? address,
    // List<dynamic>? wishlist,
  }) {
    return UserInfoState(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      type: type ?? this.type,
      cart: cart ?? this.cart,
      // address: address ?? this.address,
      // wishlist: wishlist ?? this.wishlist,
    );
  }
}
