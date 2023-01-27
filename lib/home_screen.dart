import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? galleryFile;

  File? galleryFile2;

  @override
  Widget build(BuildContext context) {
    Future getImage(ImageSource source) async {
      XFile? image =
          (await ImagePicker().pickImage(source: ImageSource.camera));
      if (image != null) {
        (await ImagePicker().pickImage(source: ImageSource.camera));
      } else {
        return;
      }
      GallerySaver.saveImage(image.path, toDcim: true);
      setState(() {
        galleryFile = File(image.path);
      });
    }

    openImage() async {
      XFile? galleryImage =
          (await ImagePicker().pickImage(source: ImageSource.gallery));
      if (galleryImage != null) {
        (await ImagePicker().pickImage(source: ImageSource.gallery));
      } else {
        return;
      }
      setState(
        () {
          galleryFile2 = File(galleryImage.path);
        },
      );
    }

    showGalleryImage() {
      if (galleryFile2 != null) {
        return Image.file(galleryFile2!);
      } else {
        return const Center(child: Text('No image is selected'));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera App'),
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      openImage();
                    },
                    icon: const Icon(Icons.photo),
                    label: const Text('Gallery'),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 450,
                        width: 350,
                        child: showGalleryImage(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
