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
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BmiAiPage(),
    );
  }
}

class BmiAiPage extends StatefulWidget {
  const BmiAiPage({super.key});

  @override
  State<BmiAiPage> createState() => _BmiAiPageState();
}

class _BmiAiPageState extends State<BmiAiPage> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  String result = "";
  bool loading = false;

  Future<void> generatePlan() async {
    final height = double.tryParse(heightController.text) ?? 0;
    final weight = double.tryParse(weightController.text) ?? 0;

    if (height <= 0 || weight <= 0) {
      setState(() => result = "⚠️ Please enter valid height & weight.");
      return;
    }

    setState(() {
      loading = true;
      result = "";
    });

    try {
      const apiKey =
          "YOUR_API_KEY"; // 🔑 Replace with your Gemini API key (don’t hardcode in production!)
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

          // ✅ Extract text safely
          String? content =
              data["candidates"]?[0]?["content"]?["parts"]?[0]?["text"];

          if (content == null || content.isEmpty) {
            throw Exception("Empty response from AI");
          }

          // 🧹 Clean up JSON string
          content = content.replaceAll(RegExp(r'```json\s*'), '');
          content = content.replaceAll(RegExp(r'```'), '');
          content = content.trim();

          // ✅ Try parsing JSON
          final parsed = jsonDecode(content);

          // Workout text builder
          String workoutText = "";
          if (parsed["workout_plan"] is List) {
            for (var dayPlan in parsed["workout_plan"]) {
              workoutText += "📅 Day: ${dayPlan['day']}\n";
              if (dayPlan["exercises"] is List) {
                for (var ex in dayPlan["exercises"]) {
                  workoutText +=
                      "- ${ex['name']}, Sets: ${ex['sets']}, Reps: ${ex['reps']}, Notes: ${ex['notes']}\n";
                }
              }
              workoutText += "\n";
            }
          }

          // Diet text builder
          String dietText = "";
          if (parsed["diet_plan"] is List) {
            for (var dayPlan in parsed["diet_plan"]) {
              dietText += "📅 Day: ${dayPlan['day']}\n";
              if (dayPlan["meals"] is List) {
                for (var meal in dayPlan["meals"]) {
                  dietText +=
                      "🍽️ ${meal['meal']}: ${meal['items'].join(", ")}\n";
                }
              }
              dietText += "\n";
            }
          }

          setState(() {
            result = """
✅ BMI: ${parsed['bmi']}
📌 Category: ${parsed['category']}

🏋️ Workout Plan:
$workoutText

🥗 Diet Plan:
$dietText
""";
          });
        } catch (e) {
          setState(() => result = "⚠️ Error parsing AI response: $e");
        }
      } else {
        setState(() => result =
            "❌ API Error: ${response.statusCode}\n${response.body}");
      }
    } catch (e) {
      setState(() => result = "⚠️ Network/Unexpected Error: $e");
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Workout & Diet Planner")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: heightController,
              decoration: const InputDecoration(
                labelText: "Height (meters)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(
                labelText: "Weight (kg)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: loading ? null : generatePlan,
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Generate Plan"),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  result,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
