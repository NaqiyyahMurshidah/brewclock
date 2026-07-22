import 'package:brewclock/widgets/profile/edit_profile.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(height: 30),
        const CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80'),
        ),
        const Text(
          'Bal J',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'balj@example.com',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        
        // Menu Items

        ListTile(
          leading: const Icon(Icons.person, color: Color(0xFF3B2A20)),
          title: Text('Edit Profile', style: TextStyle(color: Color(0xFF3B2A20))),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF3B2A20)),
          onTap: () {
            // Navigate to edit profile
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditProfileScreen()),
            );
          },
        ),
                ListTile(
          leading: const Icon(Icons.settings, color: Color(0xFF3B2A20)),
          title: Text('Settings', style: TextStyle(color: Color(0xFF3B2A20))),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF3B2A20)),
          onTap: () {
            // Navigate to settings
          },
        ),
                ListTile(
          leading: const Icon(Icons.logout, color: Color(0xFF3B2A20)),
          title: Text('Logout', style: TextStyle(color: Color(0xFF3B2A20))),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF3B2A20)),
          onTap: () {
            // Navigate to logout
          },
        ),
        const SizedBox(height: 20),
      ]),
    );

  }
}