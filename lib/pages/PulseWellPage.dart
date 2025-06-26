import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class PulseWell extends StatefulWidget {
  const PulseWell({super.key});

  @override
  State<PulseWell> createState() => _PulseWellState();
}

class _PulseWellState extends State<PulseWell> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _breatheController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _breatheAnimation;

  Timer? _resetTimer;
  int _resetTimeLeft = 60;
  bool _isResetActive = false;
  ResetType _currentResetType = ResetType.focus;

  // Daily wellness tips
  final List<WellnessTip> _wellnessTips = [
    WellnessTip(
      title: "Take a mindful walk",
      description: "Take a 5-minute walk after lunch to reset your energy and boost focus.",
      icon: Icons.directions_walk,
      color: Colors.green,
    ),
    WellnessTip(
      title: "Stretch your back",
      description: "If you've been sitting for over an hour, try gentle back stretches.",
      icon: Icons.self_improvement,
      color: Colors.purple,
    ),
    WellnessTip(
      title: "Hydrate mindfully",
      description: "Drink a glass of water slowly and notice how it makes you feel.",
      icon: Icons.local_drink,
      color: Colors.blue,
    ),
    WellnessTip(
      title: "Practice gratitude",
      description: "Think of three things you're grateful for right now.",
      icon: Icons.favorite,
      color: Colors.pink,
    ),
    WellnessTip(
      title: "Rest your eyes",
      description: "Look away from screens and focus on something 20 feet away for 20 seconds.",
      icon: Icons.visibility,
      color: Colors.orange,
    ),
  ];

  WellnessTip? _todaysTip;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _setTodaysTip();
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _breatheController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _breatheAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _breatheController,
      curve: Curves.easeInOut,
    ));

    _pulseController.repeat(reverse: true);
  }

  void _setTodaysTip() {
    final random = math.Random();
    _todaysTip = _wellnessTips[random.nextInt(_wellnessTips.length)];
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _breatheController.dispose();
    _resetTimer?.cancel();
    super.dispose();
  }

  void _startReset(ResetType type) {
    if (_isResetActive) return;

    setState(() {
      _isResetActive = true;
      _currentResetType = type;
      _resetTimeLeft = 60;
    });

    _breatheController.repeat(reverse: true);

    _resetTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _resetTimeLeft--;
      });

      if (_resetTimeLeft <= 0) {
        _finishReset();
      }
    });
  }

  void _finishReset() {
    _resetTimer?.cancel();
    _breatheController.stop();

    setState(() {
      _isResetActive = false;
      _resetTimeLeft = 60;
    });

    // Show completion message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Great job! You completed your ${_getResetTitle(_currentResetType).toLowerCase()} session.'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _stopReset() {
    _resetTimer?.cancel();
    _breatheController.stop();

    setState(() {
      _isResetActive = false;
      _resetTimeLeft = 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text(
            'PulseWell',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: true,
        ),
        body: SafeArea(
          child: _isResetActive ? _buildResetScreen() : _buildMainScreen(),
        ),
      ),
    );
  }

  Widget _buildMainScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 32),

          // Daily Wellness Tip
          if (_todaysTip != null) _buildWellnessTipCard(_todaysTip!),

          const SizedBox(height: 24),

          // 1-Minute Reset Section
          Text(
            '1-Minute Reset 🧘',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16),

          _buildResetOptions(),
        ],
      ),
    );
  }

  Widget _buildWellnessTipCard(WellnessTip tip) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: tip.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  tip.icon,
                  color: tip.color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Daily Wellness Tip 🩺',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            tip.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            tip.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // Mark as done
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Great! Keep up the good work!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text('Done ✓'),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () {
                  setState(() {
                    _setTodaysTip();
                  });
                },
                child: const Text('New Tip'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResetOptions() {
    return Column(
      children: [
        _buildResetCard(
          ResetType.focus,
          'Deep Focus',
          'Clear your mind and sharpen concentration',
          Icons.center_focus_strong,
          Colors.blue,
        ),
        const SizedBox(height: 12),
        _buildResetCard(
          ResetType.stress,
          'Let Go of Stress',
          'Release tension and find inner calm',
          Icons.spa,
          Colors.green,
        ),
        const SizedBox(height: 12),
        _buildResetCard(
          ResetType.energy,
          'Calm Energy',
          'Restore balance and gentle vitality',
          Icons.energy_savings_leaf,
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildResetCard(ResetType type, String title, String description, IconData icon, Color color) {
    return InkWell(
      onTap: () => _startReset(type),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
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
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResetScreen() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Back button
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: _stopReset,
              icon: const Icon(Icons.close, size: 28),
            ),
          ),

          const Spacer(),

          // Reset title
          Text(
            _getResetTitle(_currentResetType),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            _getResetInstruction(_currentResetType),
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 60),

          // Breathing animation
          AnimatedBuilder(
            animation: _breatheAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _breatheAnimation.value,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        _getResetColor(_currentResetType).withOpacity(0.3),
                        _getResetColor(_currentResetType).withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getResetColor(_currentResetType).withOpacity(0.8),
                        boxShadow: [
                          BoxShadow(
                            color: _getResetColor(_currentResetType).withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        _getResetIcon(_currentResetType),
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 60),

          // Timer
          Text(
            '${_resetTimeLeft}s',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: _getResetColor(_currentResetType),
            ),
          ),

          const Spacer(),

          // Stop button
          ElevatedButton(
            onPressed: _stopReset,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.grey[700],
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text('Stop Session'),
          ),
        ],
      ),
    );
  }

  String _getResetTitle(ResetType type) {
    switch (type) {
      case ResetType.focus:
        return 'Deep Focus';
      case ResetType.stress:
        return 'Let Go of Stress';
      case ResetType.energy:
        return 'Calm Energy';
    }
  }

  String _getResetInstruction(ResetType type) {
    switch (type) {
      case ResetType.focus:
        return 'Breathe deeply and let your mind clear.\nFocus on the gentle rhythm.';
      case ResetType.stress:
        return 'Release tension with each exhale.\nLet stress melt away naturally.';
      case ResetType.energy:
        return 'Breathe in calm energy.\nFeel balanced and restored.';
    }
  }

  Color _getResetColor(ResetType type) {
    switch (type) {
      case ResetType.focus:
        return Colors.blue;
      case ResetType.stress:
        return Colors.green;
      case ResetType.energy:
        return Colors.orange;
    }
  }

  IconData _getResetIcon(ResetType type) {
    switch (type) {
      case ResetType.focus:
        return Icons.center_focus_strong;
      case ResetType.stress:
        return Icons.spa;
      case ResetType.energy:
        return Icons.energy_savings_leaf;
    }
  }
}

class WellnessTip {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  WellnessTip({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

enum ResetType { focus, stress, energy }