import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
                'About Me',
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
          const SizedBox(height: 40),
          Text(
            "Hello! My name is Ali Mohamed, and I am a passionate Flutter Developer. I specialize in building beautiful, highly performant, and responsive natively compiled applications for mobile, web, and desktop from a single codebase.\n\nI am extremely dedicated to continuous learning and implementing the latest best practices in the Flutter ecosystem. From state management mastery to creating smooth seamless micro-animations, I always strive for perfect UI/UX and solid architectural design in every single project.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: isMobile ? 16 : 18,
                  height: 1.6,
                ),
          ).animate(delay: 200.ms).fade(duration: 600.ms).slideY(begin: 0.1),
        ],
      ),
    );
  }
}
