import 'package:flutter/material.dart';

class MoodNotificationPage extends StatefulWidget {
  const MoodNotificationPage({super.key});

  @override
  State<MoodNotificationPage> createState() => _MoodNotificationPageState();
}

class _MoodNotificationPageState extends State<MoodNotificationPage> {
  String selectedMood = '';
  String selectedIntensity = '';
  String customMessage = '';
  bool notificationsEnabled = true;
  List<Partner> partners = [
    Partner(name: 'nimal', phoneNumber: '+1234567890', isSelected: true),
    Partner(name: 'Mom', phoneNumber: '+0987654321', isSelected: false),
  ];

  final List<MoodOption> moods = [
    MoodOption(
      emoji: '😊',
      name: 'Happy',
      description: 'Feeling great and positive',
      color: Colors.green,
    ),
    MoodOption(
      emoji: '😔',
      name: 'Sad',
      description: 'Feeling down or melancholy',
      color: Colors.blue,
    ),
    MoodOption(
      emoji: '😤',
      name: 'Irritated',
      description: 'Feeling annoyed or frustrated',
      color: Colors.orange,
    ),
    MoodOption(
      emoji: '😰',
      name: 'Anxious',
      description: 'Feeling worried or stressed',
      color: Colors.purple,
    ),
    MoodOption(
      emoji: '😴',
      name: 'Tired',
      description: 'Feeling exhausted or sleepy',
      color: Colors.grey,
    ),
    MoodOption(
      emoji: '🤗',
      name: 'Need Comfort',
      description: 'Could use some extra support',
      color: Colors.pink,
    ),
  ];

  final List<String> intensityLevels = ['Mild', 'Moderate', 'Intense'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Mood Notifications',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettings(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            const SizedBox(height: 25),
            _buildMoodSelection(),
            const SizedBox(height: 25),
            if (selectedMood.isNotEmpty) ...[
              _buildIntensitySelection(),
              const SizedBox(height: 25),
              _buildCustomMessage(),
              const SizedBox(height: 25),
              _buildPartnerSelection(),
              const SizedBox(height: 30),
              _buildSendButton(),
            ],
            const SizedBox(height: 30),
            _buildRecentNotifications(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFCE4EC),
            Color(0xFFF8BBD9),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.favorite,
                color: Colors.pink,
                size: 24,
              ),
              const SizedBox(width: 10),
              const Text(
                'Share Your Feelings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Let your loved ones know how you\'re feeling today. Better communication leads to stronger relationships.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How are you feeling?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: moods.length,
          itemBuilder: (context, index) {
            final mood = moods[index];
            final isSelected = selectedMood == mood.name;

            return GestureDetector(
              onTap: () => setState(() => selectedMood = mood.name),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: isSelected ? mood.color.withOpacity(0.2) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? mood.color : Colors.grey[300]!,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      mood.emoji,
                      style: const TextStyle(fontSize: 22),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            mood.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? mood.color : Colors.black,
                            ),
                          ),
                          Text(
                            mood.description,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildIntensitySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Intensity Level',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: intensityLevels.map((intensity) {
            final isSelected = selectedIntensity == intensity;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => selectedIntensity = intensity),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.pink : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      intensity,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[600],
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCustomMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add a personal message (optional)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: TextField(
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Share what\'s on your mind...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15),
            ),
            onChanged: (value) => setState(() => customMessage = value),
          ),
        ),
      ],
    );
  }

  Widget _buildPartnerSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Send to',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () => _showAddPartnerDialog(),
              child: const Text('+ Add Contact'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...partners.map((partner) => _buildPartnerTile(partner)).toList(),
      ],
    );
  }

  Widget _buildPartnerTile(Partner partner) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: partner.isSelected ? Colors.pink[50] : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: partner.isSelected ? Colors.pink : Colors.grey[300]!,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.pink[100],
            child: Text(
              partner.name[0].toUpperCase(),
              style: const TextStyle(
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  partner.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  partner.phoneNumber,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Checkbox(
            value: partner.isSelected,
            onChanged: (value) {
              setState(() {
                partner.isSelected = value ?? false;
              });
            },
            activeColor: Colors.pink,
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    final hasSelectedPartner = partners.any((p) => p.isSelected);
    final canSend = selectedMood.isNotEmpty && selectedIntensity.isNotEmpty && hasSelectedPartner;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: canSend ? _sendMoodNotification : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Send Mood Update',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildRecentNotifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Notifications',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        _buildNotificationItem('😊 Happy (Mild)', 'Sent to Alex', '2 hours ago'),
        _buildNotificationItem('😤 Irritated (Moderate)', 'Sent to Alex, Mom', 'Yesterday'),
        _buildNotificationItem('🤗 Need Comfort (Intense)', 'Sent to Alex', '2 days ago'),
      ],
    );
  }

  Widget _buildNotificationItem(String mood, String recipients, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.pink[100],
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications,
              color: Colors.pink,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mood,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  recipients,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMoodNotification() {
    final selectedPartners = partners.where((p) => p.isSelected).toList();
    final moodEmoji = moods.firstWhere((m) => m.name == selectedMood).emoji;

    // Simulate sending notification
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mood Update Sent!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$moodEmoji $selectedMood ($selectedIntensity)'),
            if (customMessage.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text('"$customMessage"'),
            ],
            const SizedBox(height: 10),
            Text('Sent to: ${selectedPartners.map((p) => p.name).join(', ')}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetForm();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    setState(() {
      selectedMood = '';
      selectedIntensity = '';
      customMessage = '';
    });
  }

  void _showSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Notification Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              SwitchListTile(
                title: const Text('Enable Notifications'),
                subtitle: const Text('Allow sending mood updates to partners'),
                value: notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                  Navigator.pop(context);
                },
                activeColor: Colors.pink,
              ),
              ListTile(
                leading: const Icon(Icons.schedule),
                title: const Text('Auto Reminders'),
                subtitle: const Text('Get reminded to share your mood'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to reminder settings
                },
              ),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Message Templates'),
                subtitle: const Text('Customize notification messages'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to template settings
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddPartnerDialog() {
    String name = '';
    String phone = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => name = value,
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) => phone = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (name.isNotEmpty && phone.isNotEmpty) {
                setState(() {
                  partners.add(Partner(
                    name: name,
                    phoneNumber: phone,
                    isSelected: false,
                  ));
                });
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class MoodOption {
  final String emoji;
  final String name;
  final String description;
  final Color color;

  MoodOption({
    required this.emoji,
    required this.name,
    required this.description,
    required this.color,
  });
}

class Partner {
  final String name;
  final String phoneNumber;
  bool isSelected;

  Partner({
    required this.name,
    required this.phoneNumber,
    required this.isSelected,
  });
}