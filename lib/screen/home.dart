import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

  @override
  Widget build(BuildContext context) {
    // 1. Hive Box ko access karein
    var notesBox = Hive.box<NoteModel>('notes_box');

    return ValueListenableBuilder(
      // 2. Database mein tabdeeli ko listen karein
      valueListenable: notesBox.listenable(),
      builder: (context, Box<NoteModel> box, _) {
        // 3. Database se live data hasil karein
        List<NoteModel> allNotes = box.values.toList();

        final List<Widget> pages = [
          HomePage(notes: allNotes), // Live data HomePage ko pass ho raha hai
          const FinishedPage(),
          SearchPage(notesList: allNotes),
           SettingsPage(),
        ];

        return Scaffold(
          extendBody: true, // Transparent bottom bar effect ke liye
          resizeToAvoidBottomInset: false, // Keyboard open hone par FAB jump nahi karega
          body: IndexedStack(
            index: currentIndex,
            children: pages,
          ),

          // Floating Action Button
          floatingActionButton: FloatingActionButton(
            heroTag: "main_fab", // Hero animation issue fix karne ke liye
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
      },
    );
  }
}

/// --------------------
/// CUSTOM BOTTOM NAV BAR
/// --------------------
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
      clipBehavior: Clip.antiAlias, // Notch ki boundaries ko smooth rakhta hai
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Left Side Items
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

            const SizedBox(width: 40), // FAB ke liye gap

            // Right Side Items
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

/// --------------------
/// BOTTOM NAV ITEM WIDGET
/// --------------------
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