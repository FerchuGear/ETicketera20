import 'package:flutter/material.dart';
import 'package:eticketera20/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>(); 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inputs y Forms'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: myFormKey,
            child: Column(
              children: [
                const CustomInputField(labelText: 'Nombre', hintText: 'Nombre del usuario', formProperty: 'first_name', formValues: {},), 
                const SizedBox(height: 30,),
                const CustomInputField(labelText: 'Apellido', hintText: 'Apellido del usuario', formProperty: 'last_name', formValues: {},), 
                const SizedBox(height: 30,),
                const CustomInputField(labelText: 'Email', hintText: 'Correo del usuario', keyboardType: TextInputType.emailAddress, formProperty: 'email', formValues: {},), 
                const SizedBox(height: 30,),
                const CustomInputField(labelText: 'Contraseña', hintText: 'Contraseña del usuario', obscureText: true, formProperty: 'password', formValues: {},), 
                const SizedBox(height: 30,),

              DropdownButtonFormField(
                items: const [
                  DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                  DropdownMenuItem(value: 'Superuser', child: Text('Superuser')),
                  DropdownMenuItem(value: 'Developer', child: Text('Developer')),
                  DropdownMenuItem(value: 'Jr. Developer', child: Text('Jr. Developer')),
                ], 
                onChanged: (value) {
                  print(value);
                  
                },
              ),
                const SizedBox(height: 5),
                ElevatedButton(
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(child: Text('Guardar'))
                  ),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                   if (! myFormKey.currentState!.validate()) {
                    return;
                   }
                   
                  }, 
                )
                
              ],
            ),
          ),
        ),
      )
    );
  }
}