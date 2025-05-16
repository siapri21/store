import 'package:flutter/material.dart';
import 'package:store/services/auth_api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  
 final Map<String, String> _type = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.yellow,
      // alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical:  100),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'votre email',
                icon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
                   // conserver la saisie
              // value représente la saisie
              onChanged: (value) {
                _type['email'] = value;
              },
            ),
            
            TextFormField(
            decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'votre mot de passe',
            icon: Icon(Icons.lock),
            border: OutlineInputBorder(),
            suffixIcon: IconButton(icon: Icon(Icons.visibility), onPressed: (){})
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
             onChanged: (value) {
                _type['password'] = value;
              },
         ),
            
           
            ElevatedButton(
              onPressed: () {
                // si le formulaire est valide
                if (_formKey.currentState!.validate()) {
                  // sauvegarder la saisie
                  _formKey.currentState!.save();

                  // inspect(_type);

                  // authentification
                  final authApiService = AuthApiService();
                  dynamic _ = authApiService.getAuth(_type).onError((
                    error,
                    stackTrace,
                  ) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Credentials error')),
                    );
                    return {};
                  });

                  // inspect(auth);
                  // si une erreur est renvoyée
                  // inspect(auth is Error);
                  // if (auth is Error) {
                  //   // afficher un message d'erreur
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Credentials error')),
                  //   );
                  // }
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}