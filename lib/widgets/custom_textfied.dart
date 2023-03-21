import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    required this.message,
    this.onChanged,
    required this.hinText,
    required this.icon , 
  });
  String? hinText, message;

  Icon icon; 

  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      validator: (data) {
        if (data!.isEmpty) {
          return message;
        }
      },
    
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: icon ,
        fillColor: Colors.white,
        hintText: hinText,
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CustomTextFormFieldpassword extends StatefulWidget {
  CustomTextFormFieldpassword({
    required this.message,
    required this.onChanged,
    required this.hinText,
  });
  String? hinText, message;
  Function(String) onChanged;

  @override
  State<CustomTextFormFieldpassword> createState() =>
      _CustomTextFormFieldpasswordState();
}

class _CustomTextFormFieldpasswordState
    extends State<CustomTextFormFieldpassword> {
  bool obsecure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return widget.message;
        }
      },
      onChanged: widget.onChanged,
      obscureText: obsecure,
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: widget.hinText,
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obsecure = !obsecure;
            });
          },
          child: obsecure ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
