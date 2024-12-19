import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final int id;
  final String hintText;
  final String name;
  bool obscureText;
  TextInputType keyboardType;
  final TextEditingController controller;
  CustomTextFormField({
    super.key,
    required this.id,
    required this.hintText,
    required this.keyboardType,
    required this.name,
    this.obscureText = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 300,
          child: TextFormField(
            cursorColor: Colors.deepOrange,
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 15),
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.deepOrange,
                      width: 2,
                    ))),
          ),
        ),
      ],
    );
  }
}
