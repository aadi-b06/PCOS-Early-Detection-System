import 'package:flutter/material.dart';

class LearnScreen extends StatelessWidget {
const LearnScreen({super.key});

Widget sectionCard(
IconData icon, String title, List<String> points, Color color) {
return Container(
margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(18),
boxShadow: [
BoxShadow(
color: Colors.black.withOpacity(0.08),
blurRadius: 10,
offset: const Offset(0, 5),
)
],
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [


      /// Title Row
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),

      const SizedBox(height: 12),

      /// Points
      ...points.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("• ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(child: Text(e)),
              ],
            ),
          )),
    ],
  ),
);


}

Widget faqTile(String question, String answer) {
return Container(
margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(12),
),
child: ExpansionTile(
title: Text(
question,
style: const TextStyle(fontWeight: FontWeight.w600),
),
children: [
Padding(
padding: const EdgeInsets.all(12),
child: Text(answer),
)
],
),
);
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.grey[100],


  appBar: AppBar(
    title: const Text("Learn About PCOS"),
    centerTitle: true,
    backgroundColor: Colors.deepPurple,
  ),

  body: ListView(
    children: [

      /// 🔥 HEADER CARD
      Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.deepPurple, Colors.blue],
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PCOS Awareness",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              "Learn symptoms, causes, diagnosis and treatment in a simple way.",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),

      /// Sections
      sectionCard(
        Icons.health_and_safety,
        "What is PCOS?",
        [
          "Hormonal disorder affecting women",
          "Causes irregular ovulation",
          "May develop ovarian cysts",
          "Affects fertility and metabolism"
        ],
        Colors.deepPurple,
      ),

      sectionCard(
        Icons.warning,
        "Symptoms",
        [
          "Irregular periods",
          "Acne and oily skin",
          "Excess hair growth",
          "Hair thinning",
          "Weight gain"
        ],
        Colors.orange,
      ),

      sectionCard(
        Icons.science,
        "Causes",
        [
          "Hormonal imbalance",
          "Insulin resistance",
          "Genetics",
          "Inflammation"
        ],
        Colors.blue,
      ),

      sectionCard(
        Icons.medical_services,
        "Diagnosis",
        [
          "Blood tests",
          "Ultrasound",
          "Cycle tracking",
          "Doctor evaluation"
        ],
        Colors.teal,
      ),

      sectionCard(
        Icons.healing,
        "Treatment",
        [
          "Lifestyle changes",
          "Medication",
          "Hormonal therapy",
          "Fertility treatment"
        ],
        Colors.pink,
      ),

      const SizedBox(height: 10),

      /// FAQ TITLE
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          "FAQs",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),

      faqTile(
        "Can PCOS be cured?",
        "No permanent cure, but it can be managed effectively."
      ),

      faqTile(
        "Is PCOS dangerous?",
        "It increases risk of diabetes and heart disease if untreated."
      ),

      faqTile(
        "Can I get pregnant?",
        "Yes, with proper treatment many women conceive."
      ),

      const SizedBox(height: 20),
    ],
  ),
);


}
}
