import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// void main() {
//   runApp(const MyApp());
// }

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
      setState(() => result = "Please enter valid height & weight.");
      return;
    }

    setState(() => loading = true);

    try {
      final url = Uri.parse("https://openrouter.ai/api/v1/chat/completions");
      final apiKey = "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"; // Replace with your real OpenRouter API key

      final body = jsonEncode({
        "model": "openai/gpt-3.5-turbo",
        "messages": [
          {
            "role": "system",
            "content": """
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
"""
          },
          {
            "role": "user",
            "content":
                "Height: $height m, Weight: $weight kg, Goal: maintain. Generate BMI, category, and a 7-day workout & diet plan."
          }
        ]
      });

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey"
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Extract AI's JSON response
        final content = data["choices"][0]["message"]["content"];
        final parsed = jsonDecode(content);

        String workoutText = "";
        for (var dayPlan in parsed['workout_plan']) {
          workoutText += "Day: ${dayPlan['day']}\n";
          for (var ex in dayPlan['exercises']) {
            workoutText +=
                "- ${ex['name']}, Sets: ${ex['sets']}, Reps: ${ex['reps']}, Notes: ${ex['notes']}\n";
          }
          workoutText += "\n";
        }

        String dietText = "";
        for (var dayPlan in parsed['diet_plan']) {
          dietText += "Day: ${dayPlan['day']}\n";
          for (var meal in dayPlan['meals']) {
            dietText += "${meal['meal']}: ${meal['items'].join(", ")}\n";
          }
          dietText += "\n";
        }

        setState(() {
          result = """
BMI: ${parsed['bmi']}
Category: ${parsed['category']}

Workout Plan:
$workoutText

Diet Plan:
$dietText
""";
        });
      } else {
        setState(() => result =
            "Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      setState(() => result = "Error: $e");
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
