import 'package:flutter/material.dart';
import 'package:pomotask/home/home_view.dart';
import 'package:pomotask/reminder/reminder_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    ReminderRepository().getReminders();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomotask',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffFBFAED),
        primaryColor: const Color(0xffFBFAED),
        highlightColor: const Color(0xffFBFAED),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffFBFAED),
          foregroundColor: Colors.black,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffFBFAED),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}
