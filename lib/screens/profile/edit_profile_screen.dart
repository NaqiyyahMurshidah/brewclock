import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/firestore/profile_image_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  bool _uploadingImage = false;

  Future<void> _pickProfileImage() async {
    try {
      final XFile? pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      // User closed the gallery without choosing anything
      if (pickedImage == null) {
        return;
      }

      setState(() {
        _uploadingImage = true;
      });

      final File imageFile = File(pickedImage.path);

      // Upload to Firebase Storage
      // and save URL into Firestore
      await ProfileImageService.uploadProfileImage(imageFile);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Profile picture updated")));
    } catch (error) {
      debugPrint("PROFILE IMAGE ERROR: $error");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update profile picture")),
      );
    } finally {
      if (mounted) {
        setState(() {
          _uploadingImage = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1411),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1411),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 20),

            // ==============================
            // PROFILE PICTURE
            // ==============================
            Center(
              child: StreamBuilder<String?>(
                stream: ProfileImageService.getProfileImageStream(),

                builder: (context, snapshot) {
                  final String? imageUrl = snapshot.data;

                  return Stack(
                    children: [
                      CircleAvatar(
                        radius: 65,
                        backgroundColor: const Color(0xFF30261F),

                        backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                            ? NetworkImage(imageUrl)
                            : null,

                        child: imageUrl == null || imageUrl.isEmpty
                            ? const Icon(
                                Icons.person,
                                size: 65,
                                color: Colors.white70,
                              )
                            : null,
                      ),

                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: _uploadingImage ? null : _pickProfileImage,

                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD8B17B),
                              shape: BoxShape.circle,
                            ),

                            child: _uploadingImage
                                ? const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Color(0xFF1A1411),
                                    ),
                                  )
                                : const Icon(
                                    Icons.camera_alt,
                                    color: Color(0xFF1A1411),
                                    size: 20,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            Center(
              child: TextButton(
                onPressed: _uploadingImage ? null : _pickProfileImage,

                child: const Text(
                  "Change profile picture",
                  style: TextStyle(color: Color(0xFFD8B17B)),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // You can put name/email editing here later
            const Text(
              "Profile Information",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Example:
            // Name field
            // Email field
            // Save button
          ],
        ),
      ),
    );
  }
}
