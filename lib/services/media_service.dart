// ignore_for_file: body_might_complete_normally_nullable

import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:life_link/utils/enums.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:life_link/repositories/firestore_repository.dart';
import 'package:life_link/utils/exceptions.dart';
import 'package:life_link/utils/strings.dart';

class MediaService {
  static Future<PlatformFile?> selectFile() async {
    PermissionStatus permissionStatus = Platform.isIOS
        ? await Permission.photos.request()
        : await Permission.storage.request();

    try {
      if (permissionStatus == PermissionStatus.granted) {
        PlatformFile platformFile;
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png'],
          allowMultiple: false,
        );
        if (result == null) return null;
        platformFile = result.files.first;
        log(platformFile.path.toString());
        log(platformFile.toString());
        return platformFile;
      }
    } catch (e) {
      if (permissionStatus == PermissionStatus.denied) {
        throw StoragePermissionDenied(
          AppStrings.storagePermissionDeniedText,
        );
      } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
        throw StoragePermissionDeniedPermanently(
          AppStrings.storagePermissionDeniedPermanentlyText,
        );
      } else {
        throw UnknownException("${AppStrings.wentWrong} ${log.toString()}");
      }
    }
  }

  static Future<String?> uploadFile({
    PlatformFile? platformFile,
    required String userType,
  }) async {
    if (platformFile == null) return null;
    String path = "";
    User? user = FirestoreRepository.checkUser();
    path = userType == UserType.hospital.name
        ? 'files/$userType/doctor/${user!.uid}/${DateTime.now().millisecond}'
        : 'files/$userType/${user!.uid}/${DateTime.now().millisecond}';
    final file = File(platformFile.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    final TaskSnapshot taskSnapshot = await ref.putFile(file);
    return await taskSnapshot.ref.getDownloadURL();
  }
}
