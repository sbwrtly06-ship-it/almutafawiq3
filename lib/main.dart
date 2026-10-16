import 'package:flutter/material.dart';
import 'welcome.dart';

void main() {
  runApp(const AlMutafawiqApp());
}

class AlMutafawiqApp extends StatelessWidget {
  const AlMutafawiqApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'المتفوق',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo', // الخط العربي العام
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: const WelcomeScreen(),
    );
  }
}
