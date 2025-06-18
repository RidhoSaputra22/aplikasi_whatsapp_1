import 'package:flutter/material.dart';

class MetaAICircle extends StatelessWidget {
  const MetaAICircle({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFF5F5FFF), Color(0xFF8A2BE2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Color(0xFFF0F2F5),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
