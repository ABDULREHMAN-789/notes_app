import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Hive import
import 'package:notes_app/routes/app_routes.dart';
import 'model/note_model.dart'; // Apna model import karein

void main() async {
  // 1. Flutter engine ko initialize karein
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Hive initialize karein
  await Hive.initFlutter();

  // 3. Adapter register karein (ye NoteModel ko database format mein badalta hai)
  Hive.registerAdapter(NoteModelAdapter());

  // 4. Ek box (table) open karein
  await Hive.openBox<NoteModel>('notes_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}