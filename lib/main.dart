import 'package:flutter/material.dart';

import 'Daptartugas.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Tugas Kuliah',
      home: const Daptartugas(),
      debugShowCheckedModeBanner: false,
    );
  }
}
