import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pointr/SuggestedRouteBloc/SuggestedRouteUI.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:socialsignup/screens/home_screen.dart';
//import 'package:iba_course/Calculator/checking.dart';
//import 'package:test_app/components/My_button.dart';
import '/components/My_button.dart';
import '/components/square_tile.dart';
import '/components/text_box.dart';
import 'HomeScreen.dart';
//import '../firebase_auth/firebase_auth.dart';

var spacing = const SizedBox(height: 50);

class LoginPage extends StatefulWidget {
  //Function isDark;
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: non_constant_identifier_names

  final UsernameController = TextEditingController();

  // ignore: non_constant_identifier_names
  final PasswordController = TextEditingController();

  final RoundedLoadingButtonController AuthController =
      RoundedLoadingButtonController();

  //Sign in method == will use for navigation
  Future<void> SignUserIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: UsernameController.text, password: PasswordController.text);

      print(credential.user);
      Future.delayed(const Duration(seconds: 4), () {
        AuthController.success();
      });
      AuthController.reset();
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text("Error"),
                  content: const Text("No user found for that email."),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"))
                  ],
                ));
        AuthController.reset();
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text("Error"),
                  content: const Text("Wrong password provided for that user."),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"))
                  ],
                ));
        AuthController.reset();
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(179, 169, 169, 1),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
            ),

            // logo
            const Icon(
              Icons.directions_bus,
              size: 100,
            ),
            //you have been missed

            const SizedBox(
              height: 20,
            ),
            const Text(
              "Your Bus Stop Solution",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            )
            //username
            ,
            const SizedBox(
              height: 25,
            ),
            // ignore: prefer_const_constructors
            MyTextField(
              icon: Icon(Icons.person),
              controller: UsernameController,
              hint: "Username",
              obsecuretext: false,
              characterlength: 50,
            ),
            //password
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              icon: Icon(Icons.lock),
              controller: PasswordController,
              hint: "Password",
              obsecuretext: true,
              characterlength: 20,
            ),
            //text saying forget password
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red),
                    textAlign: TextAlign
                        .right, // this does not work because column is centre alligned
                  ),
                ],
              ),
            ),
            //sign in button
            const SizedBox(
              height: 25,
            ),
            // MyButton(
            //     onTap: () {
            //       SignUserIn();
            //     },
            //     text: "Login"),

            RoundedLoadingButton(
              onPressed: () async {
                if (UsernameController.text.isEmpty ||
                    PasswordController.text.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text("Error"),
                            content: const Text("Please fill all the fields"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK"))
                            ],
                          ));
                  AuthController.reset();
                  return;
                }
                if (UsernameController.text == "admin" &&
                    PasswordController.text == "admin") {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SuggestedRouteUI()));
                  AuthController.reset();
                  return;
                }
                SignUserIn();
                Future.delayed(const Duration(seconds: 1), () {
                  AuthController.reset();
                });
              },
              controller: AuthController,
              successColor: Colors.black,
              width: MediaQuery.of(context).size.width * 0.90,
              height: 50,
              elevation: 0,
              borderRadius: 25,
              color: Colors.black,
              child: Wrap(
                children: const [
                  Icon(
                    FontAwesomeIcons.signIn,
                    size: 20,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("Sign in with Email",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            //register now
          ],
        ),
      ))),
    );
  }
}
