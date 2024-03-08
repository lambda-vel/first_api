import 'package:flutter/material.dart';
import 'package:jaad_first_api/home_page.dart';

void main() {
  runApp(const FirstAPI());
}

class FirstAPI extends StatefulWidget {
  const FirstAPI({super.key});

  @override
  State<FirstAPI> createState() => _FirstAPIState();
}

class _FirstAPIState extends State<FirstAPI> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First API',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}