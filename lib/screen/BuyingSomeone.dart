import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/note_model.dart';

class BuyingSomethingScreen extends StatefulWidget {
  final NoteModel? note;
  const BuyingSomethingScreen({super.key, this.note});

  @override
  _BuyingSomethingScreenState createState() => _BuyingSomethingScreenState();
}

class _BuyingSomethingScreenState extends State<BuyingSomethingScreen> {
  late TextEditingController titleController;
  late Map<String, bool> items;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?.title ?? 'Monthly Needs');
    if (widget.note?.checklist != null) {
      items = Map<String, bool>.from(widget.note!.checklist!);
    } else {
      items = {
        'A box of instant noodles': false,
        '3 box of coffee': false,
      };
    }
  }

  void _addItem() {
    setState(() {
      items['New item ${items.length + 1}'] = false;
    });
  }

  void _saveToHive() async {
    if (titleController.text.isNotEmpty) {
      final newNote = NoteModel(
        title: titleController.text,
        description: items.keys.join(", "),
        category: 'Buying',
        checklist: items,
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
        title: const Text('Buying Something'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(icon: const Icon(Icons.check), onPressed: _saveToHive)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(border: InputBorder.none),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: items.keys.map((String key) {
                  return CheckboxListTile(
                    title: Text(key),
                    value: items[key],
                    activeColor: Colors.green,
                    onChanged: (bool? value) {
                      setState(() {
                        items[key] = value!;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            TextButton.icon(
              onPressed: _addItem,
              icon: const Icon(Icons.add, color: Colors.green),
              label: const Text('Add checkbox', style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      ),
    );
  }
}