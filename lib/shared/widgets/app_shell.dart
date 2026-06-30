// Signature: dev.tswicolly03

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  static const _items = <_ShellItem>[
    _ShellItem(
      label: 'Dashboard',
      icon: Icons.space_dashboard_rounded,
      path: '/dashboard',
    ),
    _ShellItem(label: 'Perfil', icon: Icons.school_rounded, path: '/profile'),
    _ShellItem(
      label: 'Disciplinas',
      icon: Icons.menu_book_rounded,
      path: '/subjects',
    ),
    _ShellItem(
      label: 'Horas Comp.',
      icon: Icons.verified_rounded,
      path: '/complementary',
    ),
    _ShellItem(
      label: 'Estagios',
      icon: Icons.badge_rounded,
      path: '/internships',
    ),
    _ShellItem(
      label: 'Extensao',
      icon: Icons.groups_rounded,
      path: '/extensions',
    ),
    _ShellItem(label: 'Estudos', icon: Icons.timer_rounded, path: '/study'),
    _ShellItem(
      label: 'Ajustes',
      icon: Icons.settings_rounded,
      path: '/settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final title = _titleFor(location);
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 1080;
        final navigation = _NavigationPanel(
          currentLocation: location,
          items: _items,
        );

        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Beta',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onTertiaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            centerTitle: false,
            elevation: 0,
          ),
          drawer: isWide ? null : Drawer(child: SafeArea(child: navigation)),
          body: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.surface,
                  theme.brightness == Brightness.dark
                      ? theme.colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.55,
                        )
                      : theme.colorScheme.primaryContainer.withValues(
                          alpha: 0.35,
                        ),
                ],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isWide)
                  SizedBox(width: 280, child: SafeArea(child: navigation)),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1280),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: child,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _titleFor(String location) {
    if (location == '/feedback') {
      return 'Feedback';
    }
    for (final item in _items) {
      if (location == item.path || location.startsWith('${item.path}/')) {
        return item.label;
      }
    }
    return 'CampusFlow';
  }
}

class _NavigationPanel extends StatelessWidget {
  const _NavigationPanel({required this.currentLocation, required this.items});

  final String currentLocation;
  final List<_ShellItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.brightness == Brightness.dark
          ? theme.colorScheme.surfaceContainerLow
          : theme.colorScheme.surface,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CampusFlow',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Beta publica',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sua graduacao, horas e estudos em um unico fluxo offline-first.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.88),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, index) => const SizedBox(height: 6),
              itemBuilder: (context, index) {
                final item = items[index];
                final selected =
                    currentLocation == item.path ||
                    currentLocation.startsWith('${item.path}/');

                return ListTile(
                  selected: selected,
                  selectedTileColor: theme.colorScheme.primary.withValues(
                    alpha: 0.08,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  leading: Icon(item.icon),
                  title: Text(item.label),
                  onTap: () {
                    Navigator.of(context).maybePop();
                    context.go(item.path);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ShellItem {
  const _ShellItem({
    required this.label,
    required this.icon,
    required this.path,
  });

  final String label;
  final IconData icon;
  final String path;
}
