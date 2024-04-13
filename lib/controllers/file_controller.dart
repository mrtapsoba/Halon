import 'dart:io';

import 'package:decouvrir/models/constantes.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class FileController {
  Future uploadFile(dynamic file, String extension, String dossier) async {
    String fileName =
        "${DateTime.now().millisecondsSinceEpoch.toString()}.$extension";
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    try {
      Reference reference =
          FirebaseStorage.instance.ref().child("$dossier/$fileName");
      final metadata =
          SettableMetadata(customMetadata: {'picked-file-path': file.path});
      TaskSnapshot snapshot;
      if (kIsWeb) {
        snapshot = await reference.putData(await file.readAsBytes(), metadata);
      } else {
        snapshot = await reference.putFile(File(file.path), metadata);
      }
      String fileUrl = await snapshot.ref.getDownloadURL();
      Constantes.fileLink = fileUrl;
    } catch (e) {
      //print('null wooooo $e');
    }
  }
}
