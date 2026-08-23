import '../profile/edit_profile_screen.dart';
import 'package:brewclock/widgets/profile/logout_button.dart';
import 'package:brewclock/widgets/profile/profile_header_card.dart';
import 'package:brewclock/widgets/profile/profile_settings_card.dart';
import 'package:brewclock/widgets/profile/profile_stat_card.dart';
import 'package:flutter/material.dart';
import '../../screens/settings/goals_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/firestore/user_profile_service.dart';
import '../../services/firestore/profile_image_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color backgroundColor = Color(0xFF1A1411);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
          child: ListView(
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
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

              //widgets/profile/profile_settings_card.dart
              ProfileSettingsCard(
                onGoalsTap: () {
                  // Navigate to caffeine and sleep goals.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GoalsScreen()),
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
