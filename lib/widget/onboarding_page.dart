import 'package:flutter/material.dart';
import '../model/onboarding_data.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  final double opacity; // Smooth transition ke liye

  const OnboardingPage({
    super.key,
    required this.data,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Spacer(flex: 2),
            /// Illustration
            Image.asset(
              data.image,
              height: 260,
              fit: BoxFit.contain,
            ),
            const Spacer(),
            /// Title
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(flex: 2), // Space for fixed buttons below
          ],
        ),
      ),
    );
  }
}