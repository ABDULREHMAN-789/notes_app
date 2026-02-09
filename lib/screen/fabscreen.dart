import 'package:flutter/material.dart';
import 'package:notes_app/screen/BuyingSomeone.dart';
import 'package:notes_app/screen/GoalScreen.dart';
import 'GuaidanceScreen.dart';
import 'RoutineTask.dart';
import 'interestingidea.dart';

class Fabscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Notes'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What Do You Want to Notes?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Interestingidea()),
                );
              },
              child: NoteOption(
                color: Colors.purple,
                icon: Icons.lightbulb_outline,
                title: 'Interesting Idea',
                subtitle: 'Use free text area, feel free to write it all',
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push
                  (context, MaterialPageRoute(builder: (context) => BuyingSomethingScreen()));
              },
              child: NoteOption(
                color: Colors.green,
                icon: Icons.shopping_cart,
                title: 'Buying Something',
                subtitle: 'Use checklist, so you won\'t miss anything',
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push
                  (context, MaterialPageRoute(builder: (context) => GoalsScreen()));
              },
              child: NoteOption(
                color: Colors.orange,
                icon: Icons.tablet,
                title: 'Goals',
                subtitle: 'Near/future goals, notes and keep focus',
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push
                  (context, MaterialPageRoute(builder: (context) => ProductIdeaScreen()));
              },
              child: NoteOption(
                color: Colors.red,
                icon: Icons.schedule,
                title: 'Guidance',
                subtitle: 'Create guidance for routine activities',
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push
                  (context, MaterialPageRoute(builder: (context) => SubNotesScreen()));
              },
              child: NoteOption(
                color: Colors.yellow,
                icon: Icons.check_box,
                title: 'Routine Tasks',
                subtitle: 'Checklist with sub-checklist',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoteOption extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;

  const NoteOption({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: color,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
