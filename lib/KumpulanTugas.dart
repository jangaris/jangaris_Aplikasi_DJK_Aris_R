class KumpulanTugas {
  final String judul;
  final String mataKuliah;
  final String tenggat;
  final String? catatan;

  KumpulanTugas({
    required this.judul,
    required this.mataKuliah,
    required this.tenggat,
    this.catatan,
  });
}
