import 'package:flutter/material.dart';

class NewsLogo extends StatelessWidget {
  final double size;
  const NewsLogo({super.key, this.size = 150});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Icon(Icons.newspaper, color: Colors.white, size: size * 0.6),
      ),
    );
  }
}
