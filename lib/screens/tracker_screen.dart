import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  DateTime? lastPeriod;
  int cycleLength = 28;

  DateTime? nextPeriod;
  DateTime? ovulationDay;
  DateTime? fertileStart;
  DateTime? fertileEnd;

  final cycleController = TextEditingController(text: "28");

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        lastPeriod = date;
        calculateCycle();
      });
    }
  }

  void calculateCycle() {
    cycleLength = int.tryParse(cycleController.text) ?? 28;

    if (lastPeriod != null) {
      nextPeriod = lastPeriod!.add(Duration(days: cycleLength));

      ovulationDay = lastPeriod!.add(Duration(days: cycleLength - 14));

      fertileStart = ovulationDay!.subtract(const Duration(days: 4));
      fertileEnd = ovulationDay!.add(const Duration(days: 1));
    }
  }

  Widget infoCard(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // ✅ FIX
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black, // ✅ FIX
                ),
              ),
            ],
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
        title: const Text("Period Tracker"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),

      body: ListView(
        children: [
          /// HEADER
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
                  "Track Your Cycle",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Track your menstrual cycle and predict next period and ovulation.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          /// INPUT SECTION
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Last Period Date",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // ✅ FIX
                  ),
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: pickDate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white, // ✅ FIX
                  ),
                  child: const Text("Select Date"),
                ),

                const SizedBox(height: 10),

                if (lastPeriod != null)
                  Text(
                    DateFormat('dd MMM yyyy').format(lastPeriod!),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black, // ✅ FIX
                    ),
                  ),

                const SizedBox(height: 20),

                const Text(
                  "Cycle Length (days)",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // ✅ FIX
                  ),
                ),

                TextField(
                  controller: cycleController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black), // ✅ FIX
                  decoration: const InputDecoration(
                    hintText: "Enter cycle length (default 28)",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      calculateCycle();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white, // ✅ FIX
                  ),
                  child: const Text("Calculate"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// RESULTS
          if (nextPeriod != null)
            infoCard(
              "Next Period",
              DateFormat('dd MMM yyyy').format(nextPeriod!),
              Icons.calendar_month,
            ),

          if (ovulationDay != null)
            infoCard(
              "Ovulation Day",
              DateFormat('dd MMM yyyy').format(ovulationDay!),
              Icons.favorite,
            ),

          if (fertileStart != null && fertileEnd != null)
            infoCard(
              "Fertile Window",
              "${DateFormat('dd MMM').format(fertileStart!)} - ${DateFormat('dd MMM').format(fertileEnd!)}",
              Icons.eco,
            ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}