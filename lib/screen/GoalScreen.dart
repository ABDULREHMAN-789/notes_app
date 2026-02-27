import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/note_model.dart';

class GoalsScreen extends StatefulWidget {
  final NoteModel? note;
  const GoalsScreen({super.key, this.note});

  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  late TextEditingController titleController;

  List<Map<String, dynamic>> tasks = [
    {
      'title': 'Complete Flutter Project',
      'isSelected': false,
      'subtasks': [
        {'name': 'Database Setup', 'isDone': false},
        {'name': 'UI Design', 'isDone': false},
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?.title ?? 'Monthly Goals');
    
    // Note: Parsing complex nested tasks from the string description is difficult 
    // without a structured JSON format. For now, we start with the default list
    // or an empty one if we want.
    if (widget.note != null) {
      // Potentially we could try to parse widget.note!.description, but for now
      // we accept that the structure is reset on edit, as per the plan.
    }
  }

  void _addSubtask(int index) {
    setState(() {
      tasks[index]['subtasks'].add({'name': 'New Subtask', 'isDone': false});
    });
  }

  void _addMainTask() {
    setState(() {
      tasks.add({
        'title': 'New Main Task',
        'isSelected': false,
        'subtasks': [],
      });
    });
  }

  // Hive Save logic
  void _saveToHive() async {
    if (titleController.text.isNotEmpty) {
      // Tasks aur Subtasks ko string mein convert karna display ke liye
      String descriptionText = tasks.map((t) {
        String subs = (t['subtasks'] as List).map((s) => s['name']).join(", ");
        return "${t['title']} (${subs})";
      }).join(" | ");

      final newNote = NoteModel(
        title: titleController.text,
        description: descriptionText,
        category: 'Goal', 
        checklist: {}, 
        imageUrl: widget.note?.imageUrl,
      );

      var box = Hive.box<NoteModel>('notes_box');
      if (widget.note != null) {
         await box.put(widget.note!.key, newNote);
      } else {
         await box.add(newNote);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveToHive,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(border: InputBorder.none),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.tablet, color: Colors.purple),
                const SizedBox(width: 8),
                Text(
                  'Goal Tasks',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Task List loop
            for (int i = 0; i < tasks.length; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxListTile(
                    value: tasks[i]['isSelected'],
                    onChanged: (bool? value) {
                      setState(() => tasks[i]['isSelected'] = value);
                    },
                    title: Text(
                      tasks[i]['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),

                  // Subtasks display
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Column(
                      children: [
                        for (int j = 0; j < tasks[i]['subtasks'].length; j++)
                          CheckboxListTile(
                            value: tasks[i]['subtasks'][j]['isDone'],
                            onChanged: (bool? value) {
                              setState(() => tasks[i]['subtasks'][j]['isDone'] = value);
                            },
                            title: Text(tasks[i]['subtasks'][j]['name']),
                            // FIX: controlType ki jagah controlAffinity
                            controlAffinity: ListTileControlAffinity.leading,
                            dense: true,
                          ),
                      ],
                    ),
                  ),

                  // Add Subtask Button
                  TextButton.icon(
                    onPressed: () => _addSubtask(i),
                    icon: const Icon(Icons.add, color: Colors.purple, size: 20),
                    label: const Text('Add subtask', style: TextStyle(color: Colors.purple)),
                  ),
                  const Divider(),
                ],
              ),

            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: _addMainTask,
                icon: const Icon(Icons.add),
                label: const Text('Add main task'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 30),
            const Text('Tags:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Wrap(
              spacing: 8.0,
              children: [
                _TagChip(label: 'Important'),
                _TagChip(label: 'Top Priority'),
              ],
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
      label: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      backgroundColor: Colors.purple,
    );
  }
}

