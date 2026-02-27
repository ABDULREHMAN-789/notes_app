
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/note_model.dart'; // Apna path check kar lein



class Interestingidea extends StatefulWidget {
  final NoteModel? note;
  const Interestingidea({super.key, this.note});

  @override
  _InterestingideaState createState() => _InterestingideaState();
}

class _InterestingideaState extends State<Interestingidea> {
  late TextEditingController titleController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?.title ?? 'New Product Ideas');
    descController = TextEditingController(text: widget.note?.description ?? '');
  }

  void _saveToHive() async {
    if (titleController.text.isNotEmpty) {
      final newNote = NoteModel(
        title: titleController.text,
        description: descController.text,
        category: 'Idea',
        tags: widget.note?.tags, // Preserve tags if any
        checklist: widget.note?.checklist,
        imageUrl: widget.note?.imageUrl,
      );

      var box = Hive.box<NoteModel>('notes_box');
      
      if (widget.note != null) {
        // Update existing note
        await box.put(widget.note!.key, newNote);
      } else {
        // Create new note
        await box.add(newNote);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interesting Idea'),
        backgroundColor: Colors.purple,
        actions: [IconButton(icon: Icon(Icons.check), onPressed: _saveToHive)], // Save button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: InputDecoration(hintText: 'Idea Title', border: InputBorder.none),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descController,
              maxLines: null,
              decoration: InputDecoration(hintText: 'Describe your idea...', border: InputBorder.none),
            ),
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



