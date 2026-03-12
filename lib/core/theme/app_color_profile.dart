// Signature: dev.tswicolly03

import 'dart:convert';

import 'package:flutter/material.dart';

class AppColorProfile {
  const AppColorProfile({
    required this.name,
    required this.seedColorValue,
    required this.accentColorValue,
  });

  final String name;
  final int seedColorValue;
  final int accentColorValue;

  Color get seedColor => Color(seedColorValue);

  Color get accentColor => Color(accentColorValue);

  AppColorProfile copyWith({
    String? name,
    int? seedColorValue,
    int? accentColorValue,
  }) {
    return AppColorProfile(
      name: name ?? this.name,
      seedColorValue: seedColorValue ?? this.seedColorValue,
      accentColorValue: accentColorValue ?? this.accentColorValue,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'seedColorValue': seedColorValue,
      'accentColorValue': accentColorValue,
    };
  }

  String toStorageString() => jsonEncode(toJson());

  factory AppColorProfile.fromJson(Map<String, dynamic> json) {
    return AppColorProfile(
      name: json['name'] as String? ?? 'Meu esquema',
      seedColorValue: json['seedColorValue'] as int? ?? 0xFF0F766E,
      accentColorValue: json['accentColorValue'] as int? ?? 0xFFE67E22,
    );
  }

  factory AppColorProfile.fromStorageString(String raw) {
    return AppColorProfile.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
  }

  static const defaultProfile = AppColorProfile(
    name: 'Campus Flow',
    seedColorValue: 0xFF0F766E,
    accentColorValue: 0xFFE67E22,
  );
}
