import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/auth_api_managing.dart';
import 'package:inscri_ecommerce/model/user/register_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() =>
      _SignUpPageState(); //_SignUpPageState est l'etat du widget signuppage
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool _obscureText = true; //caché le mot de passe
  bool _obscureConfirmText = true; //caché confirm mp
  late RegisterRequestModel requestModel;              //****


  @override
  void initState(){
    super.initState();
    requestModel =new RegisterRequestModel();          //********
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(0, 237, 194, 245),
              const Color.fromARGB(255, 220, 167, 245)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                      ),
                      SizedBox(height: 20),

                      // name Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "username",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your username'
                            : null,
                        onChanged: (value) {
                          setState(() => name = value);
                        },
                        onSaved: (value) =>requestModel.name =value!,             //**********
                      ),
                      SizedBox(height: 15),

                      // Email Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email ",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your email '
                            : null,
                        onChanged: (value) {
                          setState(() => email = value);
                        },
                        onSaved: (value) =>requestModel.email =value!,             //**********
                      ),
                      SizedBox(height: 15),

                      // Password Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() => _obscureText = !_obscureText);
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        obscureText: _obscureText,
                        validator: (value) => value!.length < 6
                            ? 'Password must be at least 6 characters'
                            : null,
                        onChanged: (value) {
                          setState(() => password = value);
                        },
                        onSaved: (value) => requestModel.password = value !,
                      ),
                      SizedBox(height: 15),

                      // Confirm Password Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureConfirmText
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() =>
                                  _obscureConfirmText = !_obscureConfirmText);
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        obscureText: _obscureConfirmText,
                        validator: (value) =>
                            value != password ? 'Passwords do not match' : null,
                        onChanged: (value) {
                          setState(() => confirmPassword = value);
                        },
                        onSaved: (value) => requestModel.password_confirmation= value !,
                      ),
                      SizedBox(height: 10),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text("Forgot Password?",
                              style: TextStyle(color: Colors.purple)),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Sign Up Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          if(validateAndSave()){
                            API api =new API();
                            api.Register(requestModel);
                            print(requestModel.toJson());
                          }
                        },
                        child: Text("Sign Up",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      SizedBox(height: 10),

                      // Already have an account?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? "),
                          TextButton(
                            onPressed: () {},
                            child: Text("Login",
                                style: TextStyle(color: Colors.purple)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  bool validateAndSave(){      //******************
    final form =_formKey.currentState;
    if(form?.validate() ?? false){
      form?.save();
      return true;
    }
    return false;
  }
}
