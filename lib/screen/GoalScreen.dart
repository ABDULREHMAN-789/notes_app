
import 'package:flutter/material.dart';


class GoalsScreen extends StatefulWidget {
  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  // List of main tasks and subtasks
  List<Map<String, dynamic>> tasks = [
    {
      'title': 'A box of instant noodles',
      'subtasks': ['Subtask 1', 'Subtask 2'],
    },
    {
      'title': '3 box of coffee',
      'subtasks': ['Subtask 1'],
    },
    {
      'title': '3 box of coffee',
      'subtasks': [],
    },
  ];

  // Function to add a subtask to a task
  void _addSubtask(int taskIndex) {
    setState(() {
      tasks[taskIndex]['subtasks'].add('New Subtask');
    });
  }

  // Function to add a new main task
  void _addMainTask() {
    setState(() {
      tasks.add({
        'title': 'New Task',
        'subtasks': [],
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goals'),
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Icon
              Row(
                children: [
                  Icon(
                    Icons.tablet,
                    color: Colors.purple,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Monthly Needs',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Task List with subtasks
              for (int i = 0; i < tasks.length; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Task Checkbox
                    CheckboxListTile(
                      value: false,
                      onChanged: (bool? value) {},
                      title: Text(tasks[i]['title']),
                    ),
                    // Subtasks
                    for (var subtask in tasks[i]['subtasks'])
                      CheckboxListTile(
                        value: false,
                        onChanged: (bool? value) {},
                        title: Text(subtask),
                      ),
                    // Add Subtask Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () => _addSubtask(i),
                        child: Row(
                          children: [
                            Icon(Icons.add, color: Colors.purple),
                            SizedBox(width: 8),
                            Text(
                              'Add subtask',
                              style: TextStyle(color: Colors.purple),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),

              // Add Main Task Button
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: _addMainTask,
                  child: Row(
                    children: [
                      Icon(Icons.add, color: Colors.purple),
                      SizedBox(width: 8),
                      Text(
                        'Add main task',
                        style: TextStyle(color: Colors.purple),
                      ),
                    ],
                  ),
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

              // Tags section
              Wrap(
                spacing: 8.0, // gap between tags
                runSpacing: 4.0, // gap between rows
                children: [
                  _TagChip(label: 'Important'),
                  _TagChip(label: 'Top Priority'),
                  _TagChip(label: 'Should be Done This Week'),
                ],
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
              SizedBox(height: 20),

              // Footer buttons (Search and Menu)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
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