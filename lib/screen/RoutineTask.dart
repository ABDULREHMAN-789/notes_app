
import 'package:flutter/material.dart';

class SubNotesScreen extends StatefulWidget {
  @override
  _SubNotesScreenState createState() => _SubNotesScreenState();
}

class _SubNotesScreenState extends State<SubNotesScreen> {
  // List of active and completed sub-notes
  List<Map<String, dynamic>> activeSubNotes = [
    {'title': 'Title Here', 'description': 'Create a mobile app UI Kit that provide a basic notes functionality but with some improvement...', 'isCompleted': false},
    {'title': 'Title Here', 'description': 'Create a mobile app UI Kit that provide a basic notes functionality but with some improvement...', 'isCompleted': false},
  ];

  List<Map<String, dynamic>> completedSubNotes = [
    {'title': 'Title Here', 'description': 'Create a mobile app UI Kit that provide a basic notes functionality but with some improvement...', 'isCompleted': true},
    {'title': 'Title Here', 'description': 'Create a mobile app UI Kit that provide a basic notes functionality but with some improvement...', 'isCompleted': true},
  ];

  // Function to add new sub-note (for demonstration)
  void _addSubNote() {
    setState(() {
      activeSubNotes.add({
        'title': 'Title Here',
        'description': 'Create a mobile app UI Kit that provide a basic notes functionality but with some improvement...',
        'isCompleted': false,
      });
    });
  }

  // Function to toggle the completion status of a sub-note
  void _toggleCompletion(int index, bool isCompleted) {
    setState(() {
      if (isCompleted) {
        completedSubNotes[index]['isCompleted'] = !isCompleted;
        activeSubNotes.add(completedSubNotes[index]);
        completedSubNotes.removeAt(index);
      } else {
        activeSubNotes[index]['isCompleted'] = !isCompleted;
        completedSubNotes.add(activeSubNotes[index]);
        activeSubNotes.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Notes'),
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
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _addSubNote,
                child: Text('+    Add Sub Notes',style: TextStyle(
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
            Text(
              'Active Sub Notes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            SizedBox(height: 10),

            // Display active sub-notes
            Expanded(
              child: ListView.builder(
                itemCount: activeSubNotes.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: Checkbox(
                        value: activeSubNotes[index]['isCompleted'],
                        onChanged: (value) {
                          _toggleCompletion(index, activeSubNotes[index]['isCompleted']);
                        },
                      ),
                      title: Text(activeSubNotes[index]['title']),
                      subtitle: Text(activeSubNotes[index]['description']),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            activeSubNotes.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            // Completed Sub Notes Section
            SizedBox(height: 20),
            Text(
              'Completed Sub Notes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 10),

            // Display completed sub-notes
            Expanded(
              child: ListView.builder(
                itemCount: completedSubNotes.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: Checkbox(
                        value: completedSubNotes[index]['isCompleted'],
                        onChanged: (value) {
                          _toggleCompletion(index, completedSubNotes[index]['isCompleted']);
                        },
                      ),
                      title: Text(completedSubNotes[index]['title']),
                      subtitle: Text(completedSubNotes[index]['description']),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            completedSubNotes.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            // Footer with last edit and search
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Last edited on 19:30',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // Search functionality can be added
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.more_horiz),
                      onPressed: () {
                        // Handle more options
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}