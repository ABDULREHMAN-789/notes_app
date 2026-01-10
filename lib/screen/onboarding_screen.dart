import 'package:flutter/material.dart';
import '../model/onboarding_data.dart';
import '../routes/app_routes.dart';
import '../widget/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingData> pages = [
    OnboardingData(
      image: 'assets/images/image.png',
      title:
      'Jot Down anything you want to achieve, today or in the future',
      buttonText: "Let's Get Started",
    ),
    OnboardingData(
      image: 'assets/images/onboarding2.png',
      title: 'Different goals, different way to jot it down.',
      buttonText: 'Next',
    ),
    OnboardingData(
      image: 'assets/images/onboarding3.png',
      title:
      'Text area, checklist, or some combination. Adapt with your needs',
      buttonText: 'Proceed to Login',
    ),
  ];

  void _nextPage() {
    if (_currentIndex < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.otpInput,
      );
    }
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B3FA0),
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          itemCount: pages.length,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          itemBuilder: (context, index) {
            return OnboardingPage(
              data: pages[index],
              currentIndex: _currentIndex,
              total: pages.length,
              onNext: _nextPage,
              onPrevious: _previousPage,
              showPrevious: index != 0,
            );
          },
        ),
      ),
    );
  }
}
