import 'dart:io';

import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

String twoDigits(int n) => n.toString().padLeft(2, "0");

Widget actionPage() {
  return Container(
    padding: const EdgeInsets.only(
      left: SpacingDimens.spacing16,
      right: SpacingDimens.spacing8,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(SpacingDimens.spacing4),
              margin: const EdgeInsets.only(
                  top: SpacingDimens.spacing8,
                  bottom: SpacingDimens.spacing16,
                  left: SpacingDimens.spacing8,
                  right: SpacingDimens.spacing16),
              decoration: BoxDecoration(
                color: PaletteColor.primarybg,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(
                      left: SpacingDimens.spacing8,
                      right: SpacingDimens.spacing8,
                    ),
                    child: Text(
                      "",
                      style:
                      TextStyle(color: PaletteColor.grey60, fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: SpacingDimens.spacing24,
                      right: SpacingDimens.spacing24,
                    ),
                    child: Text("1"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: SpacingDimens.spacing8,
                      right: SpacingDimens.spacing8,
                    ),
                    child: Text(
                      "2",
                      style:
                      TextStyle(color: PaletteColor.grey60, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: SpacingDimens.spacing8,
                bottom: SpacingDimens.spacing16,
                left: SpacingDimens.spacing8,
              ),
              decoration: BoxDecoration(
                color: PaletteColor.primarybg,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(SpacingDimens.spacing4),
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(SpacingDimens.spacing4),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget notJoinAction() {
  return const Padding(
    padding: EdgeInsets.only(
      top: SpacingDimens.spacing12,
      bottom: SpacingDimens.spacing8,
    ),
    child: Text("You not join class yet"),
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

Future<String?> downloadFile(filePath, nomorHalaman) async {
  File downloadToFile = File('$filePath');
  try {
    await FirebaseStorage.instance
        .ref('uploads/audio_$nomorHalaman.m4a')
        .writeToFile(downloadToFile);
    return downloadToFile.path;
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