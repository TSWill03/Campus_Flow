import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  bool get isDesktop => MediaQuery.sizeOf(this).width >= 1080;

  bool get isTablet => MediaQuery.sizeOf(this).width >= 720;

  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(this).colorScheme.error,
      ),
    );
  }
}
