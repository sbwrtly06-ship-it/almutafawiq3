import 'package:flutter/material.dart';
import 'home_dashboard.dart';

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
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const HomeDashboardScreen(),
    );
  }
}
