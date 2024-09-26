import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.onPressed, required this.child});

  final Function() onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff516527),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        child: child,
      ),
    );
  }
}

class SimpleButton extends StatelessWidget {
  const SimpleButton({super.key, required this.onPressed, required this.child});

  final Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xff516527),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        child: child,
      ),
    );
  }
}
