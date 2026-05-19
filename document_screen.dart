import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  File? image;

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();

      final picked = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (picked != null) {
        setState(() {
          image = File(picked.path);
        });
      } else {
        print("No image selected");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Bill"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: pickImage,
            child: const Text("Pick Image"),
          ),
          const SizedBox(height: 10),

          if (image != null)
            Image.file(
              image!,
              height: 200,
            )
        ],
      ),
    );
  }
}