import 'package:flutter/material.dart';
import '../services/validator_service.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState
    extends State<RegistrationScreen> {

  final formKey = GlobalKey<FormState>();

  TextEditingController first =
      TextEditingController();

  TextEditingController last =
      TextEditingController();

  TextEditingController email =
      TextEditingController();

  TextEditingController password =
      TextEditingController();

  TextEditingController confirm =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Register"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Form(

          key: formKey,

          child: Column(

            children: [

              TextFormField(
                controller: first,
                validator: (v) =>
                    ValidatorService.validateEmpty(v!),

                decoration: const InputDecoration(
                  labelText: "First Name",
                  hintText: "Enter First Name",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: last,
                validator: (v) =>
                    ValidatorService.validateEmpty(v!),

                decoration: const InputDecoration(
                  labelText: "Last Name",
                  hintText: "Enter Last Name",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: email,
                validator: (v) =>
                    ValidatorService.validateEmail(v!),

                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "example@gmail.com",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height:15),

              TextFormField(
                controller: password,
                obscureText: true,
                validator: (v) =>
                    ValidatorService.validatePassword(v!),

                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Enter Password",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height:15),

              TextFormField(
                controller: confirm,

                validator: (v){

                  if(v != password.text){
                    return "Password mismatch";
                  }

                  return null;
                },

                decoration: const InputDecoration(
                  labelText: "Confirm Password",
                  hintText: "Enter Password Again",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height:20),

              ElevatedButton(

                onPressed:(){

                  if(formKey.currentState!
                      .validate()){

                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(
                        content: Text(
                            "Registration Success"),
                      ),

                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:(context)=>
                        const LoginScreen(),
                      ),
                    );
                  }
                },

                child:
                const Text("Register"),
              )

            ],
          ),
        ),
      ),
    );
  }
}