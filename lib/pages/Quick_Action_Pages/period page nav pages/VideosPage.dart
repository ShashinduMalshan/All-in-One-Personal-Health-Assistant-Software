import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> categories = ['All', 'Getting Started', 'Period Care', 'Health Tips', 'Nutrition'];
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Period Care Videos",
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
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryTabs(),
          Expanded(
            child: _buildVideoContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedCategory == categories[index];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = categories[index]),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.pink : Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVideoContent() {
    List<VideoData> videos = _getFilteredVideos();
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (selectedCategory == 'All' || selectedCategory == 'Getting Started') ...[
            _buildSectionTitle('Getting Started with Periods'),
            _buildFeaturedVideo(),
            const SizedBox(height: 20),
          ],
          
          _buildSectionTitle('Recommended for You'),
          const SizedBox(height: 10),
          
          ...videos.map((video) => _buildVideoCard(video)).toList(),
          
          const SizedBox(height: 20),
          _buildEducationalSection(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFeaturedVideo() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFCE4EC), Color(0xFFF8BBD9)],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: Colors.pink.withOpacity(0.1),
                child: const Icon(
                  Icons.play_circle_fill,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Understanding Your First Period',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.white, size: 16),
                      const SizedBox(width: 5),
                      const Text(
                        '8:45',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      const SizedBox(width: 15),
                      Icon(Icons.visibility, color: Colors.white.withOpacity(0.8), size: 16),
                      const SizedBox(width: 5),
                      Text(
                        '125K views',
                        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(VideoData video) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Thumbnail
          Container(
            width: 120,
            height: 80,
            decoration: BoxDecoration(
              color: video.color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.play_circle_fill,
                    color: video.color,
                    size: 40,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      video.duration,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          
          // Video Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  video.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      video.categoryIcon,
                      size: 14,
                      color: video.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      video.category,
                      style: TextStyle(
                        fontSize: 11,
                        color: video.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${video.views} views',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // More Options
          IconButton(
            icon: const Icon(Icons.more_vert, size: 20),
            onPressed: () => _showVideoOptions(context, video),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationalSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.school, color: Colors.blue[600], size: 24),
              const SizedBox(width: 10),
              Text(
                'Educational Resources',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildEducationalItem(
            'Period Myths vs Facts',
            'Learn the truth about common period misconceptions',
            Icons.fact_check,
          ),
          const SizedBox(height: 10),
          _buildEducationalItem(
            'Menstrual Products Guide',
            'Compare different period products and find what works for you',
            Icons.shopping_bag,
          ),
          const SizedBox(height: 10),
          _buildEducationalItem(
            'Cycle Tracking Tips',
            'How to effectively track your menstrual cycle',
            Icons.track_changes,
          ),
        ],
      ),
    );
  }

  Widget _buildEducationalItem(String title, String description, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue[600], size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<VideoData> _getFilteredVideos() {
    List<VideoData> allVideos = [
      VideoData(
        title: 'How to Use Menstrual Pads Properly',
        description: 'Step-by-step guide on proper pad usage and hygiene',
        duration: '5:23',
        views: '89K',
        category: 'Period Care',
        categoryIcon: Icons.health_and_safety,
        color: Colors.pink,
      ),
      VideoData(
        title: 'Understanding Period Pain Relief',
        description: 'Natural and medical ways to manage menstrual cramps',
        duration: '7:15',
        views: '156K',
        category: 'Health Tips',
        categoryIcon: Icons.healing,
        color: Colors.green,
      ),
      VideoData(
        title: 'Nutrition During Your Period',
        description: 'Foods that help with period symptoms and energy',
        duration: '6:42',
        views: '73K',
        category: 'Nutrition',
        categoryIcon: Icons.restaurant,
        color: Colors.orange,
      ),
      VideoData(
        title: 'Menstrual Cup: Beginner\'s Guide',
        description: 'Everything you need to know about using menstrual cups',
        duration: '9:18',
        views: '201K',
        category: 'Period Care',
        categoryIcon: Icons.eco,
        color: Colors.teal,
      ),
      VideoData(
        title: 'Period Tracking Made Simple',
        description: 'How to track your cycle effectively for better health',
        duration: '4:56',
        views: '124K',
        category: 'Getting Started',
        categoryIcon: Icons.calendar_today,
        color: Colors.purple,
      ),
      VideoData(
        title: 'Exercise During Your Period',
        description: 'Safe exercises and activities during menstruation',
        duration: '8:33',
        views: '98K',
        category: 'Health Tips',
        categoryIcon: Icons.fitness_center,
        color: Colors.indigo,
      ),
    ];

    if (selectedCategory == 'All') {
      return allVideos;
    } else {
      return allVideos.where((video) => video.category == selectedCategory).toList();
    }
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Videos'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'Search for period care topics...',
            prefixIcon: Icon(Icons.search),
          ),
          onSubmitted: (value) {
            Navigator.pop(context);
            // Implement search functionality
          },
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

  void _showVideoOptions(BuildContext context, VideoData video) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.bookmark_add),
              title: const Text('Save to Watch Later'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Video'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Report'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoData {
  final String title;
  final String description;
  final String duration;
  final String views;
  final String category;
  final IconData categoryIcon;
  final Color color;

  VideoData({
    required this.title,
    required this.description,
    required this.duration,
    required this.views,
    required this.category,
    required this.categoryIcon,
    required this.color,
  });
}