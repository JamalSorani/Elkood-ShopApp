import 'package:flutter/material.dart';

class WhiteBackground extends StatelessWidget {
  const WhiteBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: child,
      ),
    );
  }
}

class ShowMessage extends StatelessWidget {
  const ShowMessage({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return WhiteBackground(
      child: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 25,
        ),
      ),
    );
  }
}
