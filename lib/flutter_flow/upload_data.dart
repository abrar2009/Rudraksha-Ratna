// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

Future<List<XFile>> selectMediaWithSourceBottomSheet(BuildContext context, {required bool allowMultiple}) async {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? pickedFiles = [];

  await showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Photo Library'),
              onTap: () async {
                pickedFiles = await _picker.pickMultiImage();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Camera'),
              onTap: () async {
                final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                if (photo != null) {
                  pickedFiles?.add(photo);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );

  return pickedFiles ?? [];
}

bool validateFileFormat(String filePath, BuildContext context) {
  final validExtensions = ['jpg', 'jpeg', 'png', 'gif'];
  final fileExtension = path.extension(filePath).toLowerCase().replaceAll('.', '');
  return validExtensions.contains(fileExtension);
}

void showUploadMessage(BuildContext context, String message, {bool showLoading = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if (showLoading)
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: CircularProgressIndicator(),
            ),
          Text(message),
        ],
      ),
    ),
  );
}
