import 'package:cleaning_service/screens/login&signUp/sign_up_screen.dart';
import 'package:cleaning_service/screens/splash%20screen/welcome_screen.dart';
import 'package:cleaning_service/widgets/app_bottom_button.dart';
import 'package:cleaning_service/widgets/input_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../colors/colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool loading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  bool value = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(shrinkWrap: true, children: [
          Image(
            image: AssetImage('assets/login logo.PNG'),
          ),

          Form(
            key: formKey,
            child: Column(
              children: [
                UserInputField(
                  title: "Email",
                  icon: Icons.email_outlined,
                  controller: emailcontroller,
                  inputType: TextInputType.emailAddress,
                  validation_text: "Enter Email",
                ),
                UserInputField(
                  title: "Password",
                  icon: Icons.lock,
                  controller: passcontroller,
                  inputType: TextInputType.visiblePassword,
                  validation_text: "Enter Password",
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(border: Border.all(color: blueColor)),
                child: Checkbox(
                  value: value,
                  onChanged: (bool? value1) {
                    setState(() {
                      this.value = value1!;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Remember me ',
                style: TextStyle(fontSize: 17.0),
              ),
            ],
          ),
          // Spacer(),
          BottomButton(
              title: "Sign In",
              isloading: loading,
              onPress: () {
                setState(() {
                  loading = true;
                });

                if (formKey.currentState!.validate()) {
                  auth
                      .createUserWithEmailAndPassword(
                          email: emailcontroller.text.toString(),
                          password: passcontroller.text.toString())
                      .then((value) {
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackError) {
                    setState(() {
                      loading = false;
                    });
                  });

                  ;
                } else {}

                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const WelcomeScreen()));
              }),
          Center(
            child: Text(
              "Forget the password?",
              style: TextStyle(
                  color: blueColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 5, top: 10),
            child: OutlinedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logo_dev,
                      color: TextColor,
                    ),
                    Text(
                      "Continue With Google",
                      style: TextStyle(
                          fontSize: 18, letterSpacing: 2, color: blueColor),
                    ),
                  ],
                )),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Not a member?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                        color: blueColor,
                        fontWeight: FontWeight.w800,
                        decoration: TextDecoration.underline,
                      ),
                    ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
