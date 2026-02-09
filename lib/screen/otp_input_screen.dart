import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../widget/primary_button.dart';
import '../routes/app_routes.dart';

class OtpInputScreen extends StatefulWidget {
  const OtpInputScreen({super.key});

  @override
  State<OtpInputScreen> createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OtpInputScreen> {
  TextEditingController otpController = TextEditingController();
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
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

            /// 🔹 PIN CODE FIELD
            PinCodeTextField(
              appContext: context,
              length: 4,
              controller: otpController,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              enableActiveFill: true,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: 60,
                fieldWidth: 60,
                activeColor: const Color(0xFF6B3FA0),
                inactiveColor: Colors.grey.shade300,
                selectedColor: const Color(0xFF6B3FA0),
                activeFillColor: Colors.white,
                inactiveFillColor: Colors.grey.shade100,
                selectedFillColor: Colors.white,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              onChanged: (value) {
                setState(() {
                  currentText = value;
                });
              },
              onCompleted: (value) {
                debugPrint("OTP Entered: $value");
              },
            ),

            const SizedBox(height: 32),

            /// 🔹 SUBMIT BUTTON
            PrimaryButton(
              text: 'Submit',
              onPressed: () {
                if (currentText.length == 4) {
                  Navigator.pushNamed(context, AppRoutes.otpVerifying);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter complete OTP')),
                  );
                }
              },
            ),

            const SizedBox(height: 16),

            Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.green, size: 18),
                SizedBox(width: 8),
                Text(
                  'Please check your email again',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),

            const Spacer(),

            Center(
              child: TextButton(
                onPressed: () {
                  // Resend OTP logic
                },
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
