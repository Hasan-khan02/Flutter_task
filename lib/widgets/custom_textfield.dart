import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

final TextEditingController controller;
final String hint;
final bool obscure;
final String? Function(String?) validator;

const CustomTextField({
super.key,
required this.controller,
required this.hint,
required this.obscure,
required this.validator
});

@override
Widget build(BuildContext context) {

return TextFormField(

controller: controller,

obscureText: obscure,

validator:(value){

return validator(
value!
);

},

decoration: InputDecoration(

hintText: hint,

border:
OutlineInputBorder(),

),

);

}
}