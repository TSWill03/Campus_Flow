// Signature: dev.tswicolly03

import 'package:flutter/material.dart';
import 'package:google_sign_in_web/web_only.dart' as google_web;

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
    if (isLoading || !enabled) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: null,
          icon: const Icon(Icons.g_mobiledata_rounded),
          label: const Text('Continuar com Google'),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: Center(
        child: google_web.renderButton(
          configuration: google_web.GSIButtonConfiguration(
            type: google_web.GSIButtonType.standard,
            theme: google_web.GSIButtonTheme.outline,
            size: google_web.GSIButtonSize.large,
            text: google_web.GSIButtonText.continueWith,
            shape: google_web.GSIButtonShape.pill,
            logoAlignment: google_web.GSIButtonLogoAlignment.left,
            minimumWidth: 320,
            locale: 'pt_BR',
          ),
        ),
      ),
    );
  }
}
