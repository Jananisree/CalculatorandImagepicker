import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final ImagePicker _picker = ImagePicker();
  final ValueNotifier<File?> _selectedImageNotifier = ValueNotifier<File?>(null);
  final ValueNotifier<bool> _permissionsDeniedNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _loadStoredImage();
  }

  Future<void> _loadStoredImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('selected_image_path');
    if (imagePath != null) {
      _selectedImageNotifier.value = File(imagePath);
    }
  }

  Future<void> _setImage(File image) async {
    _selectedImageNotifier.value = image;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selected_image_path', image.path);
  }

  Future<void> _checkPermissionAndPickImage(ImageSource source) async {
    final permissionStatus = await Permission.camera.request();

    if (permissionStatus.isGranted) {
      _permissionsDeniedNotifier.value = false;
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        await _setImage(imageFile);
      }
    } else {
      _permissionsDeniedNotifier.value = true;
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 220,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Upload via", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 10),
              ListTile(
                leading: const CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xffe8e9eb),
                  child: Icon(Icons.camera_alt_outlined, color: Colors.black),
                ),
                title: const Text("Camera", style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pop(context);
                  _checkPermissionAndPickImage(ImageSource.camera);
                },
              ),
              const Divider(color: Colors.black12, thickness: 1),
              ListTile(
                leading: const CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xffe8e9eb),
                  child: Icon(Icons.photo_outlined, color: Colors.black),
                ),
                title: const Text("Gallery", style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pop(context);
                  _checkPermissionAndPickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: Color(0xffF5F5F5),
            elevation: 0,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 10, left: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/images/logoo.png"),
                      SizedBox(width: 10),
                      Text(
                        "RadicalStart",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Text("Upload image", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          color: const Color(0xffF5F5F5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: ValueListenableBuilder<File?>(
                            valueListenable: _selectedImageNotifier,
                            builder: (context, selectedImage, child) {
                              return GestureDetector(
                                onTap: () => _showBottomSheet(context),
                                child: Container(
                                  width: double.infinity,
                                  height: 350,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: selectedImage != null
                                        ? DecorationImage(
                                      image: FileImage(selectedImage),
                                      fit: BoxFit.cover,
                                    )
                                        : null,
                                  ),
                                  child: selectedImage == null
                                      ? const Icon(Icons.add, color: Colors.blue, size: 50)
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 55),
                      ValueListenableBuilder<bool>(
                        valueListenable: _permissionsDeniedNotifier,
                        builder: (context, permissionsDenied, child) {
                          return permissionsDenied
                              ? Card(
                            elevation: 2,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Error!",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                                  Text(
                                    "Please the enable camera permission ",
                                  ),
                                ],
                                  ),
                                ),
                              )
                              : const SizedBox();
                        },
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder<File?>(
                        valueListenable: _selectedImageNotifier,
                        builder: (context, selectedImage, child) {
                          return selectedImage != null
                              ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () => _showBottomSheet(context),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.blue[800],
                                  child: Icon(Icons.mode_edit_outline_outlined, color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 20),
                              InkWell(
                                onTap: () => _showBottomSheet(context),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.blue[800],
                                  child: Icon(Icons.check, color: Colors.white),
                                ),
                              ),
                            ],
                          )
                              : const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
