
import 'package:flutter/material.dart';

class Interestingidea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interesting Idea'),
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
            // Title and description
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
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Create a mobile app UI Kit that provides a basic notes functionality but with some improvement.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'There will be a choice to select what kind of notes that user needed, so the experience while taking notes can be unique based on the needs.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 20),

            // Tags section
            Text(
              'Tags:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8.0, // gap between tags
              runSpacing: 4.0, // gap between rows
              children: [
                _TagChip(label: 'Important'),
                _TagChip(label: 'Top Priority'),
                _TagChip(label: 'Should Be Done This Week'),
                _TagChip(label: 'Urgent'),
              ],
            ),
            SizedBox(height: 20),

            // Add task button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Handle Add task logic here
                },
                icon: Icon(Icons.add_task),
                label: Text('Add task'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Last edited text
            Text(
              'Last edited on 19.30',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;

  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.purple,
    );
  }
}