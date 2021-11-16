// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.role,
    required this.codeKelas,
  });

  final String role;
  final String codeKelas;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    role: json["role"],
    codeKelas: json["code_kelas"],
  );

  Map<String, dynamic> toJson() => {
    "role": role,
    "code_kelas": codeKelas,
  };

  static blankProfile() => Profile(role: "-", codeKelas: "-");
}
