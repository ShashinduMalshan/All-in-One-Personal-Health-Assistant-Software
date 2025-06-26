import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<SettingPage> {

  String userName = "Kamal Perera";
  String userEmail = "KamalPerera@gmail.com";
  String userPhone = "011 45 78 789";
  DateTime dateOfBirth = DateTime(1995, 6, 15);
  String profileImageUrl = "";

  bool notificationsEnabled = true;
  bool cycleReminders = true;
  bool medicationReminders = true;
  bool dataBackup = true;
  bool biometricLogin = false;
  String selectedLanguage = "English";
  String selectedTheme = "Light";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildProfileStats(),
              const SizedBox(height: 20),
              _buildMenuSections(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.pink.shade400,
            Colors.pink.shade600,
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () => _showSettingsModal(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildProfileAvatar(),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userEmail,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildMembershipBadge(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return GestureDetector(
      onTap: () => _showImageOptions(),
      child: Stack(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: profileImageUrl.isEmpty
                ? Center(
                    child: Text(
                      _getInitials(userName),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink.shade600,
                      ),
                    ),
                  )
                : ClipOval(
                    child: Image.network(
                      profileImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt,
                size: 16,
                color: Colors.pink.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.diamond,
            size: 14,
            color: Colors.white.withOpacity(0.9),
          ),
          const SizedBox(width: 4),
          Text(
            'Premium Member',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Health Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Cycle Day',
                  '14',
                  Icons.calendar_today,
                  Colors.pink,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  'Records',
                  '12',
                  Icons.folder,
                  Colors.blue,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  'Streak',
                  '45d',
                  Icons.local_fire_department,
                  Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSections() {
    return Column(
      children: [
        _buildMenuSection(
          'Personal Information',
          [
            _buildMenuItem(
              'Edit Profile',
              'Update your personal details',
              Icons.person,
              Colors.blue,
              () => _showEditProfileModal(),
            ),
            _buildMenuItem(
              'Health Profile',
              'Medical conditions and allergies',
              Icons.health_and_safety,
              Colors.green,
              () => _navigateToHealthProfile(),
            ),
            _buildMenuItem(
              'Emergency Contacts',
              'Add trusted contacts',
              Icons.emergency,
              Colors.red,
              () => _showEmergencyContacts(),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildMenuSection(
          'Privacy & Security',
          [
            _buildMenuItem(
              'Privacy Settings',
              'Control your data sharing',
              Icons.privacy_tip,
              Colors.purple,
              () => _showPrivacySettings(),
            ),
            _buildMenuItem(
              'Data Export',
              'Download your data',
              Icons.download,
              Colors.teal,
              () => _showDataExport(),
            ),
            _buildMenuItem(
              'Account Security',
              'Password and biometric settings',
              Icons.security,
              Colors.indigo,
              () => _showSecuritySettings(),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildMenuSection(
          'Support & Feedback',
          [
            _buildMenuItem(
              'Help Center',
              'Get help and support',
              Icons.help,
              Colors.orange,
              () => _showHelpCenter(),
            ),
            _buildMenuItem(
              'Send Feedback',
              'Share your thoughts',
              Icons.feedback,
              Colors.blue,
              () => _showFeedbackForm(),
            ),
            _buildMenuItem(
              'Rate App',
              'Rate us on the app store',
              Icons.star,
              Colors.amber,
              () => _showRateApp(),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildMenuSection(
          'Account',
          [
            _buildMenuItem(
              'Notification Settings',
              'Manage your notifications',
              Icons.notifications,
              Colors.green,
              () => _showNotificationSettings(),
            ),
            _buildMenuItem(
              'App Preferences',
              'Language, theme, and more',
              Icons.tune,
              Colors.grey,
              () => _showAppPreferences(),
            ),
            _buildMenuItem(
              'Sign Out',
              'Sign out of your account',
              Icons.logout,
              Colors.red,
              () => _showSignOutConfirmation(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.withOpacity(0.1)),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  String _getInitials(String name) {
    List<String> names = name.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    } else {
      return name.substring(0, 2).toUpperCase();
    }
  }

  // Modal and dialog methods
  void _showSettingsModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Quick Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    _buildSwitchTile(
                      'Notifications',
                      'Receive period and health reminders',
                      notificationsEnabled,
                      (value) => setState(() => notificationsEnabled = value),
                    ),
                    _buildSwitchTile(
                      'Cycle Reminders',
                      'Get notified about your cycle',
                      cycleReminders,
                      (value) => setState(() => cycleReminders = value),
                    ),
                    _buildSwitchTile(
                      'Medication Reminders',
                      'Reminders for medications',
                      medicationReminders,
                      (value) => setState(() => medicationReminders = value),
                    ),
                    _buildSwitchTile(
                      'Data Backup',
                      'Automatically backup your data',
                      dataBackup,
                      (value) => setState(() => dataBackup = value),
                    ),
                    _buildSwitchTile(
                      'Biometric Login',
                      'Use fingerprint or face unlock',
                      biometricLogin,
                      (value) => setState(() => biometricLogin = value),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, Function(bool) onChanged) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.pink,
      ),
    );
  }

  void _showEditProfileModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: userName),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: userEmail),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: userPhone),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage('Profile updated successfully!');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Change Profile Picture',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _showSuccessMessage('Camera feature coming soon!');
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _showSuccessMessage('Gallery feature coming soon!');
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Remove Photo'),
              onTap: () {
                Navigator.pop(context);
                setState(() => profileImageUrl = "");
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSignOutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out of your account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage('Signed out successfully');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Sign Out', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Navigation methods
  void _navigateToHealthProfile() {
    _showSuccessMessage('Navigating to Health Profile...');
  }

  void _showEmergencyContacts() {
    _showSuccessMessage('Emergency Contacts feature coming soon!');
  }

  void _showPrivacySettings() {
    _showSuccessMessage('Privacy Settings feature coming soon!');
  }

  void _showDataExport() {
    _showSuccessMessage('Data Export feature coming soon!');
  }

  void _showSecuritySettings() {
    _showSuccessMessage('Security Settings feature coming soon!');
  }

  void _showHelpCenter() {
    _showSuccessMessage('Help Center feature coming soon!');
  }

  void _showFeedbackForm() {
    _showSuccessMessage('Feedback Form feature coming soon!');
  }

  void _showRateApp() {
    _showSuccessMessage('Rate App feature coming soon!');
  }

  void _showNotificationSettings() {
    _showSuccessMessage('Notification Settings feature coming soon!');
  }

  void _showAppPreferences() {
    _showSuccessMessage('App Preferences feature coming soon!');
  }
}