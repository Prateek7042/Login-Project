import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const Button({super.key,
    required this.label,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      width: MediaQuery.of(context).size.width *.94,
      height: 60,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
              foregroundColor: MaterialStateProperty.all(Colors.white)
          ),
          onPressed: onPressed,
          child: Text(label)),
    );
  }
}