import 'package:flutter/material.dart';

import 'KumpulanTugas.dart';

class Detailpage extends StatelessWidget {
  final KumpulanTugas data;
  const Detailpage({super.key, required this.data});

  Widget baris(String label, String isi) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey, fontSize: 14)),
          SizedBox(height: 4),
          Text(
            isi,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('detail tugas')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            baris('Judul', data.judul),
            baris('MataKuliah', data.mataKuliah),
            baris('Tenggat', data.tenggat),
            if (data.catatan != null) baris('Catatan', data.catatan!),
          ],
        ),
      ),
    );
  }
}
