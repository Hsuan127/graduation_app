import 'package:flutter_app/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screen/home_screen.dart';
import 'package:flutter_app/screen/signup_screen.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/utils/flutterfire.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isPasswordType = true;

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexStringToColor('FFC107'),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  10, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                children: <Widget>[
                  logoWidget("images/pets.jpg"),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    // new way of email text field
                    controller: _emailTextController,
                    cursorColor: Colors.white10,
                    style: TextStyle(
                        color: hexStringToColor('ffffff').withOpacity(0.9)),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: hexStringToColor('ffffff'),
                      ),
                      labelText: 'Enter Your Email',
                      labelStyle: TextStyle(
                          color: hexStringToColor('ffffff').withOpacity(0.9)),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: hexStringToColor('ffffff').withOpacity(0.3),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexStringToColor('ffffff')),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    // new way of email text field
                    controller: _passwordTextController,
                    obscureText: true,
                    cursorColor: Colors.white10,
                    style: TextStyle(
                        color: hexStringToColor('ffffff').withOpacity(0.9)),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: hexStringToColor('ffffff'),
                      ),
                      labelText: 'Enter Your Password',
                      labelStyle: TextStyle(
                          color: hexStringToColor('ffffff').withOpacity(0.9)),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: hexStringToColor('ffffff').withOpacity(0.3),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexStringToColor('ffffff')),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  signInSignUpButton(context, true, () async {
                    bool isNavigator = await signIn(
                        _emailTextController.text.trim(),
                        _passwordTextController.text.trim());
                    if (isNavigator) {
                      print("Successfully Signed In");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }
                  }),
                  signUpOption(),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have account? ",
          style: TextStyle(color: hexStringToColor('212121')),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
                color: hexStringToColor('212121'), fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
