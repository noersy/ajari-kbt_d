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
    required this.name,
    required this.username,
    required this.password,
    required this.email,
    required this.uid,
    required this.urlImage,
  });

  final String uid;
  final String role;
  final String email;
  final String name;
  final String username;
  final String password;
  final String codeKelas;
  final String urlImage;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        uid: json["uid"],
        role: json["role"],
        email: json["email"],
        name: json["name"],
        password: json["password"],
        username: json["username"],
        codeKelas: json["code_kelas"],
        urlImage: json["urlImage"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "role": role,
        "email": email,
        "username": name,
        "code_kelas": codeKelas,
        "urlImage": urlImage,
        "password": password,
      };

  static blankProfile() => Profile(
        role: "-",
        codeKelas: "-",
        name: '-',
        password: "-",
        username: '-',
        email: '-',
        uid: '-',
        urlImage: '-',
      );
}
