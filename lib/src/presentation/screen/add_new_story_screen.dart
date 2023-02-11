import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_story/src/presentation/widget/camera_view.dart';
import 'package:flutter_story/src/provider/story_list_provider.dart';
import 'package:flutter_story/src/provider/upload_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddNewStoryScreen extends StatefulWidget {
  final Function() onSubmit;
  const AddNewStoryScreen({super.key, required this.onSubmit});

  @override
  State<AddNewStoryScreen> createState() => _AddNewStoryScreenState();
}

class _AddNewStoryScreenState extends State<AddNewStoryScreen> {
  final TextEditingController descriptionController = TextEditingController();
  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddNewStoryScreen'),
        actions: [
          IconButton(
            onPressed: () => _onUpload(),

            /// todo-04-after-01: update the widget
            icon: context.watch<UploadProvider>().isUploading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Icon(Icons.upload),
            tooltip: "Unggah",
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: context.watch<UploadProvider>().imagePath == null
                      ? const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.image,
                            size: 100,
                          ),
                        )
                      : _showImage(),
                ),
                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => _onGalleryView(),
                        child: const Text("Gallery"),
                      ),
                      ElevatedButton(
                        onPressed: () => _onCameraView(),
                        child: const Text("Camera"),
                      ),
                    ],
                  ),
                ),
                TextField(
                  controller: descriptionController,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onUpload() async {
    final ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    final uploadProvider = context.read<UploadProvider>();

    /// check image is ready or not
    final imagePath = uploadProvider.imagePath;
    final imageFile = uploadProvider.imageFile;
    if (imagePath == null || imageFile == null) return;

    /// prepare a document variabel to upload
    final fileName = imageFile.name;
    final bytes = await imageFile.readAsBytes();

    /// compress an image before upload
    final newBytes = await uploadProvider.compressImage(bytes);

    /// upload the document
    await uploadProvider.upload(
      newBytes,
      fileName,
      descriptionController.text,
    );

    /// remove the image
    if (uploadProvider.uploadResponse != null) {
      uploadProvider.setImageFile(null);
      uploadProvider.setImagePath(null);
    }

    /// show the message
    scaffoldMessengerState.showSnackBar(
      SnackBar(content: Text(uploadProvider.message)),
    );

    /// update story list & navigate to story list screen
    if (!mounted) return;
    if (!uploadProvider.isError) {
      context.read<StoryListProvider>().getStoryList();
      widget.onSubmit();
    }
  }

  _onGalleryView() async {
    final provider = context.read<UploadProvider>();

    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  _onCameraView() async {
    final provider = context.read<UploadProvider>();

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  Widget _showImage() {
    final imagePath = context.read<UploadProvider>().imagePath;
    return kIsWeb
        ? Image.network(
            imagePath.toString(),
            fit: BoxFit.contain,
          )
        : Image.file(
            File(imagePath.toString()),
            fit: BoxFit.contain,
          );
  }
}
