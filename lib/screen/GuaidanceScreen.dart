
import 'package:flutter/material.dart';

class ProductIdeaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Product Ideas'),
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
            // Title and Icon
            Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: Colors.purple,
                ),
                SizedBox(width: 8),
                Text(
                  'New Product Ideas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Handle edit action here
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // Image of the product idea
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/laptop_image.jpg'), // Replace with your image path
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(height: 20),

            // Description
            Text(
              'Create a mobile app UI Kit that provides a basic notes functionality but with some improvement.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'There will be a choice to select what kind of notes that user needed, so the experience while taking notes can be unique based on the needs.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 20),

            // Reminder section
            Text(
              'Reminder set on 15/07/2021, 18:30',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),

            // Last edited text
            Text(
              'Last edited on 19.30',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),

            // Footer buttons (Search and Menu)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Handle search action
                  },
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {
                    // Handle more options action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}