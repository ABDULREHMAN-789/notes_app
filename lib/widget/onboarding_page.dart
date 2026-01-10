import 'package:flutter/material.dart';
import '../model/onboarding_data.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  final int currentIndex;
  final int total;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool showPrevious;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.currentIndex,
    required this.total,
    required this.onNext,
    required this.onPrevious,
    required this.showPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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

          const SizedBox(height: 32),

          /// Dots Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              total,
                  (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: currentIndex == index ? 18 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          const Spacer(),

          /// Primary Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.buttonText,
                    style: const TextStyle(
                      color: Color(0xFF6B3FA0),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF6B3FA0),
                    size: 18,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// Previous Button
          if (showPrevious)
            TextButton(
              onPressed: onPrevious,
              child: const Text(
                'Previous',
                style: TextStyle(color: Colors.white70),
              ),
            ),

          const Spacer(),
        ],
      ),
    );
  }
}
