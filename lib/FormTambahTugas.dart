import 'package:flutter/material.dart';

import 'KumpulanTugas.dart';

class Formtambahtugas extends StatefulWidget {
  const Formtambahtugas({super.key});

  @override
  State<Formtambahtugas> createState() => FormtambahtugasState();
}

class FormtambahtugasState extends State<Formtambahtugas> {
  final formKey = GlobalKey<FormState>();
  final judulText = TextEditingController();
  final mataKuliahText = TextEditingController();
  final tenggatText = TextEditingController();
  final catatanText = TextEditingController();
  @override
  void dispose() {
    judulText.dispose();
    mataKuliahText.dispose();
    tenggatText.dispose();
    catatanText.dispose();
    super.dispose();
  }

  void simpan() {
    if (!formKey.currentState!.validate()) return;
    final baru = KumpulanTugas(
      judul: judulText.text.trim(),
      mataKuliah: mataKuliahText.text.trim(),
      tenggat: tenggatText.text.trim(),
      catatan: catatanText.text.trim().isEmpty ? null : catatanText.text.trim(),
    );
    Navigator.pop(context, baru);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Tugas')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: judulText,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Judul Tugas',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul wajib di isi bang';
                  }
                  if (value.trim().length < 3) {
                    return 'Judul tidak boleh kurang dari 3 karakter';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: mataKuliahText,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'matakuliah',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'matakuliah wajib di isi bang';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: tenggatText,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: 'waktu tenggat',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'waktu wajib di isi bang';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: catatanText,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'catatan Tugas',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(onPressed: simpan, child: Text('simpan')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
