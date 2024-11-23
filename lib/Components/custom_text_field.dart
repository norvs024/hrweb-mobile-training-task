import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isPassword; // Renamed for clarity

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    this.controller,
    this.keyboardType,
    this.isPassword = false, // Default to false
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false; // Track visibility
  bool _isFieldEmpty = true;

   @override
  void initState() {
    super.initState();

    // Add listener to the controller to monitor changes
    widget.controller?.addListener(() {
      setState(() {
        _isFieldEmpty = widget.controller!.text.isEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? !_isPasswordVisible : false, // Manage visibility
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(widget.prefixIcon),
        suffixIcon: widget.isPassword && !_isFieldEmpty
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
                  });
                },
              )
            : null,
      ),
    );
  }
}
