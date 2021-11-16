// To parse this JSON data, do
//
//     final kelas = kelasFromJson(jsonString);

import 'dart:convert';

Kelas kelasFromJson(String str) => Kelas.fromJson(json.decode(str));

String kelasToJson(Kelas data) => json.encode(data.toJson());

class Kelas {
  Kelas({
    required this.pengajarId,
    required this.nama,
    required this.jumlahSantri,
    required this.kelasId,
    required this.pengajar,
  });

  final String pengajarId;
  final String nama;
  final int jumlahSantri;
  final String kelasId;
  final String pengajar;

  factory Kelas.fromJson(Map<String, dynamic> json) => Kelas(
    pengajarId: json["pengajar_id"],
    nama: json["nama"],
    jumlahSantri: json["jumlah_santri"],
    kelasId: json["kelas_id"],
    pengajar: json["pengajar"],
  );

  Map<String, dynamic> toJson() => {
    "pengajar_id": pengajarId,
    "nama": nama,
    "jumlah_santri": jumlahSantri,
    "kelas_id": kelasId,
    "pengajar": pengajar,
  };

  static blankKelas() => Kelas(pengajarId: "-", nama: "-", jumlahSantri: 0, kelasId: "-", pengajar: "-");
}
