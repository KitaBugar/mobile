import 'dart:io';
import 'package:kitabugar/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:kitabugar/components/buttons/floating_bottom_navbar.dart';
import 'package:intl_phone_field/intl_phone_field.dart'; // Make sure you have this package

// Custom Camera Delegate to handle photo and video capture
class MyCameraDelegate extends ImagePickerCameraDelegate {
  @override
  Future<XFile?> takePhoto(
      {ImagePickerCameraDelegateOptions options =
          const ImagePickerCameraDelegateOptions()}) async {
    return _takeAPhoto(options.preferredCameraDevice);
  }

  @override
  Future<XFile?> takeVideo(
      {ImagePickerCameraDelegateOptions options =
          const ImagePickerCameraDelegateOptions()}) async {
    return _takeAVideo(options.preferredCameraDevice);
  }

  Future<XFile?> _takeAPhoto(CameraDevice preferredCameraDevice) async {
    // Custom implementation for taking a photo
    final picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.camera);
  }

  Future<XFile?> _takeAVideo(CameraDevice preferredCameraDevice) async {
    // Custom implementation for recording a video
    final picker = ImagePicker();
    return await picker.pickVideo(source: ImageSource.camera);
  }
}

void setUpCameraDelegate() {
  final ImagePickerPlatform instance = ImagePickerPlatform.instance;
  if (instance is CameraDelegatingImagePickerPlatform) {
    instance.cameraDelegate = MyCameraDelegate();
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 2;
  File? _profileImage;
  final TextEditingController _nameController =
      TextEditingController(text: 'Cristian Welber');
  final TextEditingController _phoneController =
      TextEditingController(text: '+62564576586');
  bool _isEditing = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setUpCameraDelegate();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/member');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.colorWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 84),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center, // Center the profile image
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppPallete.colorWhite,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: _profileImage == null
                          ? Image.asset(
                              'assets/images/photos/image1.png',
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _profileImage!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFD700),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: AppPallete.colorWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Create a Column for name and phone number
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align to the start
                  children: [
                    // Name Field
                    const Text(
                      'Nama',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppPallete.colorTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _isEditing
                        ? TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'Nama Lengkap',
                              hintStyle: const TextStyle(
                                  color: AppPallete.colorTextSecondary),
                              filled: true,
                              fillColor: AppPallete.colorForm,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          )
                        : Text(
                            _nameController.text,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppPallete.colorTextSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                    const SizedBox(height: 16),

                    // Phone Number Field
                    const Text(
                      'Nomor Telepon',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppPallete.colorTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _isEditing
                        ? IntlPhoneField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppPallete.colorForm,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                            initialCountryCode: 'ID',
                            onChanged: (phone) {
                              print('Nomor Telepon: ${phone.completeNumber}');
                            },
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                _phoneController.text,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppPallete.colorTextSecondary,
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _isEditing ? _saveProfile : _toggleEditing,
                style: ElevatedButton.styleFrom(
                  iconColor: AppPallete.colorWhite,
                  backgroundColor: _isEditing
                      ? AppPallete.colorSecondary
                      : AppPallete.colorPrimary,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_isEditing ? Icons.save : Icons.edit, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      _isEditing ? 'Save' : 'Edit Profile',
                      style: const TextStyle(
                        color: AppPallete.colorWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: const BorderSide(
                      color: AppPallete.colorBorder,
                    ),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.logout,
                      size: 20,
                      color: AppPallete.colorTextPrimary,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppPallete.colorTextPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FloatingBottomNavBar(
        currentIndex: _currentIndex,
        onPageChanged: _onPageChanged,
      ),
    );
  }
}
