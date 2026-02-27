import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart'; // Permanent save ke liye
import 'package:path/path.dart' as p; // Path handle karne ke liye
import '../model/note_model.dart';

class ProductIdeaScreen extends StatefulWidget {
  final NoteModel? note;
  const ProductIdeaScreen({super.key, this.note});

  @override
  _ProductIdeaScreenState createState() => _ProductIdeaScreenState();
}

class _ProductIdeaScreenState extends State<ProductIdeaScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;

  String? _mediaPath;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?.title ?? 'New Product Ideas');
    descController = TextEditingController(text: widget.note?.description ?? '');
    _mediaPath = widget.note?.imageUrl;
  }

  // 1. Media pick karne ka function
  Future<void> _pickMedia() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        _mediaPath = file.path;
      });
    }
  }

  // 2. Image ko permanent folder mein save karne ka logic
  Future<String> _saveImagePermanently(String temporaryPath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = p.basename(temporaryPath);
    final permanentFile = File('${directory.path}/$name');

    // File copy karke naya permanent path return karein
    try {
      final savedImage = await File(temporaryPath).copy(permanentFile.path);
      return savedImage.path;
    } catch (e) {
      return temporaryPath; // Fallback if copy fails or file already exists/read-only
    }
  }

  // 3. Hive mein data save karne ka function
  void _saveToHive() async {
    if (titleController.text.isNotEmpty) {
      String? finalImagePath = _mediaPath;

      // Agar image pick ki hai (aur wo nayi temporary file hai) toh usay pehle permanent save karein
      // Logic: If _mediaPath is different from original note's path OR original note didn't exist
      if (_mediaPath != null && (widget.note == null || _mediaPath != widget.note!.imageUrl)) {
         // Only save permanently if it looks like a temporary path or changed. 
         // For simplicity, we just try to save it if it's not null.
         // But if it's already a permanent path from previous save, we might act redundantly but safely.
         // Actually, typically image picker gives temp path. Saved notes have app doc dir path.
         if (!_mediaPath!.contains('app_flutter')) { // Rough check if it's not already in app data
            finalImagePath = await _saveImagePermanently(_mediaPath!);
         }
      }

      final newNote = NoteModel(
        title: titleController.text,
        description: descController.text,
        category: 'Guidance',
        imageUrl: finalImagePath,
        checklist: widget.note?.checklist,
        tags: widget.note?.tags,
      );

      var box = Hive.box<NoteModel>('notes_box');
      
      if (widget.note != null) {
        await box.put(widget.note!.key, newNote);
      } else {
        await box.add(newNote);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product Ideas'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveToHive,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.lightbulb_outline, color: Colors.purple),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: titleController,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            GestureDetector(
              onTap: _pickMedia,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  image: _mediaPath != null
                      ? DecorationImage(
                      image: FileImage(File(_mediaPath!)),
                      fit: BoxFit.cover
                  )
                      : null,
                ),
                child: _mediaPath == null
                    ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo, size: 50, color: Colors.purple),
                    Text("Tap to add Image/Video", style: TextStyle(color: Colors.purple)),
                  ],
                )
                    : null,
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: descController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Enter your guidance description here...',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Reminder set on 15/07/2021, 18:30',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            const Text(
              'Last edited on 19.30',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}