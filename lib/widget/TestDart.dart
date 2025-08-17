import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DietAndWorkoutPlanner extends StatelessWidget {
  const DietAndWorkoutPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Workout & Diet Planner',
      theme: ThemeData(
        primaryColor: const Color(0xFF4ECDC4),
        scaffoldBackgroundColor: Colors.grey[50],
        fontFamily: 'Roboto',
      ),
      home: const BmiAiPage(),
    );
  }
}

class BmiAiPage extends StatefulWidget {
  const BmiAiPage({super.key});

  @override
  State<BmiAiPage> createState() => _BmiAiPageState();
}

class _BmiAiPageState extends State<BmiAiPage> with TickerProviderStateMixin {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  String result = "";
  bool loading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Map<String, dynamic>? parsedResult;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  Future<void> generatePlan() async {
    final height = double.tryParse(heightController.text) ?? 0;
    final weight = double.tryParse(weightController.text) ?? 0;

    if (height <= 0 || weight <= 0) {
      _showSnackBar("⚠️ Please enter valid height & weight.", Colors.orange);
      return;
    }

    setState(() {
      loading = true;
      result = "";
      parsedResult = null;
    });

    try {
      const apiKey = "AIzaSyD0v_E0Vl3GAq1neagtt8Y38k4CyJ7RaB4";
      final url = Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey",
      );

      final prompt = """
You are a professional fitness coach and nutritionist.
Always respond in strict JSON format:
{
  "bmi": number,
  "category": string,
  "workout_plan": [
    {
      "day": "string",
      "exercises": [
        {"name": "string", "sets": number, "reps": "string", "notes": "string"}
      ]
    }
  ],
  "diet_plan": [
    {
      "day": "string",
      "meals": [
        {"meal": "Breakfast", "items": ["string", "string"]},
        {"meal": "Lunch", "items": ["string", "string"]},
        {"meal": "Dinner", "items": ["string", "string"]},
        {"meal": "Snacks", "items": ["string", "string"]}
      ]
    }
  ]
}

Make the workout plan cover 7 days, include rest days, target all muscle groups, and vary intensity.
Make the diet plan cover 7 days with portion suggestions and healthy alternatives.

Height: $height m, Weight: $weight kg, Goal: maintain. Generate BMI, category, and a 7-day workout & diet plan.
""";

      final body = jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt}
            ]
          }
        ]
      });

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          String? content = data["candidates"]?[0]?["content"]?["parts"]?[0]?["text"];

          if (content == null || content.isEmpty) {
            throw Exception("Empty response from AI");
          }

          content = content.replaceAll(RegExp(r'```json\s*'), '');
          content = content.replaceAll(RegExp(r'```'), '');
          content = content.trim();

          final parsed = jsonDecode(content);

          setState(() {
            parsedResult = parsed;
            result = "success";
          });

          _animationController.forward();
          _showSnackBar("✅ Plan generated successfully!", Colors.green);

        } catch (e) {
          setState(() => result = "⚠️ Error parsing AI response: $e");
          _showSnackBar("Error parsing response", Colors.red);
        }
      } else {
        setState(() => result = "❌ API Error: ${response.statusCode}");
        _showSnackBar("API Error occurred", Colors.red);
      }
    } catch (e) {
      setState(() => result = "⚠️ Network Error: $e");
      _showSnackBar("Network error occurred", Colors.red);
    }

    setState(() => loading = false);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildInputCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
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
                  color: const Color(0xFF4ECDC4).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.fitness_center,
                  color: Color(0xFF4ECDC4),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'Your Measurements',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Height Input
          const Text(
            'Height (meters)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'e.g., 1.75',
              prefixIcon: const Icon(Icons.height, color: Color(0xFF4ECDC4)),
              filled: true,
              fillColor: Colors.grey[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF4ECDC4), width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),

          const SizedBox(height: 20),

          // Weight Input
          const Text(
            'Weight (kg)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'e.g., 70',
              prefixIcon: const Icon(Icons.monitor_weight, color: Color(0xFF4ECDC4)),
              filled: true,
              fillColor: Colors.grey[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF4ECDC4), width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),

          const SizedBox(height: 30),

          // Generate Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: loading ? null : generatePlan,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4ECDC4),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
                shadowColor: const Color(0xFF4ECDC4).withOpacity(0.3),
              ),
              child: loading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.auto_awesome, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Generate AI Plan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard() {
    if (parsedResult == null) return const SizedBox.shrink();

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // BMI Card
            _buildBMICard(),
            const SizedBox(height: 16),

            // Tab View for Workout and Diet
            DefaultTabController(
              length: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TabBar(
                        indicator: BoxDecoration(
                          color: const Color(0xFF4ECDC4),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey[600],
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        tabs: const [
                          Tab(icon: Icon(Icons.fitness_center), text: "Workout"),
                          Tab(icon: Icon(Icons.restaurant), text: "Diet"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 400,
                      child: TabBarView(
                        children: [
                          _buildWorkoutTab(),
                          _buildDietTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBMICard() {
    final bmi = parsedResult?['bmi']?.toStringAsFixed(1) ?? '0.0';
    final category = parsedResult?['category'] ?? 'Unknown';

    Color categoryColor = Colors.green;
    IconData categoryIcon = Icons.check_circle;

    if (category.toLowerCase().contains('underweight')) {
      categoryColor = Colors.blue;
      categoryIcon = Icons.trending_down;
    } else if (category.toLowerCase().contains('overweight')) {
      categoryColor = Colors.orange;
      categoryIcon = Icons.trending_up;
    } else if (category.toLowerCase().contains('obese')) {
      categoryColor = Colors.red;
      categoryIcon = Icons.warning;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [categoryColor.withOpacity(0.1), categoryColor.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: categoryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: categoryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(categoryIcon, color: categoryColor, size: 32),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your BMI',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  bmi,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: categoryColor,
                  ),
                ),
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: categoryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutTab() {
    final workoutPlan = parsedResult?['workout_plan'] as List? ?? [];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: workoutPlan.length,
      itemBuilder: (context, index) {
        final dayPlan = workoutPlan[index];
        final exercises = dayPlan['exercises'] as List? ?? [];

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4ECDC4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      dayPlan['day'] ?? 'Day ${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...exercises.map<Widget>((exercise) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(top: 6, right: 12),
                      decoration: const BoxDecoration(
                        color: Color(0xFF4ECDC4),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercise['name'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Sets: ${exercise['sets']} • Reps: ${exercise['reps']}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          if (exercise['notes'] != null && exercise['notes'].isNotEmpty)
                            Text(
                              exercise['notes'],
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDietTab() {
    final dietPlan = parsedResult?['diet_plan'] as List? ?? [];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: dietPlan.length,
      itemBuilder: (context, index) {
        final dayPlan = dietPlan[index];
        final meals = dayPlan['meals'] as List? ?? [];

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4ECDC4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      dayPlan['day'] ?? 'Day ${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...meals.map<Widget>((meal) {
                final items = meal['items'] as List? ?? [];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '🍽️ ${meal['meal']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          items.join(', '),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF4ECDC4).withOpacity(0.1),
              Colors.grey[50]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Color(0xFF4ECDC4),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI Fitness Planner',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Personalized workout & diet plans',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildInputCard(),
                      const SizedBox(height: 20),
                      _buildResultCard(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}