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

  final List<OnboardingData> pages = [
    OnboardingData(
      image: 'assets/images/image.png',
      title: 'Jot Down anything you want to achieve, today or in the future',
      buttonText: "Let's Get Started",
    ),
    OnboardingData(
      image: 'assets/images/onboarding2.png',
      title: 'Different goals, different way to jot it down.',
      buttonText: 'Next',
    ),
    OnboardingData(
      image: 'assets/images/onboarding3.png',
      title: 'Text area, checklist, or some combination. Adapt with your needs',
      buttonText: 'Proceed to Login',
    ),
  ];

  void _nextPage() {
    if (_pageController.page!.toInt() < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.otpInput);
    }
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B3FA0),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double page = _pageController.hasClients ? _pageController.page ?? 0 : 0;
            int currentIndex = page.round();

            return Stack(
              children: [
                /// 1. Swipeable Content
                PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    double opacity = (1 - (page - index).abs()).clamp(0.0, 1.0);
                    return OnboardingPage(
                      data: pages[index],
                      opacity: opacity,
                    );
                  },
                ),

                /// 2. Fixed UI Elements (Dots & Buttons)
                Positioned(
                  bottom: 40,
                  left: 24,
                  right: 24,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Dots Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          pages.length,
                              (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: currentIndex == index ? 18 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: currentIndex == index ? Colors.white : Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      /// Primary Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                pages[currentIndex].buttonText,
                                style: const TextStyle(color: Color(0xFF6B3FA0), fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward, color: Color(0xFF6B3FA0), size: 18),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// Previous Button
                      if (currentIndex != 0)
                        TextButton(
                          onPressed: _previousPage,
                          child: const Text('Previous', style: TextStyle(color: Colors.white70)),
                        )
                      else
                        const SizedBox(height: 48), // Space maintain karne ke liye
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}