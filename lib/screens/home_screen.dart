import 'package:flutter/material.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // Controllers
  final age = TextEditingController();
  final weight = TextEditingController();
  final height = TextEditingController();
  final bmi = TextEditingController();
  final cycleLength = TextEditingController();

  final pulse = TextEditingController();
  final rr = TextEditingController();
  final hb = TextEditingController();
  final fsh = TextEditingController();
  final lh = TextEditingController();
  final fshlh = TextEditingController();
  final hip = TextEditingController();
  final waist = TextEditingController();
  final waistHip = TextEditingController();
  final tsh = TextEditingController();
  final rbs = TextEditingController();
  final bpSys = TextEditingController();
  final bpDia = TextEditingController();

  // Switch
  bool irregularCycle = false;
  bool weightGain = false;
  bool hairGrowth = false;
  bool skinDarkening = false;
  bool hairLoss = false;
  bool pimples = false;
  bool fastFood = false;
  bool exercise = false;

  String result = "";
  bool loading = false;

  Widget input(String label, IconData icon, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: c,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget toggle(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      activeColor: Colors.deepPurple,
      onChanged: (v) => setState(() => onChanged(v)),
    );
  }

  // ✅ FIXED FUNCTION
  Future<void> submit() async {
    setState(() => loading = true);

    Map<String, dynamic> data = {
      "Age (yrs)": double.tryParse(age.text),
      "Weight (Kg)": double.tryParse(weight.text),
      "Height(Cm)": double.tryParse(height.text),
      "BMI": double.tryParse(bmi.text),
      "Pulse rate(bpm)": double.tryParse(pulse.text),
      "RR (breaths/min)": double.tryParse(rr.text),
      "Hb(g/dl)": double.tryParse(hb.text),
      "Cycle(R/I)": irregularCycle ? 1 : 0,
      "Cycle length(days)": double.tryParse(cycleLength.text),
      "FSH(mIU/mL)": double.tryParse(fsh.text),
      "LH(mIU/mL)": double.tryParse(lh.text),
      "FSH/LH": double.tryParse(fshlh.text),
      "Hip(inch)": double.tryParse(hip.text),
      "Waist(inch)": double.tryParse(waist.text),
      "Waist:Hip Ratio": double.tryParse(waistHip.text),
      "TSH (mIU/L)": double.tryParse(tsh.text),
      "RBS(mg/dl)": double.tryParse(rbs.text),
      "Weight gain(Y/N)": weightGain ? 1 : 0,
      "hair growth(Y/N)": hairGrowth ? 1 : 0,
      "Skin darkening (Y/N)": skinDarkening ? 1 : 0,
      "Hair loss(Y/N)": hairLoss ? 1 : 0,
      "Pimples(Y/N)": pimples ? 1 : 0,
      "Fast food (Y/N)": fastFood ? 1 : 0,
      "Reg.Exercise(Y/N)": exercise ? 1 : 0,
      "BP _Systolic (mmHg)": double.tryParse(bpSys.text),
      "BP _Diastolic (mmHg)": double.tryParse(bpDia.text),
    };

    try {
      print("Sending request...");

      var res = await ApiService.predict(data);

      print("Response: $res");

      setState(() {
        result =
        "FINAL RISK: ${res["final_risk"]}\n\n"
            "ML Risk: ${res["ml_risk"]}\n"
            "Doctor Rule Risk: ${res["rule_risk"]}\n"
            "Probability: ${res["risk_probability"]}\n\n"
            "Reasons:\n${res["reasons"].join("\n")}\n\n"
            "Advice:\n${res["recommendation"]}";
      });

    } catch (e) {
      print("ERROR: $e");   // ✅ DEBUG
      setState(() {
        result = "Error: $e";
      });
    }

    setState(() => loading = false);
  }

  Color getRiskColor() {
    if (result.contains("High")) return Colors.red;
    if (result.contains("Moderate")) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff6a11cb), Color(0xff2575fc)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "PCOS Risk Prediction",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 25),

                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.95),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [

                      const Text(
                        "Basic Information",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),

                      input("Age", Icons.person, age),
                      input("Weight", Icons.monitor_weight, weight),
                      input("Height", Icons.height, height),
                      input("BMI", Icons.fitness_center, bmi),
                      input("Cycle Length", Icons.calendar_month, cycleLength),

                      const SizedBox(height: 10),

                      const Text(
                        "Symptoms",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),

                      toggle("Irregular Cycle", irregularCycle, (v) => irregularCycle = v),
                      toggle("Weight Gain", weightGain, (v) => weightGain = v),
                      toggle("Hair Growth", hairGrowth, (v) => hairGrowth = v),
                      toggle("Skin Darkening", skinDarkening, (v) => skinDarkening = v),
                      toggle("Hair Loss", hairLoss, (v) => hairLoss = v),
                      toggle("Pimples", pimples, (v) => pimples = v),
                      toggle("Fast Food", fastFood, (v) => fastFood = v),
                      toggle("Exercise", exercise, (v) => exercise = v),

                      const SizedBox(height: 20),

                      loading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                        onPressed: submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text("Check Risk"),
                      ),

                      const SizedBox(height: 20),

                      if (result.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: getRiskColor().withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            result,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: getRiskColor(),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}