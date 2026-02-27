import 'package:flutter/material.dart';
import '../model/note_model.dart';
import '../widget/note_card.dart';

class SearchPage extends StatefulWidget {
  final List<NoteModel> notesList; // Parent (HomeScreen/HomePage) se aane wala data

  const SearchPage({super.key, required this.notesList});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<NoteModel> _filteredResults = [];

  @override
  void initState() {
    super.initState();
    // Shuru mein filtered list ko original list ke barabar rakhein
    _filteredResults = widget.notesList;
  }

  // Jab parent widget update ho (e.g. naya data aaye), toh results refresh hon
  @override
  void didUpdateWidget(covariant SearchPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.notesList != widget.notesList) {
      _runSearch(_searchController.text);
    }
  }

  void _runSearch(String query) {
    final String cleanQuery = query.toLowerCase().trim();

    setState(() {
      if (cleanQuery.isEmpty) {
        // Agar search box khali hai toh poori list dikhao
        _filteredResults = widget.notesList;
      } else {
        // Filter logic: Title aur Description dono ko check karein
        _filteredResults = widget.notesList.where((note) {
          final String title = note.title.toLowerCase();
          final String desc = note.description.toLowerCase();
          return title.contains(cleanQuery) || desc.contains(cleanQuery);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: _runSearch,
          decoration: const InputDecoration(
            hintText: 'Search notes...',
            border: InputBorder.none,
          ),
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _searchController.clear();
                _runSearch(''); // UI reset karein
              },
            )
        ],
      ),
      body: _filteredResults.isEmpty
          ? _buildEmptyOrNoResultView()
          : _buildListView(),
    );
  }

  Widget _buildEmptyOrNoResultView() {
    bool isSearching = _searchController.text.isNotEmpty;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSearching ? Icons.search_off : Icons.note_outlined,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              isSearching
                  ? "No results found for '${_searchController.text}'"
                  : "No notes available to search.",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: _filteredResults.length,
      itemBuilder: (context, index) {
        return NoteCard(note: _filteredResults[index]);
      },
    );
  }
}