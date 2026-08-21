import 'package:brewclock/widgets/profile/edit_profile.dart';
import 'package:brewclock/widgets/profile/logout_button.dart';
import 'package:brewclock/widgets/profile/profile_header_card.dart';
import 'package:brewclock/widgets/profile/profile_settings_card.dart';
import 'package:brewclock/widgets/profile/profile_stat_card.dart';
import 'package:flutter/material.dart';
import '../../screens/settings/goals_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color backgroundColor = Color(0xFF1A1411);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              ProfileHeaderCard(
                userName: 'Bal J',
                userEmail: 'balj@email.com',
                imageUrl:
                    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80',
                onEditProfile: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProfileScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              const Row(
                children: [
                  Expanded(
                    child: ProfileStatCard(
                      title: 'LOG STREAK',
                      value: '2 days',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ProfileStatCard(
                      title: 'AVG CAFFEINE',
                      value: '64 mg',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 14),

              ProfileSettingsCard(
                onGoalsTap: () {
                  // Navigate to caffeine and sleep goals.
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GoalsScreen(),
                    ),
                  );
                },
                onNotificationsTap: () {
                  // Navigate to notification settings.
                },
                onAccountTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProfileScreen(),
                    ),
                  );
                },
                onPrivacyTap: () {
                  // Navigate to privacy and data.
                },
              ),

              const SizedBox(height: 16),

              ProfileSettingsCard.help(
                onHelpTap: () {
                  // Navigate to help and about.
                },
              ),

              const SizedBox(height: 24),

              const LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
