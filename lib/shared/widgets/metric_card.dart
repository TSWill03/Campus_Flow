import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.subtitle,
    this.color,
    this.progress,
  });

  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color? color;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedColor = color ?? theme.colorScheme.primary;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: resolvedColor.withValues(alpha: 0.12),
              foregroundColor: resolvedColor,
              child: Icon(icon),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(value, style: theme.textTheme.headlineSmall),
            if (subtitle != null) ...[
              const SizedBox(height: 6),
              Text(
                subtitle!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (progress != null) ...[
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: progress!.clamp(0, 1),
                minHeight: 8,
                borderRadius: BorderRadius.circular(999),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
