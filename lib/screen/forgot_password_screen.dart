import 'package:flutter/material.dart';
import '../widget/primary_button.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
              'Forgot Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Insert your email address to receive a code for creating a new password',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),

            const Text('Email Address'),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'example@email.com',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 32),

            PrimaryButton(
              text: 'Send Code',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
