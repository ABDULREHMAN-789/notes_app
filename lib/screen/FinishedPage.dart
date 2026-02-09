
import 'package:flutter/material.dart';


class FinishedPage extends StatelessWidget {
  const FinishedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EEFD),
      body: Column(
        children: [
          _HeaderSection(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: NoteCard(
                        title: "💡 New Product\nIdea Design",
                        description:
                        "Create a mobile app UI kit that provides a basic notes functionality but with some improvement...",
                        imagePath: "https://cdn-icons-png.flaticon.com/512/11525/11525102.png",
                        label: "Interesting Idea",
                        labelColor: Colors.purple,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: NoteCard(
                        title: "🛒 Monthly Buy\nList",
                        checklistItems: ["Item 1", "Item 2", "Item 3", "Item 4"],
                        label: "Interesting Idea",
                        labelColor: Colors.orange,
                        backgroundColor: const Color(0xFFFFF1C0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                NoteCard(
                  title: "💡 New Product\nIdea Design",
                  subNotes: [
                    "Sub notes 1 Title",
                    "Sub notes 2 Title",
                    "Sub notes 3 Title",
                    "Sub notes 4 Title",
                  ],
                  label: "Interesting Idea",
                  labelColor: Colors.pink,
                  backgroundColor: const Color(0xFFFDE5EB),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
      decoration: const BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Amazing Journey!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'You have successfully finished 5 notes',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.network(
              'https://cdn-icons-png.flaticon.com/256/12257/12257607.png',
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class NoteCard extends StatefulWidget {
  final String title;
  final String? description;
  final String? imagePath;
  final List<String>? checklistItems;
  final List<String>? subNotes;
  final String label;
  final Color labelColor;
  final Color backgroundColor;

  const NoteCard({
    super.key,
    required this.title,
    this.description,
    this.imagePath,
    this.checklistItems,
    this.subNotes,
    required this.label,
    required this.labelColor,
    required this.backgroundColor,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  late List<bool> checkedList;

  @override
  void initState() {
    super.initState();
    checkedList =
        List.filled(widget.checklistItems?.length ?? 0, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          if (widget.imagePath != null) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.imagePath!,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ],

          if (widget.description != null) ...[
            const SizedBox(height: 10),
            Text(
              widget.description!,
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ],

          if (widget.checklistItems != null) ...[
            const SizedBox(height: 10),
            ...widget.checklistItems!
                .asMap()
                .entries
                .map((entry) {
              int index = entry.key;
              String item = entry.value;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          checkedList[index] = !checkedList[index];
                        });
                      },
                      child: Icon(
                        checkedList[index]
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],

          if (widget.subNotes != null) ...[
            const SizedBox(height: 10),
            ...widget.subNotes!.map(
                  (note) => Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(note),
              ),
            ),
          ],

          const SizedBox(height: 10),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: widget.labelColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.label,
              style: TextStyle(
                color: widget.labelColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

  