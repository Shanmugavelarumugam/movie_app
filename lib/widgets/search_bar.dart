import 'package:flutter/material.dart';

class SeachBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onSubmitted;

  const SeachBar({
    super.key,
    required this.hintText,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[900],
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white70),
          prefixIcon: const Icon(Icons.search, color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
