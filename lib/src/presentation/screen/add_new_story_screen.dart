import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_story/src/core/common/flavor_type.dart';
import 'package:flutter_story/src/core/common/localization.dart';
import 'package:flutter_story/src/presentation/screen/map_picker_widget.dart';

import 'package:flutter_story/src/provider/story_list_provider.dart';
import 'package:flutter_story/src/provider/upload_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:geocoding/geocoding.dart' as geo;

class AddNewStoryScreen extends StatefulWidget {
  final Function() onSubmit;
  const AddNewStoryScreen({super.key, required this.onSubmit});

  @override
  State<AddNewStoryScreen> createState() => _AddNewStoryScreenState();
}

class _AddNewStoryScreenState extends State<AddNewStoryScreen> {
  final TextEditingController descriptionController = TextEditingController();
  double initialChildsize = 0;
  geo.Placemark? _placemark;
  LatLng? _latLng;
  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addNewStoryScreen),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
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
                            child: Text(AppLocalizations.of(context)!.gallery),
                          ),
                          ElevatedButton(
                            onPressed: () => _onCameraView(),
                            child: Text(AppLocalizations.of(context)!.camera),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    _placemark == null
                        ? const SizedBox()
                        : PlacemarkWidget(placemark: _placemark!),
                    ElevatedButton(
                      onPressed: () {
                        if (FlavorConfig.instance.flavor == FlavorType.free) {
                          showAboutDialog(
                            context: context,
                            children: [
                              Text(AppLocalizations.of(context)!
                                  .paidVersionAvaliableFeature)
                            ],
                          );
                        } else {
                          setState(() {
                            initialChildsize = 0.8;
                          });
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.location),
                    ),
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200],
                      ),
                      child: TextField(
                        controller: descriptionController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              AppLocalizations.of(context)!.writeSomething,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _onUpload(),
                      child: context.watch<UploadProvider>().isUploading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(AppLocalizations.of(context)!.uploadStory),
                                const Icon(Icons.upload),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: initialChildsize,
            minChildSize: 0,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: MapPickerWidget(
                  onCancelPressed: () {
                    setState(() {
                      initialChildsize = 0;
                    });
                  },
                  onSavePressed: (placemark, latLng) {
                    setState(() {
                      _placemark = placemark;
                      _latLng = latLng;
                      initialChildsize = 0;
                    });
                  },
                ),
              );
            },
          ),
        ],
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
        newBytes, fileName, descriptionController.text, _latLng);

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
      context.read<StoryListProvider>().getStoryList(isReset: true);
      widget.onSubmit();
    }
  }

  _onGalleryView() async {
    final provider = context.read<UploadProvider>();

    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    const isWeb = kIsWeb;
    if (!isWeb) {
      if (isMacOS || isLinux) return;
    }

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
