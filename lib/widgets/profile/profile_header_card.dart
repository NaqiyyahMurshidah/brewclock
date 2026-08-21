import 'package:flutter/material.dart';
import 'package:brewclock/services/firestore/user_profile_service.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String imageUrl;
  final VoidCallback onEditProfile;

  const ProfileHeaderCard({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.imageUrl,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF30261F),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 46,
            backgroundColor: const Color(0xFFE7E3DF),
            backgroundImage: NetworkImage(imageUrl),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<String>(
                  stream: UserProfileService.getName(),
                  builder: (context, snapshot) {
                    final String name = snapshot.data ?? "User";

                    return Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 5),
                
                StreamBuilder<String>(
                  stream: UserProfileService.getEmail(),
                  builder: (context, snapshot) {
                    final String email = snapshot.data ?? "User";

                    return Text(
                      email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFFB8A99C),
                        fontSize: 14,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          OutlinedButton(
            onPressed: onEditProfile,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFD8A15B),
              side: const BorderSide(color: Color(0xFFD8A15B)),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
