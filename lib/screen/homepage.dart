import 'dart:io';
import 'package:flutter/material.dart';
import '../model/note_model.dart';
import 'BuyingSomeone.dart';
import 'GoalScreen.dart';
import 'GuaidanceScreen.dart';
import 'RoutineTask.dart';
import 'interestingidea.dart';

class HomePage extends StatelessWidget {
  final List<NoteModel> notes;
  const HomePage({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    // 1. Sab categories ko alag alag filter karein
    final guidanceNotes = notes.where((n) => n.category == 'Guidance').toList();
    final routineNotes = notes.where((n) => n.category == 'Routine').toList();
    final goalNotes = notes.where((n) => n.category == 'Goal').toList();
    final buyingNotes = notes.where((n) => n.category == 'Buying').toList();
    final interestingIdeas = notes.where((n) => n.category == 'Idea').toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Pinned Notes
              if (guidanceNotes.isNotEmpty) ...[
                _buildSectionTitle("Pinned Notes"),
                _buildHorizontalList(guidanceNotes, isIdeaCard: true),
              ],

              // Section 2: Routine Tasks
              if (routineNotes.isNotEmpty) ...[
                _buildSectionTitle("Routine Tasks"),
                _buildHorizontalList(routineNotes, isIdeaCard: false),
              ],

              // Section 3: Goal Tasks
              if (goalNotes.isNotEmpty) ...[
                _buildSectionTitle("Goal Tasks"),
                _buildHorizontalList(goalNotes, isIdeaCard: false),
              ],

              // Section 4: Buying Something (Monthly Needs wala data yahan aayega)
              if (buyingNotes.isNotEmpty) ...[
                _buildSectionTitle("Buying Something"), // Title Change kiya
                _buildHorizontalList(buyingNotes, isIdeaCard: false),
              ],

              // Section 5: Interesting Ideas
              if (interestingIdeas.isNotEmpty) ...[
                _buildSectionTitle("Interesting Idea"),
                _buildHorizontalList(interestingIdeas, isIdeaCard: false),
              ],

              // Empty State
              if (notes.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: Center(child: Text("No notes yet!", style: TextStyle(color: Colors.grey))),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 20),
      child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildHorizontalList(List<NoteModel> list, {required bool isIdeaCard}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
        height: isIdeaCard ? 380 : 260,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            return SizedBox(
              width: isIdeaCard ? 280 : 240,
              child: isIdeaCard
                  ? _IdeaCard(note: list[index]) // Image wala card (Pinned ke liye)
                  : ProductIdeaCard(note: list[index]), // Simple card (Baki sab ke liye)
            );
          },
        ),
      ),
    );
  }
}

// Note: _IdeaCard aur ProductIdeaCard widgets mein Image.file logic lazmi add rakhein.

// Baki _IdeaCard aur ProductIdeaCard widgets ka code same rahega...
// (Jo image support aur card style humne pehle fix kiya tha)

// Note: _IdeaCard aur ProductIdeaCard widgets mein Image.file logic lazmi add rakhein.

// Baki _IdeaCard aur ProductIdeaCard widgets ka code same rahega...
// (Jo image support aur card style humne pehle fix kiya tha)

class _IdeaCard extends StatelessWidget {
  final NoteModel note;
  const _IdeaCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateToEditScreen(context, note);
      },
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 16, offset: const Offset(0, 6)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(note.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            if (note.imageUrl != null && note.imageUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: note.imageUrl!.startsWith('http')
                      ? Image.network(note.imageUrl!, height: 120, width: double.infinity, fit: BoxFit.cover)
                      : Image.file(File(note.imageUrl!), height: 120, width: double.infinity, fit: BoxFit.cover),
                ),
              ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(note.description, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, color: Color(0xFF6B6B6B))),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class ProductIdeaCard extends StatelessWidget {
  final NoteModel note;
  const ProductIdeaCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateToEditScreen(context, note);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF6CC), // Yellow card style for items/buying
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(note.description, maxLines: 4, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

void _navigateToEditScreen(BuildContext context, NoteModel note) {
  Widget screen;
  switch (note.category) {
    case 'Idea':
      screen = Interestingidea(note: note);
      break;
    case 'Buying':
      screen = BuyingSomethingScreen(note: note);
      break;
    case 'Goal':
      screen = GoalsScreen(note: note);
      break;
    case 'Routine':
      screen = SubNotesScreen(note: note);
      break;
    case 'Guidance':
      screen = ProductIdeaScreen(note: note);
      break;
    default:
      return;
  }
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}