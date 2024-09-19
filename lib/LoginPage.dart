import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage ='';
  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;


    // API URL
    const String apiUrl = "https://fakestoreapi.com/auth/login";

    // Sending POST request to login API
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('Login successful: ${data['token']}');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      print('Login failed: ${response.reasonPhrase}');
      errorMessage = 'Invalid';
      // You can display an error message to the user here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100,),
              Image.asset("assets/images/2.png", height: 200),
              const SizedBox(height: 20),
              const Text(
                "Welcome to BuySmart",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person, color: Colors.white),
                  hintText: "Username",
                  hintStyle: const TextStyle(color: Colors.white60),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.visibility, color: Colors.white70),
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  hintText: "Password",
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 80.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
              const SizedBox(height: 20,),
              if (errorMessage.isNotEmpty) ...[
                const SizedBox(height: 20,),
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ],
              const SizedBox(height: 20,),
              const Text('or Sign in with:', style: TextStyle(fontSize: 15,color: Colors.white)),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/goggle.png', width: 50, height: 50),
                  Image.asset('assets/images/fb.png', width:50, height: 50),
                  Image.asset('assets/images/x.png', width: 50, height:50),
                ],
              ),
              const SizedBox(height: 50,),
              const Text("Didn't have an account!  Sign up", style: TextStyle(fontSize: 15,color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
