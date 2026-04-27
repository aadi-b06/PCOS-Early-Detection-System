import 'package:flutter/material.dart';

class LifestyleScreen extends StatefulWidget {
  const LifestyleScreen({super.key});

  @override
  State<LifestyleScreen> createState() => _LifestyleScreenState();
}

class _LifestyleScreenState extends State<LifestyleScreen> {
  bool water = false;
  bool exercise = false;
  bool vegetables = false;
  bool sleep = false;

  Widget imageSection(String title, String image, List<String> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: Image.asset(
              image,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                ...items.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        const Text("• "),
                        Expanded(child: Text(e)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget habitsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Daily Healthy Habits",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          CheckboxListTile(
            title: const Text("Drink enough water"),
            value: water,
            onChanged: (v) {
              setState(() {
                water = v!;
              });
            },
          ),

          CheckboxListTile(
            title: const Text("30 minutes exercise"),
            value: exercise,
            onChanged: (v) {
              setState(() {
                exercise = v!;
              });
            },
          ),

          CheckboxListTile(
            title: const Text("Eat vegetables"),
            value: vegetables,
            onChanged: (v) {
              setState(() {
                vegetables = v!;
              });
            },
          ),

          CheckboxListTile(
            title: const Text("Sleep 7-8 hours"),
            value: sleep,
            onChanged: (v) {
              setState(() {
                sleep = v!;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("PCOS Lifestyle Guide"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),

      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.deepPurple, Colors.blue],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Healthy Lifestyle for PCOS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "Diet, exercise and healthy habits help manage PCOS symptoms.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          imageSection("Foods to Eat", "assets/images/healthy_food.jpg", [
            "Whole grains like oats and brown rice",
            "Green leafy vegetables",
            "Lean protein (fish, chicken, tofu)",
            "Healthy fats like nuts and olive oil",
            "Low glycemic index foods",
          ]),

          imageSection("Foods to Avoid", "assets/images/junk_food.jpg", [
            "Sugary drinks",
            "Fast food",
            "Refined carbs",
            "Highly processed foods",
          ]),

          imageSection("Recommended Exercise", "assets/images/exercise.jpg", [
            "Walking 30 minutes daily",
            "Strength training",
            "Cardio workouts",
            "Stretching exercises",
          ]),

          imageSection("Yoga for PCOS", "assets/images/yoga.jpg", [
            "Surya Namaskar",
            "Bridge pose",
            "Cobra pose",
            "Breathing exercises",
          ]),

          imageSection("Sleep Tips", "assets/images/sleep.jpg", [
            "Sleep at least 7-8 hours",
            "Avoid screens before bed",
            "Reduce caffeine at night",
            "Maintain a regular sleep schedule",
          ]),

          habitsCard(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
