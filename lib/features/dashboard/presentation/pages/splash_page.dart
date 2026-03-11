import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        context.go('/dashboard');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.secondary,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.school_rounded,
                size: 82,
                color: theme.colorScheme.onPrimary,
              ),
              const SizedBox(height: 20),
              Text(
                'CampusFlow',
                style: theme.textTheme.displaySmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Organizacao academica offline-first',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
                ),
              ),
              const SizedBox(height: 28),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
