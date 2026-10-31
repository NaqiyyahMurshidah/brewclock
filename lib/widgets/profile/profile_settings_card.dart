import 'package:brewclock/widgets/profile/profile_settings_tile.dart';
import 'package:flutter/material.dart';

class ProfileSettingsCard extends StatelessWidget {
  final VoidCallback? onGoalsTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onAccountTap;
  final VoidCallback? onPrivacyTap;
  final VoidCallback? onHelpTap;
  final bool showHelpOnly;

  const ProfileSettingsCard({
    super.key,
    required this.onGoalsTap,
    required this.onNotificationsTap,
    required this.onAccountTap,
    required this.onPrivacyTap,
  }) : showHelpOnly = false,
       onHelpTap = null;

  const ProfileSettingsCard.help({super.key, required this.onHelpTap})
    : showHelpOnly = true,
      onGoalsTap = null,
      onNotificationsTap = null,
      onAccountTap = null,
      onPrivacyTap = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF30261F),
        borderRadius: BorderRadius.circular(22),
      ),
      child: showHelpOnly ? _buildHelpTile() : _buildSettingsTiles(),
    );
  }

  Widget _buildHelpTile() {
    return ProfileSettingsTile(
      icon: Icons.help_outline_rounded,
      title: 'Help & About',
      subtitle: 'FAQ and app information',
      onTap: onHelpTap!,
    );
  }

  Widget _buildSettingsTiles() {
    return Column(
      children: [
        ProfileSettingsTile(
          icon: Icons.coffee_outlined,
          title: 'Caffeine & Sleep Goals',
          subtitle: 'Limits, bedtime and sleep target',
          onTap: onGoalsTap!,
        ),

        const _SettingsDivider(),

        ProfileSettingsTile(
          icon: Icons.notifications_none_rounded,
          title: 'Notifications',
          subtitle: 'Reminders and weekly summary',
          onTap: onNotificationsTap!,
        ),

        const _SettingsDivider(),

        ProfileSettingsTile(
          icon: Icons.person_outline_rounded,
          title: 'Account Settings',
          subtitle: 'Profile, email and password',
          onTap: onAccountTap!,
        ),

        const _SettingsDivider(),

        ProfileSettingsTile(
          icon: Icons.shield_outlined,
          title: 'Privacy & Data',
          subtitle: 'History and account controls',
          onTap: onPrivacyTap!,
        ),
      ],
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 70,
      endIndent: 20,
      color: Color(0xFF4A3B31),
    );
  }
}
