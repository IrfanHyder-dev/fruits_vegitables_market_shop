import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductImagePicker extends StatefulWidget {

final void Function(File pickImage) imageFile;
   const ProductImagePicker(this.imageFile);

  @override
  State<ProductImagePicker> createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends State<ProductImagePicker> {
  File _pikedImage = new File('');

  void _pickImageCamera() async {
    XFile? pickImageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _pikedImage = File(pickImageFile!.path);
    });
    widget.imageFile(File(pickImageFile!.path));
  }

  void _pickImageGallery() async {
    XFile? pickImageFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _pikedImage = File(pickImageFile!.path);
    });
    widget.imageFile(File(pickImageFile!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: _pikedImage.path.isEmpty
              ? Container(height: 200, width: 200,child: Center(child: Text('Select Image')))
              : FittedBox(
                child: Image.file(
                    _pikedImage,
                    width: 400,
                    height: 280,
            fit: BoxFit.cover,
                  ),
              ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed:_pickImageGallery,
              icon: Icon(Icons.image),
              label: Text('Open Gallery'),
            ),
            TextButton.icon(
              onPressed: _pickImageCamera,
              icon: Icon(Icons.camera),
              label: Text('Open Camera'),
            ),
          ],
        )
      ],
    );
  }
}
