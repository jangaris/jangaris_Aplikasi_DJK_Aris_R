import 'package:flutter/material.dart';

import 'KumpulanTugas.dart';

class Formtambahtugas extends StatefulWidget {
  final KumpulanTugas? awal;

  const Formtambahtugas({super.key, this.awal});

  @override
  State<Formtambahtugas> createState() => FormtambahtugasState();
}

class FormtambahtugasState extends State<Formtambahtugas> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController judulText;
  late final TextEditingController mataKuliahText;
  late final TextEditingController tenggatText;
  late final TextEditingController catatanText;

  bool get modeEdit => widget.awal != null;

  @override
  void initState() {
    super.initState();
    final awal = widget.awal;

    judulText = TextEditingController(text: awal?.judul ?? '');
    mataKuliahText = TextEditingController(text: awal?.mataKuliah ?? '');
    tenggatText = TextEditingController(text: awal?.tenggat ?? '');
    catatanText = TextEditingController(text: awal?.catatan ?? '');
  }

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
      appBar: AppBar(title: Text(modeEdit ? 'Edit Tugas' : 'Tambah Tugas')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: ListView(
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
                readOnly: modeEdit,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Mata Kuliah',
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
                  labelText: 'Waktu Tenggat',
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
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Catatan Tugas',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: simpan,
                  child: Text(modeEdit ? 'Simpan Perubahan' : 'Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
