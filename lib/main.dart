import 'package:flutter/material.dart';
import 'package:pomotask/home/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
