import 'dart:io';
import 'package:cleanarch/core/bloc/widget/label.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImagePickerHelper {
  static Future<void> pickImage(
    BuildContext context,
    Function(File?) onImagePicked, {
    required ImageSource source,
  }) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  static void showImagePicker(
    BuildContext context,
    Function(File?) onImagePicked,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LocalizedLabel(
                text: "اختر صورة",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const LocalizedLabel(text: "التقاط من الكاميرا"),
                onTap:
                    () => pickImage(
                      context,
                      onImagePicked,
                      source: ImageSource.camera,
                    ),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.blue),
                title: const LocalizedLabel(text: "اختر من المعرض"),
                onTap:
                    () => pickImage(
                      context,
                      onImagePicked,
                      source: ImageSource.gallery,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}