
import 'package:flutter/material.dart';
import 'package:notes_app/screen/ChangPassword.dart';
import 'package:notes_app/screen/NotificationScreen.dart';
import 'EditProfile.dart';
import 'onboarding_screen.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile section
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/profile_picture.jpg'), // Replace with your profile image
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Michael Antonio',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'anto_michael@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Edit Profile button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: (){
                  Navigator.push
                    (context, MaterialPageRoute(builder: (context) =>EditProfileScreen()));
                },
                icon: Icon(Icons.edit,color: Colors.white,),
                label: Text('Edit Profile',style: TextStyle(
                  color: Colors.white
                ),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // App Settings Section
            Text(
              'APP SETTINGS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            SizedBox(height: 10),

            // Settings Options
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push
                  (context, MaterialPageRoute(builder: (context) =>ChangePasswordScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.text_fields),
              title: Text('Text Size'),
              subtitle: Text('Medium'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle Text Size Change
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              subtitle: Text('All active'),
              trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  NotificationSettings.show(context); // Bas ye call karein
                }
            ),
            SizedBox(height: 20),

            // Log Out button
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  _showLogOutDialog(context);
                },
                child: const Text('Log Out',style: TextStyle(
                  color: Colors.white
                ),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // App version
            Center(
              child: Text(
                ' Notes v1.1',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



Future<void> _showLogOutDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out from the application?'),
        actions: <Widget>[

          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),

          TextButton(
            onPressed: () {
              Navigator.push
                (context, MaterialPageRoute(builder: (context) =>OnboardingScreen()));
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.purple),
            ),
          ),
        ],
      );
    },
  );
}