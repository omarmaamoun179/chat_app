import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.onTap, required this.text, Key? key});
  String? text;
  VoidCallback? onTap;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: double.infinity,
        decoration: BoxDecoration(
        
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            text!,
            style: TextStyle(fontSize: 20, color: Colors.blue[400]),
          ),
        ),
      ),
    );
  }
}
