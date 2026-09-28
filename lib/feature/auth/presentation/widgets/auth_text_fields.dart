import 'package:flutter/material.dart';
import 'package:to_do_app/core/app_constants/app_fonts.dart';

enum AuthTextFieldTypes { name, email, password }

class AuthTextFields extends StatefulWidget {
  const AuthTextFields({
    super.key,
    required this.controller,
    required this.type,
    required this.hintText,
  });
  final TextEditingController controller;
  final AuthTextFieldTypes type;
  final String hintText;

  @override
  State<AuthTextFields> createState() => _AuthTextFieldsState();
}

class _AuthTextFieldsState extends State<AuthTextFields> {
  bool isHidden = true;
  String? emailValidator(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Email is Required";
    }
    final emailRegex = RegExp( r'^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(txt.trim())) {
      return "Enter valid email";
    }
    return null;
  }

  String? passValidator(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Password is Required";
    }
    if (txt.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(txt.trim()) &&
        RegExp(r'[a-z]').hasMatch(txt.trim()) &&
        RegExp(r'[0-9]').hasMatch(txt.trim())) 
        {
          return null ;
        }
    return 'Password must be at least 8 characters and include an uppercase letter, a lowercase letter, and a number.';
  }
 String? nameValidator(String? txt){
  if(txt == null || txt.isEmpty){
    return "Name is required";
  }
  return null;
 }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextFormField(
        obscureText: widget.type == AuthTextFieldTypes.password
            ? isHidden
            : false,
        controller: widget.controller,
        validator: widget.type == AuthTextFieldTypes.name ? (value) =>nameValidator(value):(widget.type == AuthTextFieldTypes.email
                  ? (value)=>emailValidator(value)
                  : (value)=> passValidator(value)) ,
        keyboardType: widget.type == AuthTextFieldTypes.name
            ? TextInputType.text
            : (widget.type == AuthTextFieldTypes.email
                  ? TextInputType.emailAddress
                  : TextInputType.visiblePassword),
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.type == AuthTextFieldTypes.name
                ? Icons.person_2_outlined
                : widget.type == AuthTextFieldTypes.email
                ? Icons.mail_outline
                : Icons.lock_outline,
          ),
          errorMaxLines: 3,
          label: Text(
            widget.type == AuthTextFieldTypes.name
                ? "Full Name"
                : (widget.type == AuthTextFieldTypes.email
                      ? "Email Address"
                      : "Password"),
            style: AppFonts.gray12Bold,
          ),
          hintText: widget.hintText,
          hintStyle: AppFonts.gray16Light,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          suffixIcon: widget.type == AuthTextFieldTypes.password
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                  icon: Icon(
                    isHidden ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
