import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pointr/SuggestedRouteBloc/SuggestedRouteUI.dart';
import 'package:pointr/components/constants.dart';
// import 'package:get/get.dart';
// import 'package:mintrewards/Screens/SignUp.dart';
// import 'package:mint_partner/classes/partner.dart';
// import '../screens/home.dart';
// import 'register/register1.dart';
// import '../utils/extraWidgets.dart';
// import '../utils/utils.dart';
import 'HomeScreen.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static final TextEditingController ecnt = TextEditingController();
  static final TextEditingController pcnt = TextEditingController();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void dispose() {
    super.dispose();
    Login.pcnt.clear();
  }

  final formKey = GlobalKey<FormState>();
  login() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: Login.ecnt.text, password: Login.pcnt.text);

      print(credential.user);
      // Future.delayed(const Duration(seconds: 4), () {
      //   // AuthController.success();
      // });
      // AuthController.reset();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Logging in your account...'),
              ],
            ),
          );
        },
      );
      Future.delayed(const Duration(seconds: 2), () async {
        // Hide the dialog
        Navigator.of(context).pop();
        // Perform further actions after login
        // e.g., navigate to a new screen
        await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                    "Error",
                    style: TextStyle(color: Colors.red),
                  ),
                  content: const Text("No user found for that email."),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"))
                  ],
                ));
        // AuthController.reset();
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title:
                      const Text("Error", style: TextStyle(color: Colors.red)),
                  content: const Text("Wrong password provided for that user."),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"))
                  ],
                ));
        // AuthController.reset();
        print('Wrong password provided for that user.');
      }
    }
  }

  bool loading = false;
  bool obscurePw = true;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      // bg image
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/tile-light.png'),
          repeat: ImageRepeat.repeat,
          scale: 1,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            //logo
            // Extrawidgets().Logo(100, 40),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Image.asset(
                'assets/images/transport.png', // Replace with your image path
                width: 150,
                height: 150,
              ),
            ),
            //you have been missed

            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "Your Bus Stop Solution!",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
            //username
            ,
            const SizedBox(
              height: 25,
            ),
            // login form
            Card(
              color: const Color(0xffEBFFF8),
              elevation: 6,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // text ("Login")
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            fontFamily: 'Barlow',
                            color: Color(0xff151515),
                          ),
                        ),
                      ),
                    ),
                    // form
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            // email
                            TextFormField(
                              controller: Login.ecnt,
                              validator: (value) {
                                if (value?.isValidEmail() ?? false) return null;
                                return 'Incorrect email address';
                              },
                              readOnly: loading,
                              decoration: const InputDecoration(
                                  labelText: 'Email address',
                                  prefixIcon: Icon(Icons.alternate_email),
                                  errorMaxLines: 3),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            // pw
                            TextFormField(
                              controller: Login.pcnt,
                              validator: (value) => (value?.length ?? 0) > 5
                                  ? null
                                  : "The password is too short.",
                              obscureText: obscurePw,
                              readOnly: loading,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.password),
                                suffixIcon: IconButton(
                                  onPressed: () =>
                                      setState(() => obscurePw = !obscurePw),
                                  icon: Icon(
                                    obscurePw
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // button
                    loading
                        ? const Dialog(
                            insetPadding: EdgeInsets.symmetric(vertical: 24),
                            child: LinearProgressIndicator(
                                color: Color(0xffFE6E25)),
                          )
                        : Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              onPressed: () {
                                if (Login.ecnt.text == "admin@gmail.com" &&
                                    Login.pcnt.text == "admin123") {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SuggestedRouteUI(),
                                      ),
                                      (route) => false);
                                } else if (formKey.currentState!.validate())
                                  login();
                              },
                              style: const ButtonStyle(
                                foregroundColor:
                                    MaterialStatePropertyAll(Colors.white),
                                backgroundColor:
                                    MaterialStatePropertyAll(Color(0xffFE6E25)),
                                minimumSize: MaterialStatePropertyAll(
                                  Size(100, 50),
                                ),
                              ),
                              child: const Text("Login"),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            // text w link
            Center(
              child: InkWell(
                // onTap: () => {
                //   // Get.off(() => const SignUp()),
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => SignUp()))
                // },
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "New user? ",
                        style: TextStyle(
                            color: Color(0xff151515), fontFamily: 'Cabin'),
                      ),
                      TextSpan(
                          text: "Create a new account",
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color(0xffFE6E25),
                              fontFamily: 'Cabin'),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {
                                  // // Get.off(() => const SignUp()),
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => SignUp()))
                                } //Get.off(() => const Register1()),
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
