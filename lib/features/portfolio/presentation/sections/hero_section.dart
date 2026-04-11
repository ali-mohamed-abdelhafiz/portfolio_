import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onCheckOutTap;

  const HeroSection({super.key, required this.onCheckOutTap});

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri);
    } catch (e) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 600),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).primaryColor.withValues(alpha: 0.05),
            Theme.of(context).scaffoldBackgroundColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : size.width * 0.1,
        vertical: 80,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
                width: isMobile ? 180 : 250,
                height: isMobile ? 180 : 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isMobile ? 60 : 100),
                    bottomRight: Radius.circular(isMobile ? 60 : 100),
                    topRight: const Radius.circular(10),
                    bottomLeft: const Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.4),
                      blurRadius: 30,
                      spreadRadius: -10,
                      offset: const Offset(10, 10),
                    ),
                  ],
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.8),
                    width: 3,
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  'assets/profile.jpg',
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.person,
                      size: isMobile ? 60 : 80,
                      color: Theme.of(context).primaryColor,
                    );
                  },
                ),
              )
              .animate(delay: 100.ms)
              .fade(duration: 800.ms)
              .scale(begin: const Offset(0.8, 0.8))
              .shimmer(duration: 2.seconds),
          const SizedBox(height: 24),
          Text(
            'Hi, my name is',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: isMobile ? 18 : 24,
              fontWeight: FontWeight.w600,
            ),
          ).animate(delay: 300.ms).fade(duration: 600.ms).slideX(begin: -0.2),
          const SizedBox(height: 16),
          Text(
                'Ali Mohamed.',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isMobile ? 48 : 80,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    Shadow(
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              )
              .animate(delay: 500.ms)
              .fade(duration: 600.ms)
              .slideX(begin: -0.2)
              .shimmer(duration: 2.seconds),
          const SizedBox(height: 16),
          SizedBox(
                height: isMobile ? 60 : 80,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flutter Developer',
                      textStyle: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            fontSize: isMobile ? 32 : 56,
                            color: Theme.of(context).textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.7),
                            fontWeight: FontWeight.bold,
                          ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 1,
                  displayFullTextOnTap: true,
                ),
              )
              .animate(delay: 700.ms)
              .fade(duration: 600.ms)
              .scale(begin: const Offset(0.9, 0.9)),
          const SizedBox(height: 32),
          SizedBox(
            width: isMobile ? double.infinity : size.width * 0.5,
            child: Text(
              'I am actively seeking new opportunities where I can contribute, grow, and deliver high-quality results. I am available for both remote and on-site positions and committed to continuous improvement.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: isMobile ? 16 : 20,
                height: 1.5,
              ),
            ),
          ).animate(delay: 900.ms).fade(duration: 600.ms).slideY(begin: 0.2),
          const SizedBox(height: 48),
          Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  ElevatedButton(
                    onPressed: onCheckOutTap,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      elevation: 10,
                      shadowColor: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.5),
                    ),
                    child: const Text(
                      'Check out my work!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => _launchURL(
                      'https://drive.google.com/drive/folders/1axHapRU2vwj_838B8KlsThV3VgEh1oTa?usp=sharing',
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      'Download CV',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              )
              .animate(delay: 1100.ms)
              .fade(duration: 600.ms)
              .slideY(begin: 0.2)
              .shimmer(delay: 2.seconds, duration: 1.5.seconds),
          const SizedBox(height: 32),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.whatsapp,
                  size: 28,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () => _launchURL('https://wa.me/201551713043'),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.linkedinIn,
                  size: 28,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                onPressed: () => _launchURL(
                  'https://www.linkedin.com/in/ali-mohamed-950215286/?isSelfProfile=true',
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.github,
                  size: 28,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                onPressed: () => _launchURL('https://github.com/AliMoo-space'),
              ),
            ],
          ).animate(delay: 1300.ms).fade(duration: 600.ms).slideY(begin: 0.2),
        ],
      ),
    );
  }
}
