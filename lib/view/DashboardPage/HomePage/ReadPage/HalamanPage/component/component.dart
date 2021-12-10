import 'dart:io';

import 'package:ajari/config/path_iqro.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

String twoDigits(int n) => n.toString().padLeft(2, "0");


Widget notJoinAction() {
  return Padding(
    padding: const EdgeInsets.only(
      top: SpacingDimens.spacing16,
    ),
    child: Container(
      height: 42,
      width: double.infinity,
      alignment: Alignment.center,
      decoration:  BoxDecoration(
        color: PaletteColor.primarybg,
        boxShadow: [BoxShadow(
          color: PaletteColor.grey60.withOpacity(0.4),
          offset: const Offset(0, -1),
          spreadRadius: 1
        )],
      ),
      child: const Text("Kamu belum memiliki kelas."),
    ),
  );
}

Future<bool> checkPermission() async {
  Map<Permission, PermissionStatus> permissions = await [
    Permission.storage,
    Permission.microphone,
  ].request();

  return permissions[Permission.storage]!.isGranted &&
      permissions[Permission.microphone]!.isGranted;
}

Future<String?> downloadFile( String uid, String filePath, String nomorHalaman,String nomorJilid) async {
  File downloadToFile = File(filePath);
  try {
    await FirebaseStorage.instance
        .ref(RecordFile.recordFile(uid: uid, nomorJilid: nomorJilid, nomorHalaman: nomorHalaman)+'record.m4a')
        .writeToFile(downloadToFile);
    return downloadToFile.path;
  } on FirebaseException catch (e) {
    return "Not found $e";
  }
}

Future<String?> deleteFile({required nomorHalaman, required uid, required nomorJilid}) async {
  try {
    await FirebaseStorage.instance.ref(RecordFile.recordFile(uid: uid, nomorJilid: nomorJilid, nomorHalaman: nomorHalaman)+'record.m4a').delete();
  } on FirebaseException catch (e) {
    return "Not found $e";
  }
}

Future<String> getFilePath() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  String filePath = '$appDocPath/'; // 3

  Directory appFolder = Directory(appDocPath);
  bool appFolderExists = await appFolder.exists();
  if (!appFolderExists) {
    final created = await appFolder.create(recursive: true);
    if (kDebugMode) {
      print(created.path);
    }
  }

  return filePath;
}
