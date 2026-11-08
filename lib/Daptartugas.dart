import 'package:flutter/material.dart';

import 'KumpulanTugas.dart';
import 'detailpage.dart';
import 'FormTambahTugas.dart';

class Daptartugas extends StatefulWidget {
  const Daptartugas({super.key});

  @override
  State<Daptartugas> createState() => DaptartugasState();
}

class DaptartugasState extends State<Daptartugas> {
  final List<KumpulanTugas> data = [
    KumpulanTugas(
      judul: 'baca book',
      mataKuliah: 'TIK',
      tenggat: '8-10-2055',
      catatan: 'semoga bisa dapat uang book',
    ),
    KumpulanTugas(
      judul: 'baca program',
      mataKuliah: 'malas',
      tenggat: '8-10-2055',
      catatan: 'semoga bisa dapat uang malas',
    ),
    KumpulanTugas(
      judul: 'baca kurumi',
      mataKuliah: 'Anime',
      tenggat: '8-10-2055',
      catatan: 'semoga bisa dapat kurumi',
    ),
  ];
  Future<void> bukaFromTambah() async {
    final hasil = await Navigator.push<KumpulanTugas>(
      context,
      MaterialPageRoute(builder: (_) => Formtambahtugas()),
    );
    if (hasil != null) {
      setState(() {
        data.add(hasil);
      });
    }
  }

  void bukaDetail(KumpulanTugas Judul) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => Detailpage(data: Judul)),
    );
  }

  void hapus(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("kompirmasi hapus"),
          content: Text('yakin mau hapus "${data[index].judul} "?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  data.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text("hapus", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void editDialog(int index) {
    final indexTugas = data[index];
    TextEditingController judulController = TextEditingController(
      text: indexTugas.judul,
    );
    TextEditingController mataKuliahController = TextEditingController(
      text: indexTugas.mataKuliah,
    );
    TextEditingController tenggatController = TextEditingController(
      text: indexTugas.tenggat,
    );
    TextEditingController catatanController = TextEditingController(
      text: indexTugas.catatan,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("kompirmasi edit"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: judulController,
                  decoration: InputDecoration(labelText: "Judul Tugas"),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: mataKuliahController,
                  decoration: InputDecoration(labelText: "Mata Kuliah"),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: tenggatController,
                  decoration: InputDecoration(labelText: "Tenggat Waktu"),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: catatanController,
                  decoration: InputDecoration(labelText: "Catatan"),
                  maxLines: 2, // Biar kotaknya agak luas untuk catatan
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("batal edit"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  data[index] = KumpulanTugas(
                    judul: judulController.text,
                    mataKuliah: mataKuliahController.text,
                    tenggat: tenggatController.text,
                    catatan: catatanController.text,
                  );
                });
                Navigator.of(context).pop();
              },
              child: Text("ubah data"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daptar Tugas (${data.length})')),
      body: data.isEmpty
          ? const Center(
              child: Text('Belum ada tugas. Tekan tombol Tambah Tugas.'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final indexTugas = data[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      indexTugas.judul,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text('MataKuliah : ${indexTugas.mataKuliah}'),
                        Text('Tenggat : ${indexTugas.tenggat}'),
                        Text('Catatan : ${indexTugas.catatan}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => editDialog(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => hapus(index),
                          tooltip: 'Hapus Tugas',
                        ),
                        IconButton(
                          icon: Icon(Icons.chevron_right),
                          onPressed: () => bukaDetail(indexTugas),
                          tooltip: 'Lihat Detail',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: bukaFromTambah,
        icon: Icon(Icons.add),
        label: Text('TambahJadwal'),
      ),
    );
  }
}
