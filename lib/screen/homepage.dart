import 'package:flutter/material.dart';
import 'SearchPage.dart';
import '../model/note_model.dart';

class HomePage extends StatelessWidget {
  final List<NoteModel> notes;

  const HomePage({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // Subtle background

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,

        title: const Text("My Notes", style: TextStyle(color: Colors.black)),

        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),

            onPressed: () {
              // DATA PASSING TO SEARCH PAGE (via Top Icon)

              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) => SearchPage(notesList: notes),
                ),
              );
            },
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 20),

                child: Text(
                  "Pinned Notes",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),

                child: SizedBox(
                  height: 380,

                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: notes.length, // RECEIVED LIST SIZE
                    separatorBuilder: (_, __) => const SizedBox(width: 5),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 280,
                        child: _IdeaCard(note: notes[index]), // PASSING DATA
                      );
                    },
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 25, left: 20),
                child: Text(
                  "Interesting Idea",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: SizedBox(
                  height: 290,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: notes.length, // RECEIVED LIST SIZE
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 260,
                        child: ProductIdeaCard(
                          note: notes[index],
                        ), // PASSING DATA
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IdeaCard extends StatelessWidget {
  final NoteModel note; // Receive note data

  const _IdeaCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              note.title, // Use title from list
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          if (note.imageUrl != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  note.imageUrl!,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              note.description, // Use description from list
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, color: Color(0xFF6B6B6B)),
            ),
          ),

          const Spacer(),

          // Button code same rahega...
        ],
      ),
    );
  }
}

class ProductIdeaCard extends StatelessWidget {
  final NoteModel note;
  const ProductIdeaCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6CC),
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Text(note.description, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
