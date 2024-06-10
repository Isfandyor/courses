import 'package:flutter/material.dart';

class MyTextFiled extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FocusNode focusNode;
  const MyTextFiled({
    super.key,
    required this.label,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
            height: 3,
            color: Color.fromARGB(222, 255, 255, 255),
          ),
        ),
        TextFormField(
          keyboardAppearance: Brightness.dark,
          keyboardType: keyboardType,
          obscureText: keyboardType == TextInputType.visiblePassword,
          controller: controller,
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 16,
            letterSpacing: keyboardType == TextInputType.name ? 0.1 : 2,
          ),
          validator: (value) {
            if (keyboardType == TextInputType.name) {
              if (value == null || value.trim().isEmpty) {
                return "Username xato!";
              }
            } else {
              if (value == null || value.trim().isEmpty) {
                return "Password xato!";
              }
            }

            return null;
          },
          decoration: InputDecoration(
            fillColor: const Color(0xff1D1D1D),
            filled: true,
            hintText: hintText,
            border: const OutlineInputBorder(),
            hintStyle: TextStyle(
              fontSize: 16,
              color: const Color(0xff535353),
              letterSpacing: keyboardType == TextInputType.name ? 0.2 : 2,
              fontFamily: 'Lato',
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xff979797),
                width: 0.8,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xff979797),
                width: 0.8,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
