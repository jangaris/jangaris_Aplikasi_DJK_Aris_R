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
  Future<void> bukaFormTambah() async {
    final hasil = await Navigator.push<KumpulanTugas>(
      context,
      MaterialPageRoute(builder: (_) => Formtambahtugas(awal: null)),
    );
    if (hasil != null) {
      setState(() {
        data.add(hasil);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tugas sudah di tambahkan!')),
        );
      });
    }
  }

  Future<void> bukaFormEdit(int index) async {
    final hasil = await Navigator.push<KumpulanTugas>(
      context,
      MaterialPageRoute(builder: (_) => Formtambahtugas(awal: data[index])),
    );
    if (hasil != null) {
      setState(() {
        data[index] = hasil;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Tugas sudah di edit!')));
      });
    }
  }

  void bukaDetail(KumpulanTugas Judul) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => Detailpage(data: Judul)),
    );
  }

  Future<void> hapus(int index) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("kompirmasi hapus"),
          content: Text('yakin mau hapus "${data[index].judul} "?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("hapus", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
    if (yakin == true && mounted) {
      setState(() {
        data.removeAt(index);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Tugas sudah dihapus!')));
      });
    }
  }

  void hapusSemua() {
    if (data.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tugas sudah kosong, tidak ada yang bisa dihapus!'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi Hapus Semua"),
          content: const Text("Yakin ingin menghapus seluruh daftar tugas? "),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  data.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tugas sudah di hapus semua!'),
                    ),
                  );
                });
                Navigator.of(context).pop();
              },
              child: const Text(
                "Hapus Semua",
                style: TextStyle(color: Colors.red),
              ),
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
                          onPressed: () => bukaFormEdit(index),
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Tombol Tambah Tugas
          FloatingActionButton.extended(
            onPressed: bukaFormTambah,
            icon: Icon(Icons.add),
            label: Text('Tambah Tugas'),
          ),

          SizedBox(width: 12),
          // Tombol Hapus Semua
          FloatingActionButton.extended(
            onPressed: hapusSemua,
            icon: Icon(Icons.delete_sweep),
            label: Text('Hapus Semua'),
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
