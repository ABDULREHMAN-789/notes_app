import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/note_model.dart';

class SubNotesScreen extends StatefulWidget {
  final NoteModel? note;
  const SubNotesScreen({super.key, this.note});

  @override
  _SubNotesScreenState createState() => _SubNotesScreenState();
}

class _SubNotesScreenState extends State<SubNotesScreen> {
  List<Map<String, dynamic>> activeSubNotes = [];
  List<Map<String, dynamic>> completedSubNotes = [];

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _parseDescription(widget.note!.description);
    } else {
      activeSubNotes = [
        {'title': 'Morning Exercise', 'description': '30 mins workout', 'isCompleted': false},
        {'title': 'Read a Book', 'description': 'Read at least 10 pages', 'isCompleted': false},
      ];
    }
  }

  void _parseDescription(String desc) {
    try {
      List<String> parts = desc.split(" | Done: ");
      String activePart = parts.isNotEmpty ? parts[0] : "";
      String completedPart = parts.length > 1 ? parts[1] : "";

      if (activePart.isNotEmpty) {
        activeSubNotes = activePart.split(", ").where((t) => t.trim().isNotEmpty).map((t) {
          String title = t.replaceAll("[ ] ", "").trim();
          return {'title': title, 'description': '', 'isCompleted': false};
        }).toList();
      }

      if (completedPart.isNotEmpty) {
        completedSubNotes = completedPart.split(", ").where((t) => t.trim().isNotEmpty).map((t) {
          String title = t.replaceAll("[x] ", "").trim();
          return {'title': title, 'description': '', 'isCompleted': true};
        }).toList();
      }
    } catch (e) {
      // Fallback if parsing fails
      activeSubNotes = [{'title': 'Error parsing tasks', 'description': desc, 'isCompleted': false}];
    }
  }

  void _addSubNote() {
    setState(() {
      activeSubNotes.add({
        'title': 'New Task',
        'description': 'Description here...',
        'isCompleted': false,
      });
    });
  }

  void _toggleCompletion(int index, bool currentlyCompleted) {
    setState(() {
      if (currentlyCompleted) {
        var note = completedSubNotes.removeAt(index);
        note['isCompleted'] = false;
        activeSubNotes.add(note);
      } else {
        var note = activeSubNotes.removeAt(index);
        note['isCompleted'] = true;
        completedSubNotes.add(note);
      }
    });
  }

  void _saveToHive() async {
    String allTasks = activeSubNotes.map((s) => "[ ] ${s['title']}").join(", ") +
        (completedSubNotes.isNotEmpty ? " | Done: " + completedSubNotes.map((s) => "[x] ${s['title']}").join(", ") : "");

    final newNote = NoteModel(
      title: "Routine Tasks",
      description: allTasks,
      category: 'Routine',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routine Tasks'),
        backgroundColor: Colors.purple,
        actions: [IconButton(icon: const Icon(Icons.check), onPressed: _saveToHive)],
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('+  Add Sub Notes', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Active Sub Notes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: activeSubNotes.length,
                itemBuilder: (context, index) {
                  return _buildNoteItem(index, activeSubNotes, false);
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Completed Sub Notes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: completedSubNotes.length,
                itemBuilder: (context, index) {
                  return _buildNoteItem(index, completedSubNotes, true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteItem(int index, List<Map<String, dynamic>> list, bool isDone) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isDone ? Colors.green.shade50 : Colors.yellow.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDone ? Colors.green.shade200 : Colors.yellow.shade200),
      ),
      child: ListTile(
        leading: Checkbox(
          value: list[index]['isCompleted'],
          activeColor: Colors.green,
          onChanged: (value) => _toggleCompletion(index, isDone),
        ),
        title: Text(list[index]['title'], style: TextStyle(fontWeight: FontWeight.bold, decoration: isDone ? TextDecoration.lineThrough : null)),
        subtitle: Text(list[index]['description']),
        trailing: IconButton(
          icon: const Icon(Icons.close, color: Colors.redAccent),
          onPressed: () => setState(() => list.removeAt(index)),
        ),
      ),
    );
  }
}