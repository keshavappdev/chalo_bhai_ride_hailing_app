import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_hailing_app/core/constants/app_colors.dart';
import 'package:ride_hailing_app/core/routes/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _isNotificationsEnabled = true;
  bool _isLocationEnabled = true;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Account Settings
            _buildSection(
              'Account',
              [
                _buildSettingItem(
                  icon: Icons.person_outline,
                  title: 'Profile Information',
                  subtitle: 'Edit your personal information',
                  onTap: () {
                    context.push(AppRoutes.userProfile);
                  },
                ),
                _buildSettingItem(
                  icon: Icons.credit_card,
                  title: 'Payment Methods',
                  subtitle: 'Manage your payment options',
                  onTap: () {
                    // Navigate to payment methods
                  },
                ),
                _buildSettingItem(
                  icon: Icons.security,
                  title: 'Security',
                  subtitle: 'Password, 2FA, and more',
                  onTap: () {
                    // Navigate to security
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Preferences
            _buildSection(
              'Preferences',
              [
                _buildSwitchItem(
                  icon: Icons.dark_mode,
                  title: 'Dark Mode',
                  subtitle: 'Switch to dark theme',
                  value: _isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      _isDarkMode = value;
                    });
                  },
                ),
                _buildSwitchItem(
                  icon: Icons.notifications_active,
                  title: 'Push Notifications',
                  subtitle: 'Receive ride updates and offers',
                  value: _isNotificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isNotificationsEnabled = value;
                    });
                  },
                ),
                _buildSwitchItem(
                  icon: Icons.location_on,
                  title: 'Location Services',
                  subtitle: 'Allow app to access your location',
                  value: _isLocationEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isLocationEnabled = value;
                    });
                  },
                ),
                _buildDropdownItem(
                  icon: Icons.language,
                  title: 'Language',
                  subtitle: _selectedLanguage,
                  onTap: () {
                    _showLanguageDialog();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Support
            _buildSection(
              'Support',
              [
                _buildSettingItem(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  subtitle: 'FAQ, guides, and support',
                  onTap: () {
                    // Navigate to help center
                  },
                ),
                _buildSettingItem(
                  icon: Icons.feedback_outlined,
                  title: 'Send Feedback',
                  subtitle: 'Help us improve the app',
                  onTap: () {
                    // Navigate to feedback
                  },
                ),
                _buildSettingItem(
                  icon: Icons.star_border,
                  title: 'Rate Us',
                  subtitle: 'Rate the app on App Store',
                  onTap: () {
                    // Navigate to rating
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Legal
            _buildSection(
              'Legal',
              [
                _buildSettingItem(
                  icon: Icons.info_outline,
                  title: 'Terms & Conditions',
                  subtitle: 'Read our terms of service',
                  onTap: () {
                    // Navigate to terms
                  },
                ),
                _buildSettingItem(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  subtitle: 'Read our privacy policy',
                  onTap: () {
                    // Navigate to privacy policy
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Version
            Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }

  Widget _buildDropdownItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_drop_down, size: 24),
      onTap: onTap,
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              trailing: _selectedLanguage == 'English' ? const Icon(Icons.check, color: AppColors.primary) : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = 'English';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Hindi'),
              trailing: _selectedLanguage == 'Hindi' ? const Icon(Icons.check, color: AppColors.primary) : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = 'Hindi';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Spanish'),
              trailing: _selectedLanguage == 'Spanish' ? const Icon(Icons.check, color: AppColors.primary) : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = 'Spanish';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}