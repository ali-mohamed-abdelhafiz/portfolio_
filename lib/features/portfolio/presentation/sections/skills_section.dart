import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  final List<Map<String, dynamic>> skills = const [
    {'name': 'Flutter', 'icon': Icons.flutter_dash},
    {'name': 'Dart', 'icon': Icons.code},
    {'name': 'Firebase', 'icon': Icons.local_fire_department, 'isFa': false},
    {'name': 'REST APIs', 'icon': Icons.api, 'isFa': false},
    {'name': 'Git & GitHub', 'icon': FontAwesomeIcons.github, 'isFa': true},
    {'name': 'Problem Solving', 'icon': Icons.lightbulb_outline, 'isFa': false},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : size.width * 0.1,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'My Skills',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: isMobile ? 32 : 40,
                    ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 1,
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                ),
              ),
            ],
          ).animate().fade(duration: 600.ms).slideX(begin: -0.1),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: skills.map((skill) {
              return SkillCard(
                name: skill['name'] as String,
                icon: skill['icon'],
                isFa: skill['isFa'] ?? false,
              ).animate(delay: 200.ms).fade().scale();
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class SkillCard extends StatefulWidget {
  final String name;
  final dynamic icon;
  final bool isFa;

  const SkillCard({super.key, required this.name, required this.icon, this.isFa = false});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 160,
        height: 140,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                    offset: const Offset(0, 10),
                    blurRadius: 20,
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    offset: const Offset(0, 4),
                    blurRadius: 10,
                  )
                ],
          border: Border.all(
            color: isHovered ? Theme.of(context).primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        transform: isHovered ? Matrix4.translationValues(0.0, -8.0, 0.0) : Matrix4.identity(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.isFa
                ? FaIcon(
                    widget.icon,
                    size: 48,
                    color: isHovered ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyLarge?.color,
                  )
                : Icon(
                    widget.icon,
                    size: 48,
                    color: isHovered ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyLarge?.color,
                  ),
            const SizedBox(height: 16),
            Text(
              widget.name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isHovered ? Theme.of(context).primaryColor : null,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
