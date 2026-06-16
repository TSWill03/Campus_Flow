// Signature: dev.tswicolly03

import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    super.key,
    required this.enabled,
    required this.isLoading,
    required this.onPressed,
  });

  final bool enabled;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: isLoading || !enabled ? null : onPressed,
        icon: const Icon(Icons.g_mobiledata_rounded),
        label: const Text('Continuar com Google'),
      ),
    );
  }
}
