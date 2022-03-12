import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care/app/widgets/text_field_container.dart';


// ignore: must_be_immutable
class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final controller;
  bool showPassword;
  VoidCallback showPassBtn;

  RoundedPasswordField({
    required this.onChanged,
    this.controller,
    this.showPassword = false,
    required this.showPassBtn,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      
      child: TextFormField(
        validator: (String? value){
          if(value == null || value.trim().isEmpty){
            return 'Campo requerido';
          }
          if(value.length < 6) {
            return 'Minimo 6 caracteres';
          }
          return null;
        },
        obscureText: !showPassword,
        controller: controller,
        onChanged: onChanged,
        cursorColor: Get.theme.primaryColorLight,
        decoration: InputDecoration(
          hintText: "Contraseña",
          // fillColor: Colors.blueAccent,
          // filled: true,
          icon: Icon(
            Icons.lock,
            color: Get.theme.primaryColorLight,
          ),
          suffixIcon: IconButton(icon: Icon(
            Icons.visibility,
            color: Get.theme.primaryColorLight,
            ),
            onPressed: showPassBtn,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}