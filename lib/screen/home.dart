import 'package:flutter/material.dart';
import 'FinishedPage.dart';
import 'SearchPage.dart';
import 'SettingsPage.dart';
import 'fabscreen.dart';
import 'homepage.dart';
import '../model/note_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final List<NoteModel> allNotes = [
    NoteModel(
      title: "New Product Idea Design",
      description: "Create a mobile app UI Kit that provide a basic notes functionality but with some improvement.",
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
      category: "yes"

    ),
    NoteModel(
      title: "Architecture",
      description: "Decide between Bloc or Riverpod for the upcoming note-taking application.",
        category: "yes"
    ),

    NoteModel(
      title: "📝 Grocery List",
      description: "Milk, Bread, Butter, and some fruits for the week.",
        category: "yes"

    ),

    NoteModel(
      title: "🛠 Backend Setup",
      description: "Configure MongoDB Atlas and setup Express routes for the job portal.",
        category: "yes"

    ),

    NoteModel(
      title: "Mongoose Database",
      description: "Configure MongoDB Atlas and setup Express routes for the job portal.",
        category: "yes"

    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(notes: allNotes),

      const FinishedPage(),

      SearchPage(notesList: allNotes),

      SettingsPage(),
    ];

    return Scaffold(
      extendBody: true,

      resizeToAvoidBottomInset: false,

      body: IndexedStack(index: currentIndex, children: pages),

      // HomeScreen.dart Scaffold ke andar
      floatingActionButton: FloatingActionButton(
        heroTag: null, // optional but safe

        backgroundColor: const Color(0xFF7B4DFF),

        shape: const CircleBorder(),

        onPressed: () {
          Navigator.push(
            context,

            MaterialPageRoute(builder: (context) => Fabscreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

/// BOTTOM NAV BAR

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,

    required this.currentIndex,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,

      shape: const CircularNotchedRectangle(),

      notchMargin: 8.0,

      clipBehavior: Clip
          .antiAlias, // Fix: Notch ki boundaries ko smooth aur fix rakhta hai

      child: Container(
        height: 64,

        padding: const EdgeInsets.symmetric(horizontal: 10),

        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceAround, // Space handle karne ka behtar tareeka

          children: [
            // Left Side
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  BottomNavItem(
                    icon: Icons.home_filled,

                    label: 'Home',

                    isActive: currentIndex == 0,

                    onTap: () => onTap(0),
                  ),

                  BottomNavItem(
                    icon: Icons.check_box_outlined,

                    label: 'Finished',

                    isActive: currentIndex == 1,

                    onTap: () => onTap(1),
                  ),
                ],
              ),
            ),

            const SizedBox(
              width: 40,
            ), // FAB Gap - Isay adjust kar ke check karein
            // Right Side
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  BottomNavItem(
                    icon: Icons.search,

                    label: 'Search',

                    isActive: currentIndex == 2,

                    onTap: () => onTap(2),
                  ),

                  BottomNavItem(
                    icon: Icons.settings,

                    label: 'Settings',

                    isActive: currentIndex == 3,

                    onTap: () => onTap(3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;

  final String label;

  final bool isActive;

  final VoidCallback onTap;

  const BottomNavItem({
    super.key,

    required this.icon,

    required this.label,

    required this.isActive,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? const Color(0xFF7B4DFF) : Colors.grey;

    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(20),

      child: Column(
        mainAxisSize: MainAxisSize.min,

        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Icon(icon, color: color, size: 26),

          const SizedBox(height: 2),

          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
