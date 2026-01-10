import 'package:flutter/material.dart';
import '../widget/otp_input_boxes.dart';
import '../widget/primary_button.dart';
import '../routes/app_routes.dart';

class OtpInputScreen extends StatelessWidget {
  const OtpInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
        title: const Text(
          'Back to Login',
          style: TextStyle(color: Color(0xFF6B3FA0)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            const Text(
              'Input Code',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please input the code you received on email',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),

            const OtpInputBoxes(),

            const SizedBox(height: 32),

            PrimaryButton(
              text: 'Submit',
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.otpVerifying);
              },
            ),

            const SizedBox(height: 16),

            Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.green, size: 18),
                SizedBox(width: 8),
                Text(
                  'Please check your email again,  has been sent',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),

            const Spacer(),

            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Don't receive any code? Resend",
                  style: TextStyle(color: Color(0xFF6B3FA0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
