import 'dart:ui';
import 'package:flutter/material.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  // Ek static function banaya hai taake call karna asan ho
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5), // Background ko halka kala karne ke liye
      builder: (context) => const NotificationSettings(),
    );
  }

  @override
  _NotificationSettingsDialogState createState() =>
      _NotificationSettingsDialogState();
}

class _NotificationSettingsDialogState extends State<NotificationSettings> {
  bool _emailNotifications = true;
  bool _pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    // BackdropFilter use kiya hai taake background blur ho jaye
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        title: const Text(
          'Notification Settings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email Notifications
            ListTile(
              leading: const Icon(Icons.email, color: Colors.purple),
              title: const Text('Email Notifications'),
              trailing: Switch(
                value: _emailNotifications,
                onChanged: (bool value) {
                  setState(() {
                    _emailNotifications = value;
                  });
                },
                activeColor: Colors.purple,
              ),
            ),
            // Push Notifications
            ListTile(
              leading: const Icon(Icons.notifications_active, color: Colors.purple),
              title: const Text('Push Notifications'),
              trailing: Switch(
                value: _pushNotifications,
                onChanged: (bool value) {
                  setState(() {
                    _pushNotifications = value;
                  });
                },
                activeColor: Colors.purple,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Close', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}