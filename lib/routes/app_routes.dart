import 'package:flutter/material.dart';
import '../screen/onboarding_screen.dart';
import '../screen/otp_input_screen.dart';
import '../screen/otp_verifying_screen.dart';
import '../screen/forgot_password_screen.dart';
import '../screen/splish.dart';

class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const otpInput = '/otp-input';
  static const otpVerifying = '/otp-verifying';
  static const forgotPassword = '/forgot-password';

  static Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    onboarding: (_) => const OnboardingScreen(),
    otpInput: (_) => const OtpInputScreen(),
    otpVerifying: (_) => const OtpVerifyingScreen(),
    forgotPassword: (_) => const ForgotPasswordScreen(),
  };
}
