import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final email = TextEditingController();
  final password = TextEditingController();

  String msg = "";

  void signup() {
    if (email.text.isEmpty || password.text.isEmpty) {
      setState(() => msg = "Fill all fields");
      return;
    }

    setState(() => msg = "Account created (Demo)");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: email,
              decoration: InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: signup,
              child: Text("Signup"),
            ),

            SizedBox(height: 10),

            Text(msg)
          ],
        ),
      ),
    );
  }
}