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
    // required this.username,
    // required this.email,
    // required this.uid,
    // required this.urlImage,
  });

  // final String uid;
  final String role;

  // final String email;
  // final String username;
  final String codeKelas;

  // final String urlImage;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        // uid: json["uid"],
        role: json["role"],
        // email: json["email"],
        // username: json["username"],
        codeKelas: json["code_kelas"],
        // urlImage: json["urlImage"],
      );

  Map<String, dynamic> toJson() => {
        // "uid": uid,
        "role": role,
        // "email": email,
        // "username": username,
        "code_kelas": codeKelas,
        // "urlImage": urlImage,
      };

  static blankProfile() => Profile(
        role: "-",
        codeKelas: "-",
        // username: '-',
        // email: '-',
        // uid: '-',
        // urlImage: '-',
      );
}
