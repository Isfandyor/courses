import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  static String fullname = "";

  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();

  String? name;

  String? lastName;

  String? phoneNumber;

  Future<void> saveString(Map<String, dynamic> json) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("user_data", jsonEncode(json));
  }

  Future<Map<String, dynamic>> getString() async {
    var prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString("user_data") ?? jsonEncode({}));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getString(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          Map<String, dynamic>? userData = snapshot.data;
          if (userData != null) {
            name = userData["name"];
            lastName = userData["lastname"];
            phoneNumber = userData["phone_number"];

            ProfilePage.fullname = "$name $lastName";
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 110,
                        height: 110,
                        child: Stack(
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 50,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.camera_alt),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      "Your name",
                      style: TextStyle(
                        fontSize: 15,
                        height: 2.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFormField(
                      initialValue: name,
                      onSaved: (value) {
                        name = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "Isfandiyor",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Your lastname",
                      style: TextStyle(
                        fontSize: 15,
                        height: 2.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFormField(
                      initialValue: lastName,
                      onSaved: (value) {
                        lastName = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your lastname';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Obidov',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Phone number",
                      style: TextStyle(
                        fontSize: 15,
                        height: 2.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFormField(
                      initialValue: phoneNumber,
                      onSaved: (value) {
                        phoneNumber = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (value.contains(
                            RegExp(r"^\+998 \d{2} \d{3} \d{2} \d{2}"))) {
                          return "Please enter a valid phone number";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "+998 ** *** ** **",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                              style: FilledButton.styleFrom(
                                fixedSize: const Size(double.infinity, 40),
                                backgroundColor: Colors.blue,
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  saveString({
                                    "name": name,
                                    "lastname": lastName,
                                    "phone_number": phoneNumber,
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Form saved')),
                                  );
                                  setState(() {});
                                }
                              },
                              child: const Text("Save")),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
