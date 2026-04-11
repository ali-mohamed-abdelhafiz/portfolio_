import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/theme_cubit.dart';

class NavBar extends StatelessWidget {
  final VoidCallback onHeroTap;
  final VoidCallback onAboutTap;
  final VoidCallback onSkillsTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const NavBar({
    super.key,
    required this.onHeroTap,
    required this.onAboutTap,
    required this.onSkillsTap,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state;
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 24 : 12,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Logo or Name
          Flexible(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: onHeroTap,
                child: Text(
                  'Ali Mohamed',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: isDesktop ? 24 : 18,
                    color: Theme.of(context).primaryColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          if (isDesktop)
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    _NavTextButton(title: 'About', onTap: onAboutTap),
                    _NavTextButton(title: 'Skills', onTap: onSkillsTap),
                    _NavTextButton(title: 'Projects', onTap: onProjectsTap),
                    _NavTextButton(title: 'Contact', onTap: onContactTap),
                  ],
                ),
              ),
            ),
          if (!isDesktop) const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              if (!isDesktop) ...[
                const SizedBox(width: 8),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.menu),
                  onSelected: (value) {
                    switch (value) {
                      case 'Hero':
                        onHeroTap();
                        break;
                      case 'About':
                        onAboutTap();
                        break;
                      case 'Skills':
                        onSkillsTap();
                        break;
                      case 'Projects':
                        onProjectsTap();
                        break;
                      case 'Contact':
                        onContactTap();
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'Hero', child: Text('Home')),
                    const PopupMenuItem(value: 'About', child: Text('About')),
                    const PopupMenuItem(value: 'Skills', child: Text('Skills')),
                    const PopupMenuItem(
                      value: 'Projects',
                      child: Text('Projects'),
                    ),
                    const PopupMenuItem(
                      value: 'Contact',
                      child: Text('Contact'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _NavTextButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _NavTextButton({required this.title, required this.onTap});

  @override
  _NavTextButtonState createState() => _NavTextButtonState();
}

class _NavTextButtonState extends State<_NavTextButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
              color: isHovered
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.bodyLarge?.color,
            ),
            child: Text(widget.title),
          ),
        ),
      ),
    );
  }
}
