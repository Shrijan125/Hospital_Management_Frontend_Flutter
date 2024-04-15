import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker(
      {super.key, required this.onPickImage, required this.backgroundImgPath});
  final void Function(File pickedImage) onPickImage;
  final String backgroundImgPath;
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;
  File? _chosenImageFile;
  void _pickImage() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
    widget.onPickImage(_pickedImageFile!);
  }

  void _chooseImage() async {
    final chosenImage = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);
    if (chosenImage == null) {
      return;
    }
    setState(() {
      _chosenImageFile = File(chosenImage.path);
    });
    widget.onPickImage(_chosenImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 75,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(widget.backgroundImgPath),
          foregroundImage: _pickedImageFile != null
              ? FileImage(_pickedImageFile!)
              : _chosenImageFile != null
                  ? FileImage(_chosenImageFile!)
                  : null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _pickImage,
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: _chooseImage,
              icon: const Icon(
                Icons.image,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
